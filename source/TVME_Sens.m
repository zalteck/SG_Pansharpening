function [y  alpha beta gamma W] = TVME_Sens(Y, x,lambda,hnuclei,nbandas,varargin )
% TVME_Sens Reconstructs a HR MS image from observed LR MS and
%  pansharpening images using TV prior
%
% input arguments:
%
%       Y               Multi-spectral observed image
%       x               Panchromatic observed image
%       lambda          lambda parameters
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
%
% output arguments:
%
%       y               HR MS image
%       alpha           Estimated alpha parameter values
%       beta            Estimated betha parameter values
%       gamma           Estimated gamma parameter value
%       W               Estimated diagonal of weights'
%                       matrix
%
% M. Vega, J. Mateos, R. Molina, and A. K. Katsaggelos, “Super resolution of multispectral images using TV image models,” 
% in International Conference on Knowledge-Based and Intelligent Information and Engineering Systems, 2008, pp. 408–415.

show=false;
eps_map=1.e-04;
itmin_map=2;
itmax_map=100;
eps_y=1.0e-07;
itmax_y=30;

Y = double(Y);
x = double(x);
% nbandas = size(Y,3);
lr_size = size(Y(:,:,1));
hr_size= size(x);
SRratio=fix(hr_size(1)/lr_size(1));

% % normalizacion de las imagenes
%     [Y, x, facY, facx] = imageMENormalization( Y, x );

    epsW=1.0e-05;
    
vec=ones(nbandas,1);

gamma_alpha=0.0*vec;
gamma_beta=0.0*vec;
gamma_gamma=0.0;
alpha_mode=1.0*vec;
beta_mode=1.0*vec;
gamma_mode=1.0;

switch (nargin)
    case 8
        eps_map=varargin{1};
        itmax_map=varargin{2};
        itmim_map=varargin{3};
    case 14
        eps_map=varargin{1};
        itmax_map=varargin{2};        
        itmin_map=varargin{3};
        gamma_alpha=varargin{4};
        gamma_beta=varargin{5};
        gamma_gamma=varargin{6};
        alpha_mode=varargin{7};
        beta_mode=varargin{8};
        gamma_mode=varargin{9};
        
%         for i=1:nbandas
%             alpha_mode(i)=alpha_mode(i)*facY(i);
%             beta_mode(i)=beta_mode(i)*facY(i)*facY(i);
%         end
%         gamma_mode=gamma_mode*facx*facx;
end

display('Parameters');

