function [y, alpha, beta, gamma, W] = restSGME_Sens(Y, x,lambda, kappa, filtersetname,hnuclei,nbandas,varargin )
%
%  restSGME_Sens Reconstructs a HR MS image from observed LR MS and
%  pansharpening images using SG priors
%
% input arguments:
%
%       Y               Multi-spectral observed image
%       x               Panchromatic observed image
%       lambda          lambda parameters
%       kappa           cell array with kappa_f rho_f and alpha_f functions
%                       needed to estimate SG prior parameters
%       filtersetname   'none'  or 'fohv'  or 'fo'
%       hnuclei         convolution nucleus for blurring
%       nbandas         number of MS bands
%       varargin         
%       _________________________________________
%       
%       eps_map         Algorithm convergence rate 
%       itmax_map       maximum iterations number
%       itmim_map       minimum iterations number
%       _________________________________________
%       
%       gamma_alpha     Confidence parameter for alphas' Gamma hyperprior.
%                       If gamma_alpha == 0 Gamma hyperprior is not used.
%       gamma_beta      Confidence parameter for betas' Gamma hyperprior.
%                       If gamma_alpha == 0 Gamma hyperprior is not used.%       
%       gamma_gamma     Confidence parameter for gamma' Gamma hyperprior.
%                       If gamma_alpha == 0 Gamma hyperprior is not used.% output arguments:
%       alpha_mode      Mode (reference value) of alphas' Gamma hyperprior.
%       beta_mode       Mode (reference value) of betas' Gamma hyperprior.      
%       gamma_mode      Mode (reference value) of gamma' Gamma hyperprior.
%       _________________________________________
%       
%       eps_y           Convergence rate for Conjugate Gradient (CG)
%       itmax_y         maximum iterations number for CG
%
% output arguments:
%
%       y               HR MS image
%       alpha           Estimated alpha parameter values
%       beta            Estimated betha parameter values
%       gamma           Estimated gamma parameter value
%       W               Cell array of estimated diagonal of weights'
%                       matrices
%
% Pérez-Bueno, F., Vega, M., Mateos, J., Molina, R., & Katsaggelos, A. K. (2020). 
% Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors. Sensors, 20(18), 5308.  

show=false;
verbose = true;
eps_map=1.e-04;
itmin_map=2;
itmax_map=100;
eps_y=1.0e-07;
itmax_y=30;

Y = double(Y);
x = double(x);
%nbandas = size(Y,3);
lr_size = size(Y(:,:,1));
hr_size= size(x);
SRratio=fix(hr_size(1)/lr_size(1));

% filters
    
    filters = getfilters(filtersetname);
    nfilters = numel(filters); 

    epsW=mean(Y(:))*1.0e-05;
    
vec=ones(nbandas,1);

gamma_alpha=0.0*vec;
gamma_beta=0.0*vec;
gamma_gamma=0.0;
beta_mode=1.0*vec;
gamma_mode=1.0;

alpha_mode=cell(nfilters,1);
for i = 1:nfilters
    alpha_mode{i} = vec;
end

switch (nargin)
    case 10
        eps_map=varargin{1};
        itmax_map=varargin{2};
        itmim_map=varargin{3};
    case 16
        eps_map=varargin{1};
        itmax_map=varargin{2};        
        itmin_map=varargin{3};
        gamma_alpha=varargin{4};
        gamma_beta=varargin{5};
        gamma_gamma=varargin{6};
        alpha_mode=varargin{7}; 
        beta_mode=varargin{8};
        gamma_mode=varargin{9};
    case 18
        eps_map=varargin{1};
        itmax_map=varargin{2};        
        itmin_map=varargin{3};
        gamma_alpha=varargin{4};
        gamma_beta=varargin{5};
        gamma_gamma=varargin{6};
        alpha_mode=varargin{7}; 
        beta_mode=varargin{8};
        gamma_mode=varargin{9};
        eps_y = varargin{10};
        itmax_y = varargin{11};

end

disp('Parameters');

