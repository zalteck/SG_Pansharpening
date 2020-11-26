function alpha = alfaSGlpvini(Y,p,filtersetname,epsW)
%  alfaSGlpvini gets reference values for lp prior alpha parameters
%
% input arguments:
%       Y               Multi-spectral image
%       p               p value for lp prior
%       filtersetname   'none'  or 'fohv'  or 'fo'
%       epsW            a very low value to avoid division by zero
%
% output arguments:
%       alpha           initial alpha values
    
    [M, N , nbandas] = size(Y);
    % filters
    
    filters = getfilters(filtersetname);
    nfilters=numel(filters);
    
    kappa = getkappa('lp',p);
    kappa_f=kappa{1};
    alpha_f=kappa{3};
    
    alpha = cell(nfilters,1);
    W = zeros(M,N);
    
    
    for nu=1:nfilters
        Fnu = cent_nucleus2fft(filters{nu},M, N);
        for i=1:nbandas
            xF = fft2(Y(:,:,i));
            xnu = ifft2( Fnu .* xF );
            u = epsW + ( abs ( xnu .* xnu ) ).^0.5;
            W = kappa_f(u);
            val = sum(W(:)) + eps;
            alpha{nu}(i) = alpha_f(val);
        end
    end
    
end