display(strcat('eps_map = ', sprintf(' %f', eps_map')));
display(strcat('itmax_map = ', sprintf(' %f', itmax_map')));

display('Initializating...');

 
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

%H and V differences matrices to centered blk_fft2
%
DhtDh=[1 -2 1];
DvtDv=DhtDh';

DhtDh=cent_nucleus2blk_fft2(DhtDh,hr_size(1), hr_size(2),SRratio,SRratio);
DvtDv=cent_nucleus2blk_fft2(DvtDv,hr_size(1), hr_size(2),SRratio,SRratio);

%integration nucleus to centered blk_fft2
% given_hnucleus=ones(SRratio,SRratio)/SRratio/SRratio;
%given_hnucleus=padarray(given_hnucleus,[SRratio-1 SRratio-1],0,'post');
% H=cent_nucleus2blk_fft2(given_hnucleus, hr_size(1), hr_size(2),SRratio,SRratio); %block-fourier
% Ht=Tcent_nucleus2blk_fft2(given_hnucleus, hr_size(1), hr_size(2),SRratio,SRratio); %block-fourier
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
y0=zeros(hr_size(1),hr_size(2),nbandas);



[alpha,beta,gamma,W] = ini_params(x,Y,indep_term_wo_beta,indep_term_wo_gamma,nbandas,...
    gamma_alpha,gamma_beta,gamma_gamma,alpha_mode,beta_mode,gamma_mode,epsW); 

display(strcat('alphas = ', sprintf(' %f\t', alpha')));
display(strcat('  betas = ', sprintf(' %f\t', beta')));
display(strcat('gamma = ', sprintf(' %f', gamma')));
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



%% main loopitmin_map

while ((iter <= itmin_map) || ( (conv_crit > eps_map) && (iter < itmax_map) ))
    iter=iter+1;
    disp(sprintf('iter = %d', iter));
    
     %% independent term
    display('indep_term...');
    indep_term = gamma*indep_term_wo_gamma;
    for i=1:nbandas
     indep_term(:,:,i,1) = indep_term(:,:,i,1) + beta(i) * indep_term_wo_beta(:,:,i,1);
    end
    indep_term= convertToMBVec(indep_term);
    
    display(sprintf('\tResolviendo ecuación'));
    
%    y0l = convertToVec(y0);
    inv_cov = get_mic_handle(alpha,W,beta,HtDtDH,gamma,lambda,hr_size(1),hr_size(2),SRratio,nbandas);
    
    [y, flag_y,relres_y,iter_y ]=pcg(inv_cov, indep_term, eps_y, itmax_y,[], [], y0);
    disp(sprintf('\tFlag: %d, RelRes: %d, Iters: %d\t',flag_y,relres_y,iter_y));
    
    
    % informacion de convergencias

    if(iter>1)
        conv_crit=sum((y(:)-y0(:)).*(y(:)-y0(:))) / sum(y0(:).*y0(:));
        conv(iter) = conv_crit;
        disp(sprintf('\t||y-y0||^2/||y0||^2 = %d', conv(iter)));
    end
    
    % Prepararse a la siguiente vuelta
    y0=y;
    
    % calculo trazas

    [tralpha trbeta trgamma] =calc_trazas(alpha,DhtDh,DvtDv,W,beta,HtDtDH,gamma,lambda,lr_size,SRratio,nbandas);

      
    y = convertToMBImg(y,hr_size(1),hr_size(2),nbandas);
    % Update parameters
        
    disp('entrando en update_parameters');
     
    [alpha,beta,gamma,W] = update_params(x,Y,H,y,lambda,...
        tralpha,trbeta,trgamma,SRratio,nbandas, ...
        gamma_alpha,gamma_beta,gamma_gamma,alpha_mode,beta_mode,gamma_mode,epsW);           
    display(strcat('alphas = ', sprintf(' %f\t', alpha')));
    display(strcat('betas = ', sprintf(' %f\t', beta')));
    display(strcat('gamma = ', sprintf(' %f', gamma')));
    disp('saliendo update_parameters');

    if show  
        for ib=1:nbandas
            fig(ib) = figure(900+ib);
            fig(ib).Name = sprintf('y(%d)',ib);
            imagesc(y(:,:,ib)); colormap(gray); colorbar;   
            pause(0.01);
        end
    end

end

% Images back to their initial scale

%    [y, x, alpha, beta, gamma] = imagesBackInitScale(y, x, alpha, beta, gamma, facY, facx);

end
% The end

function [E_alpha,E_beta,E_gamma,W] = ini_params(x,Y,indep_term_wo_beta,indep_term_wo_gamma,nbandas,...
    gamma_alpha,gamma_beta,gamma_gamma,alpha_mode,beta_mode,gamma_mode,epsW)

    [M,N]=size(x);
    [y , alphaSAR , gamma] = restoreSAR(x , [1] ,1.e-06,100);
    alpha = alfaTVpvini(y,2);
    
    for i=1:nbandas
        [y , a , beta(i)] = restoreSAR(Y(:,:,i) , [1] ,1.e-06,100);
        E_alpha(i) = (gamma_alpha(i))/alpha_mode(i) + (1-gamma_alpha(i))/alpha;
        E_beta(i)     =(gamma_beta(i))/beta_mode(i) + (1-gamma_beta(i))/beta(i);

        E_alpha(i) = 1/E_alpha(i);
        E_beta(i)     = 1/E_beta(i);
    end
    E_gamma = (gamma_gamma)/gamma_mode + (1-gamma_gamma)/gamma;
    E_gamma=1/E_gamma;
    
    indep_term = E_gamma*indep_term_wo_gamma;
    for i=1:nbandas
     indep_term(:,:,i,1) = indep_term(:,:,i,1) + E_beta(i) * indep_term_wo_beta(:,:,i,1);
    end
    
    W=zeros(M,N,nbandas);
    for i=1:nbandas
        [Dhy, Dvy] = circ_gradient2(indep_term(:,:,i,1));
        v = Dhy.^2 + Dvy.^2;
        Wb = compute_Wpvb(v,2,epsW);
        W(:,:,i)=Wb; 
    end
    
end


function [E_alpha,E_beta,E_gamma,W] = update_params(x,Y,blk_fft2H,y,lambda,...
    tralpha,trbeta,trgamma,bkn,nbandas,...
    gamma_alpha,gamma_beta,gamma_gamma,alpha_mode,beta_mode,gamma_mode,epsW)

   [M N dims] = size(y);
    ysupport = M*N;
    observationsupport=ysupport/bkn/bkn;
    
%     X = blk_fft2(im_decomp(x,bknr,bknc));
%     Y = blk_fft2(im_decomp(y,bknr,bknc));
    aux4=x;
    for i=1:nbandas
        % Calculate normprior
        
        [Dhy, Dvy] = circ_gradient2(y(:,:,i));
        v = Dhy.^2 + Dvy.^2 + tralpha(i);
        v(v<0)=0;
        W(:,:,i) = compute_Wpvb(v,2,epsW);
        
        sum_t =   v.^ (1/2) ;
        sum_t=4*sum_t;
        sum_p=2*ysupport;
        normprior(i) = sum(sum_t(:));
        
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
        Eg(i) = err+eps;
        E_alpha(i) = (gamma_alpha(i))/alpha_mode(i) + (1-gamma_alpha(i))*normprior(i)/sum_p;
        E_beta(i)     =(gamma_beta(i))/beta_mode(i) + (1-gamma_beta(i))*(Eg(i)+trbeta(i))/observationsupport;

        E_alpha(i) = max(1/E_alpha(i),eps);
        E_beta(i)     = max(1/E_beta(i),eps);
        
        % gamma
        aux4(:,:) =aux4(:,:) - lambda(i)*y(:,:,i);
        
    end
    
    norma_gam= sum(sum(aux4.*aux4));
    E_gamma = (gamma_gamma)/gamma_mode + (1-gamma_gamma)*(norma_gam+trgamma)/ysupport;
    E_gamma=max(1/E_gamma,eps);
    

    
end

    function h = get_mic_handle(alpha,W,beta,HtDtDH,gamma,lambda,nr,nc,bkn,nbandas)
            h = @mic;
            function Ay = mic(y)
                Ay = multiply_by_invcov(y, alpha,W,beta,HtDtDH,gamma,lambda,nr,nc,bkn,nbandas);
            end
    end
    
    function Ay = multiply_by_invcov(y, alpha,W,beta,HtDtDH,gamma,lambda,nr,nc,bkn,nbandas)

        yd = convertToMBImg(y,nr,nc,nbandas);
        
        Ay = zeros(nr,nc,nbandas);
        for i=1:nbandas
            yf = blk_fft2(im_decomp (yd(:,:,i),bkn,bkn ));
            
            if iscell(HtDtDH)
                v = beta(i)*im_comp( blk_ifft2 (blk_fd_conv(HtDtDH{i},yf)),bkn,bkn);
            else
                v = beta(i)*im_comp( blk_ifft2 (blk_fd_conv(HtDtDH,yf)),bkn,bkn);
            end
            %% Prior
            [Dhy, Dvy] = circ_gradient2(yd(:,:,i));

            [F2,temp] = Tcirc_gradient2( W(:,:,i).* Dhy );
            F2 = alpha(i) * F2;

            [temp,F3] = Tcirc_gradient2( W(:,:,i).* Dvy );
            F3 = alpha(i) *  F3;
            
            Ay(:,:,i) = v + F2 + F3;
           
        end
        
        for i= 1:nbandas
            for j=1:nbandas
                Ay(:,:,i)=Ay(:,:,i)+gamma*lambda(i)*lambda(j)*yd(:,:,j);
            end
        end
        
        Ay = convertToMBVec(Ay);
    
    end
    
    function [trprior, trobs, trpancr] =calc_trazas(alpha,DhtDh,DvtDv,W,beta,HtDtDH,gamma,lambda,lr_size,SRratio,nbandas)
    
    Qinv = calc_cov(alpha,DhtDh,DvtDv,W,beta,HtDtDH,gamma,lambda,lr_size,SRratio,nbandas);
    
    [M, N , ~] = size(W);
        
        trpancr=0;
        trprior = zeros(nbandas,1);
        trobs = zeros(nbandas,1);
        for i=1:nbandas
            trprior(i) = blk_fd_trace(blk_fd_conv(Qinv(:,:,:,:,i,i), DhtDh+DvtDv))/M/N;
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
    
    function Qinv=calc_cov(alpha,DhtDh,DvtDv,W,beta,HtDtDH,gamma,lambda,lr_size,SRratio,nbandas)
    
    % LAMBDA

    I = zeros(lr_size(1), lr_size(2), SRratio*SRratio,SRratio*SRratio);
    for i=1:SRratio*SRratio
        I(:,:,i,i)=ones(lr_size(1),lr_size(2));
    end
    Q= zeros(lr_size(1), lr_size(2), SRratio*SRratio,SRratio*SRratio, nbandas, nbandas);
    
    for i=1:nbandas
        Wb=W(:,:,i);
        z = mean(Wb(:));
        if iscell(HtDtDH)
            Q(:,:,:,:,i,i)= gamma*lambda(i) * lambda(i)* I(:,:,:,:)...
                        + alpha(i) *  z * (DhtDh + DvtDv) + beta(i) * HtDtDH{i}  ;
        else
            Q(:,:,:,:,i,i)= gamma*lambda(i) * lambda(i)* I(:,:,:,:)...
                        + alpha(i) *  z * (DhtDh + DvtDv) + beta(i) * HtDtDH  ;
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