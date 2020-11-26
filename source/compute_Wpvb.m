function W = compute_Wpvb(u,p,epsW)
% compute_Wpvb computes weights'
% matrices for TV prior majorization

% input arguments:
%
%   u          Dhy.^2 + Dvy.^2
%   p          2 
%   epsW       A very low value to avoid division by zero
%
% output arguments:
%   W          weights' matrix   

    exponent=(p-1)./p;
    W = 2./ (p.*( epsW + u.^exponent) );    

end
 