display(strcat('eps_map = ', sprintf(' %f', eps_map')));
display(strcat('itmax_map = ', sprintf(' %f', itmax_map')));

disp('Initializating...');

 
%% Display image  
if show    
    for ib=1:nbandas
        fig(ib) = figure(800+ib);
        fig(ib).Name = sprintf('Y(%d)',ib);
        imagesc(Y(:,:,ib)); colormap(gray); colorbar;   
        pause(0.01);
    end
end

%prior to centered blk_fft2
%

% filter kernels to centered blk_fft2
%
for nu = 1:nfilters
    filtersT{nu} = flip(flip(filters{nu},1),2);
    filterTfilter{nu} = conv2(filtersT{nu},filters{nu});
    Df{nu} = cent_nucleus2fft(filters{nu},hr_size(1), hr_size(2));
    Dft{nu} = cent_nucleus2fft(filtersT{nu},hr_size(1), hr_size(2));
    DftDf{nu}=cent_nucleus2blk_fft2(filterTfilter{nu},hr_size(1), hr_size(2),SRratio,SRratio);
end

DtD = blk_fft2_DtD(1,1,hr_size(1), hr_size(2),SRratio,SRratio);
if (iscell(hnuclei))
    for i=1:nbandas
        H{i} = cent_nucleus2blk_fft2(hnuclei{i}, hr_size(1), hr_size(2),SRratio,SRratio); %block-fourier
        Ht{i} = Tcent_nucleus2blk_fft2(hnuclei{i}, hr_size(1), hr_size(2),SRratio,SRratio); %block-fourier
        DtDH =  blk_fd_conv(DtD,H{i});
        HtDtDH{i} =  blk_fd_conv(Ht{i},DtDH);
    end
else
    H = cent_nucleus2blk_fft2(hnuclei, hr_size(1), hr_size(2),SRratio,SRratio); %block-fourier
    Ht = Tcent_nucleus2blk_fft2(hnuclei, hr_size(1), hr_size(2),SRratio,SRratio); %block-fourier
    DtDH =  blk_fd_conv(DtD,H);
    HtDtDH =  blk_fd_conv(Ht,DtDH);
end

clear DtDH   DtD;


 %% independent term
 %   display('indep_term...');
    indep_term_wo_gamma=zeros(hr_size(1),hr_size(2), nbandas, 1);
    indep_term_wo_beta=zeros(hr_size(1),hr_size(2), nbandas, 1);
    for i=1:nbandas
        indep_term_wo_gamma(:,:,i,1)= lambda(i)*x(:,:);
        if iscell(Ht)
            v=blk_fd_conv(Ht{i},blk_fft2(blk_DtY(Y(:,:,i),1,1,SRratio,SRratio)));
        else
            v=blk_fd_conv(Ht,blk_fft2(blk_DtY(Y(:,:,i),1,1,SRratio,SRratio)));
        end
        indep_term_wo_beta(:,:,i,1)= real( im_comp(blk_ifft2(v ),SRratio,SRratio));
    end
    
    
    clear Ht;
%% Intital values for some variables
y0 = imresize(Y,SRratio,'bicubic');

trgamma=0;
tralpha = zeros(nbandas,1);
trbeta = zeros(nbandas,1);

iter =0;
conv_crit=eps_map+1.0;


 %% Display image  
if show  
    for ib=1:nbandas
        fig(ib) = figure(900+ib);
        fig(ib).Name = sprintf('y(%d)',ib);
        imagesc(y0(:,:,ib)); colormap(gray); colorbar;   
        pause(0.01);
    end
end

y0 = convertToMBVec(y0);
y = convertToMBImg(y0,hr_size(1),hr_size(2),nbandas);

%% main loopitmin_map

while ((iter <= itmin_map) || ( (conv_crit > eps_map) && (iter < itmax_map) ))
    iter=iter+1;
    fprintf('iter = %d\n', iter);
    
    
    % Update parameters
        
    if verbose 
        disp('entrando en update_parameters');
    end
     
    [alpha,beta,gamma,W] = update_params(x,Y,H,y,lambda,...
        nfilters,Df,kappa,tralpha,trbeta,trgamma,SRratio,nbandas, ...
        gamma_alpha,gamma_beta,gamma_gamma,alpha_mode,beta_mode,gamma_mode,epsW);           
    
    if verbose 
        for nu=1:nfilters
            display(strcat(sprintf('alphas{%d} = ',nu), sprintf(' %e\t', alpha{nu}')));
        end
        display(strcat('betas = ', sprintf(' %e\t', beta')));
        display(strcat('gamma = ', sprintf(' %e', gamma')));
        disp('saliendo update_parameters');
    end

     %% independent term
    if verbose 
        disp('indep_term...');
    end
    indep_term = gamma*indep_term_wo_gamma;
    for i=1:nbandas
     indep_term(:,:,i,1) = indep_term(:,:,i,1) + beta(i) * indep_term_wo_beta(:,:,i,1);
    end
    indep_term= convertToMBVec(indep_term);
    
    fprintf('\tResolviendo ecuación\n');
    
    inv_cov = get_mic_handle(nfilters,Df,Dft,alpha,W,beta,HtDtDH,gamma,lambda,hr_size(1),hr_size(2),SRratio,nbandas);
    
    [y, flag_y,relres_y,iter_y ]=pcg(inv_cov, indep_term, eps_y, itmax_y,[], [], y0);
    fprintf('\tFlag: %d, RelRes: %d, Iters: %d\t\n',flag_y,relres_y,iter_y);
    
    
    % informacion de convergencias

    if(iter>1)
        conv_crit=sum((y(:)-y0(:)).*(y(:)-y0(:))) / sum(y0(:).*y0(:));
        conv(iter) = conv_crit;
        fprintf('\t||y-y0||^2/||y0||^2 = %d\n', conv(iter));
    end
    
    % Prepararse a la siguiente vuelta
    y0=y;
    
    % calculo trazas

    [tralpha, trbeta, trgamma] =calc_trazas(alpha,nfilters,DftDf,W,beta,HtDtDH,gamma,lambda,lr_size,SRratio,nbandas);

      
    y = convertToMBImg(y,hr_size(1),hr_size(2),nbandas);

    if show  
        for ib=1:nbandas
            fig(ib) = figure(900+ib);
            fig(ib).Name = sprintf('y(%d)',ib);
            imagesc(y(:,:,ib)); colormap(gray); colorbar;   
            pause(0.01);
        end
    end

end


end
% The end


function [E_alpha,E_beta,E_gamma,W] = update_params(x,Y,blk_fft2H,y,lambda,...
    nfilters,Df,kappa,tralpha,trbeta,trgamma,bkn,nbandas,...
    gamma_alpha,gamma_beta,gamma_gamma,alpha_mode,beta_mode,gamma_mode,epsW)

   [M, N , ~] = size(y);
    ysupport = M*N;
    observationsupport=ysupport/bkn/bkn;
    
    kappa_f=kappa{1};
    alpha_f=kappa{3};
   
    aux4=x;
    W = cell(nfilters,1);
    for nu=1:nfilters
        W{nu} = zeros(M,N,nbandas);
    end
    
    E_alpha = cell(nfilters,1);
    E_beta = zeros(nbandas,1);
    
    for i=1:nbandas
        % Calculate normprior
        for nu=1:nfilters
            xnu = ifft2( Df{nu} .* fft2(y(:,:,i)) );
            u = epsW + ( abs ( xnu .* xnu ) + tralpha(i)/ysupport).^0.5;
            W{nu}(:,:,i) = kappa_f(u);
            val = mean(W{nu}(:)) + eps;
            E_alpha{nu}(i) = (gamma_alpha(i))/alpha_mode{nu}(i) + (1-gamma_alpha(i))/alpha_f(val);
            E_alpha{nu}(i) = max(1/E_alpha{nu}(i),eps);
        end
        
         % Calculate Eg
        YB=blk_fft2(im_decomp(y(:,:,i),bkn,bkn));
        if iscell(blk_fft2H)
            norm = real(im_comp(blk_ifft2(blk_fd_conv(blk_fft2H{i},YB)),bkn,bkn));
        else
            norm = real(im_comp(blk_ifft2(blk_fd_conv(blk_fft2H,YB)),bkn,bkn));
        end
        norm=norm(1:bkn:end,1:bkn:end);
        err=Y(:,:,i)-norm;err = err.^2;
        err = sum(err(:));
        Eg = err+eps;
        
        E_beta(i)     =(gamma_beta(i))/beta_mode(i) + (1-gamma_beta(i))*(Eg+trbeta(i))/observationsupport;       
        E_beta(i)     = max(1/E_beta(i),eps);
        
        % gamma
        aux4(:,:) =aux4(:,:) - lambda(i)*y(:,:,i);
        
    end
    
    norma_gam= sum(sum(aux4.*aux4));
    E_gamma = (gamma_gamma)/gamma_mode + (1-gamma_gamma)*(norma_gam+trgamma)/ysupport;
    E_gamma=max(1/E_gamma,eps);
    

    
end

    function h = get_mic_handle(nfilters,filters,filtersT,alpha,W,beta,HtDtDH,gamma,lambda,nr,nc,bkn,nbandas)
            h = @mic;
            function Ay = mic(y)
                Ay = multiply_by_invcov(y,nfilters,filters,filtersT,alpha,W,beta,HtDtDH,gamma,lambda,nr,nc,bkn,nbandas);
            end
    end
    
    function Ay = multiply_by_invcov(y,nfilters,filters,filtersT, alpha,W,beta,HtDtDH,gamma,lambda,nr,nc,bkn,nbandas)

        yd = convertToMBImg(y,nr,nc,nbandas);
        
        Ay = zeros(nr,nc,nbandas);
        
        for i=1:nbandas
            ydbf = blk_fft2(im_decomp (yd(:,:,i),bkn,bkn ));
            
            if iscell(HtDtDH)
                v = beta(i)*im_comp( blk_ifft2 (blk_fd_conv(HtDtDH{i},ydbf)),bkn,bkn);
            else
                v = beta(i)*im_comp( blk_ifft2 (blk_fd_conv(HtDtDH,ydbf)),bkn,bkn);
            end
            %% Prior
            priorTerm = zeros(nr,nc);
            ydf=fft2(yd(:,:,i));
            for nu=1:nfilters
                temp = fft2( W{nu}(:,:,i) .* ifft2(filters{nu} .* ydf) );
                priorTerm = priorTerm + alpha{nu}(i) * ifft2( filtersT{nu} .* temp );
            end
            
            Ay(:,:,i) = v + priorTerm;
           
        end
        
        for i= 1:nbandas
            for j=1:nbandas
                Ay(:,:,i) = Ay(:,:,i) + gamma*lambda(i)*lambda(j)*yd(:,:,j);
            end
        end
        
        Ay = convertToMBVec(Ay);
    
    end
    
    function [trprior, trobs, trpancr] =calc_trazas(alpha,nfilters,DftDf,W,beta,HtDtDH,gamma,lambda,lr_size,SRratio,nbandas)
    
    Qinv = calc_cov(alpha,nfilters,DftDf,W,beta,HtDtDH,gamma,lambda,lr_size,SRratio,nbandas);
    
    [M N, ~] = size(W{1});
        
        trpancr=0;
        trprior = zeros(nbandas,1);
        trobs = zeros(nbandas,1);
        for i=1:nbandas
            for nu=1:nfilters
                trprior(i) = trprior(i) + blk_fd_trace(blk_fd_conv(Qinv(:,:,:,:,i,i), DftDf{nu}))/M/N;
            end
            if iscell(HtDtDH)
                trobs(i) = blk_fd_trace(blk_fd_conv(Qinv(:,:,:,:,i,i), HtDtDH{i}));
            else
                trobs(i) = blk_fd_trace(blk_fd_conv(Qinv(:,:,:,:,i,i), HtDtDH));
            end
            for j=1:nbandas
                trpancr= trpancr + lambda(i)*lambda(j)* blk_fd_trace(Qinv(:,:,:,:,i,j));
            end
        end
 
    end
    
    function Qinv=calc_cov(alpha,nfilters,DftDf,W,beta,HtDtDH,gamma,lambda,lr_size,SRratio,nbandas)
    
    % LAMBDA

    I = zeros(lr_size(1), lr_size(2), SRratio*SRratio,SRratio*SRratio);
    for i=1:SRratio*SRratio
        I(:,:,i,i)=ones(lr_size(1),lr_size(2));
    end
    Q= zeros(lr_size(1), lr_size(2), SRratio*SRratio,SRratio*SRratio, nbandas, nbandas);
    
    for i=1:nbandas
        if iscell(HtDtDH)
            Q(:,:,:,:,i,i)= gamma*lambda(i) * lambda(i)* I(:,:,:,:) + beta(i) * HtDtDH{i}  ;
        else
            Q(:,:,:,:,i,i)= gamma*lambda(i) * lambda(i)* I(:,:,:,:) + beta(i) * HtDtDH  ;
        end
        for nu=1:nfilters
            Wb=W{nu}(:,:,i);
            z = mean(Wb(:));
            Q(:,:,:,:,i,i)= Q(:,:,:,:,i,i) + alpha{nu}(i) *  z * DftDf{nu};
        end
        for j=i+1:nbandas
            Q(:,:,:,:,i,j) = gamma*lambda(i) * lambda(j)* I(:,:,:,:);
            Q(:,:,:,:,j,i) = Q(:,:,:,:,i,j);
        end
    end
    clear I;

    Qinv = permute(Q,[3 4 5 6 1 2]);
    clear Q;

    for i=1:size(Qinv,5)
        for j=1:size(Qinv,6)
            subQ=Qinv(:,:,:,:,i,j);
            subQ=permute(subQ,[1 3 2 4]);
            subQ=reshape(subQ,[nbandas*SRratio*SRratio nbandas*SRratio*SRratio]);
            subQ=inv(subQ);
            subQ= reshape(subQ,[SRratio*SRratio nbandas SRratio*SRratio nbandas]);
            subQ=permute(subQ,[1 3 2 4]);
            subQ= reshape(subQ,[SRratio*SRratio SRratio*SRratio nbandas nbandas]);
            Qinv(:,:,:,:,i,j)=subQ;
        end
    end
    Qinv= permute(Qinv,[5 6 1 2 3 4]);
    clear subQ;

    end