function dododoMain_Reduced_Resolution()
% dododoMain_Reduced_Resolution generates  low resolution PANchromatic
% (PAN) and MultiSpectral (MS) images according to the Wald's protocol for
% Pérez-Bueno, F. paper image dataset following the same procedure as
% Vivone, G. paper.
%
%       Example:
%
%       dododoMain_Reduced_Resolution()
%
% Pérez-Bueno, F., Vega, M., Mateos, J., Molina, R., & Katsaggelos, A. K. (2020). 
% Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors. Sensors, 20(18), 5308. 
%
% This function uses other functions from
%
%    Vivone, G.; Alparone, L.; Chanussot, J.; Dalla Mura, M.; Garzelli, A.; Licciardi, G.A.; Restaino, R.; Wald, L. 
%    A critical comparison among pansharpening algorithms. IEEE Trans. Geosci. Remote Sens. 2015, 53, 2565–2586.
%
%    See : https://rscl-grss.org/coderecord.php?id=541
%
% Those functions can be found in ../others/WaldGeneration

    dodoMain_Reduced_Resolution( 'MD' );
    
    dodoMain_Reduced_Resolution( 'NL_subset' );
    
    dodoMain_Reduced_Resolution( 'NL_clouds' );
    
    dodoMain_Reduced_Resolution( 'Romax2' );
    
    dodoMain_Reduced_Resolution( 'Romax4' );
    
    dodoMain_Reduced_Resolution( 'FORMOSASPOTx2' ); 
    
    dodoMain_Reduced_Resolution( 'FORMOSASPOTx4' ); 

end

