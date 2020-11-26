function kappa = getkappa(sgPriorName,parameter)
% getkappa returns cell array with kappa_f rho_f and alpha_f functions
% needed to estimate SG prior parameters
%
% input arguments:
%       sgPriorName         SG prior name
%       parameter           SG prior parameter
%
% output arguments:
%       kappa               cell array with kappa_f rho_f and alpha_f functions
%
% Pérez-Bueno, F., Vega, M., Mateos, J., Molina, R., & Katsaggelos, A. K. (2020). 
% Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors. Sensors, 20(18), 5308. 

    if(exist('parameter'))
        kappa_f = getkappa_f(sgPriorName,parameter);
    else
        kappa_f = getkappa_f(sgPriorName);
    end
    
    switch sgPriorName
        
        case 'log'
            rho_f= @(nu) log(abs(nu) + eps);
            
         case 'lp'
            rho_f = @(nu) abs(nu).^parameter;
                        
    end
    
    switch sgPriorName
        
        case 'log'
            alpha_f= @(val) 1.0 + 1.0/val;
                        
        case 'lp'
            alpha_f = @(val) 1.0/(eps + parameter * val);
                        
    end
    kappa={kappa_f rho_f alpha_f};
end