function [out , alpha , beta] = restoreSAR(in , h ,term,nitermax)
% restoreSAR performs image denoising and deblurring using a SAR prior
%
% input arguments:
%
%   in          noisy and blurred image
%   h           convolution nucleus
%   term        Algorithm convergence rate
%   nitermax    maximum iterations number
%
% output arguments:
%
%   out         restored image
%   alpha       Estimated alpha parameter value
%   beta        Estimated betha parameter value
%
% R. Molina, A.K. Katsaggelos, and J. Mateos, “Bayesian and Regularization Methods for Hyperparameter Estimation 
% in Image Restoration”, IEEE Transactions on Image Processing, vol. 8, no. 2, 231-246, 1999.

show=false;
in=double(in);
g = fft2(in);
tam=size(in);
tamm=tam(1)*tam(2);

H=cent_nucleus2fft(h, tam(1), tam(2));
Ht=Tcent_nucleus2fft(h, tam(1), tam(2));
HtH=Ht.*H;

% SAR
priorn=[0 -.25 0;-.25 1 -.25;0 -.25 0];
priorn=conv2(priorn,priorn);
prior=cent_nucleus2fft(priorn, tam(1), tam(2));
dif=g- H.*g;

alpha0=real((tamm-1.0)*tamm/(sum(sum(conj(g).*(prior.*g)))));

beta0=tamm*tamm/sum(sum((conj(dif).*dif)));
if (beta0>1.0e04*alpha0) 
    beta0=100*alpha0;
end



Q=beta0*HtH+alpha0*prior;
f=beta0*Ht.*g./Q;
f0=f;
if show
ih=figure();
imshow(uint8(real(ifft2(f))));
end
t3=term+1.0;t1=term+1.0;t2=term+2.0;
% while ((t1>term)|(t2>term))
iter=1;
while ((t3>term) & (iter <= nitermax))
    alpha=real( (tamm-1.0)/ ( sum(sum(conj(f).*(prior.*f)))/tamm  + sum(sum(prior./Q)) ) );
    beta=real(tamm/(sum(sum(conj(g-H.*f).*(g-H.*f)))/tamm + sum(sum(HtH./Q))));
    Q=beta*HtH+alpha*prior;
    f=beta*Ht.*g./Q;
    
    t1=abs(alpha-alpha0)/alpha;
    t2=abs(beta-beta0)/beta;
    t3=sum(sum(conj(f-f0).*(f-f0))) / sum(sum(conj(f0).*f0));
    f0=f;
    disp(sprintf('%d\t %d\t %d\n\t %d\t %d\t  %d\t',iter,alpha,beta,t1,t2,t3))
    alpha0=alpha;beta0=beta;iter=iter+1;
    if show
        figure(ih);
        imshow(uint8(real(ifft2(f))));
    end
end;
alpha=real(alpha); beta=real(beta);
out=real(ifft2(f));