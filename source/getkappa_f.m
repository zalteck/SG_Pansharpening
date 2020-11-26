function kappa_f = getkappa_f(sgPriorName,parameter)
% getkappa_f returns kappa_f function needed to estimate SG prior parameters
%
% input arguments:
%       sgPriorName         SG prior name
%       parameter           SG prior parameter
%
% output arguments:
%       kappa_f             kappa_f function
%
% Pérez-Bueno, F., Vega, M., Mateos, J., Molina, R., & Katsaggelos, A. K. (2020). 
% Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors. Sensors, 20(18), 5308. 

    switch sgPriorName
        
        case 'log'
            kappa_f= @weight_log;
            
        case 'lp'
            kappa_f = @(nu) weight_lp(nu,parameter);
            
    end
end