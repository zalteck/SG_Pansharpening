function dodoMain_Reduced_Resolution( im_tag )
% dodoMain_Reduced_Resolution generates  low resolution PANchromatic
% (PAN) and MultiSpectral (MS) images according to the Wald's protocol for
% im_tag image from Pérez-Bueno, F. paper image dataset following the same procedure as
% Vivone, G. paper.
%
% Input arguments:
%       im_tag  tag for the image to be generated
%
%
% Output arguments:
%
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

    path = fileparts(mfilename('fullpath'));
    addpath(path,fullfile(path,'..','others','WaldGeneration'));
    addpath(path,fullfile(path,'..','others','toolboxwavelet'));
    
    inputDir = fullfile(path,'Sensors','Datasets');
    outputDir = fullfile(path,'Sensors','data');
    switch im_tag
        case 'MD'
            inputFile = 'Landsat_Chesapeake_Bay_MD.mat';
            outputFile = 'MD.mat';
            sensor = 'none';
        case 'NL_subset'
            inputFile = 'NL_subset.mat';
            outputFile = 'NL_subset.mat';
            sensor = 'none'; 
        case 'NL_clouds'
            inputFile = 'NL_clouds.mat';
            outputFile = 'NL_clouds.mat';
            sensor = 'none'; 
        case 'Romax2'
            inputFile = 'SPOT_Roma_1024x2.mat';
            outputFile = 'Romax2.mat';
            sensor = 'none';
        case 'Romax4'
            inputFile = 'SPOT_Roma_1024x4.mat';
            outputFile = 'Romax4.mat';
            sensor = 'none';
        case 'FORMOSASPOTx2'
            inputFile = 'FORMOSASPOTx2.mat';
            outputFile = 'FORMOSASPOTx2.mat';
            sensor = 'none';
       case 'FORMOSASPOTx4'
            inputFile = 'FORMOSASPOTx4.mat';
            outputFile = 'FORMOSASPOTx4.mat';
            sensor = 'none'; 
    end
    
    doMain_Reduced_Resolution( im_tag, sensor, fullfile(inputDir,inputFile), fullfile(outputDir,outputFile) );

end

