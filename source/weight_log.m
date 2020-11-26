function w = weight_log(u)
% weight_log computes wheights' vector for SG log prior
%
% input arguments:
%       u         u vector
%
% output arguments:
%       w          wheights' vector for SG log prior
%
% Pérez-Bueno, F., Vega, M., Mateos, J., Molina, R., & Katsaggelos, A. K. (2020). 
% Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors. Sensors, 20(18), 5308.

    val=eps+(abs(u)+eps).*abs(u);
    w=1./val;
end