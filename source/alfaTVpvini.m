function alfa = alfaTVpvini(x,p)
%  alfaTVpvini gets initial value for TV alpha parameter
%
% input arguments:
%       x     Observed image
%       p     For TV prior shoud be 2
%
% output arguments:
%       alpha initial alpha value

    [M N dims] = size(x);
    p=p.*ones(M,N);
    [Dhx, Dvx] = circ_gradient2(x);
    v = Dhx.^2 + Dvx.^2 ;
    v=v.^(1./p);
    alfa=sum(p(:))/4/sum(v(:));
end