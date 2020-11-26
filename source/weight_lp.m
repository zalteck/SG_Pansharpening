function w = weight_lp(u,p)
% weight_lp computes wheights' vector for SG lp prior
%
% input arguments:
%       u         u vector
%       p         SG log prior parameter
%
% output arguments:
%       w          wheights' vector for SG lp prior
%
% Pérez-Bueno, F., Vega, M., Mateos, J., Molina, R., & Katsaggelos, A. K. (2020). 
% Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors. Sensors, 20(18), 5308.

    val=eps+abs(u).^(2-p);
    w=1./val;
end