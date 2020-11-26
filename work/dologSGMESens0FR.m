function dologSGMESens0FR(imageDataFile, filtersetname, gamma_gamma)
% dologSGMESens0FR performes a SG log pansharpening of a Multi-spectral image, 
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file, using the given parameter value, 
% and stores the results in a .mat file into ../Sensors/results folder.
%
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%       filtersetname           'fohv'   or 'fo'
%                               'fohv' first order horizontal and vertical
%                               differences
%                               'fo' first order horizontal, vertical and
%                               diagonal differences
%       gamma_gamma             gamma parameter value for gamma hyperprior
%
%       Example:
%
%       dologSGMESens0FR('MD','fohv',0.0)
%
% Pérez-Bueno, F., Vega, M., Mateos, J., Molina, R., & Katsaggelos, A. K. (2020). 
% Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors. Sensors, 20(18), 5308.    

    gamma_alpha = 0.0;
    
    path = fileparts(mfilename('fullpath'));
    addpath(path,fullfile(path,'..','source'));
    
    inputDir = fullfile(path,'Sensors','data');
    outputDir = fullfile(path,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    I_MS_loaded = double(I_MS_loaded);
    I_PAN_loaded = double(I_PAN_loaded);
    
    nbandas = size(I_MS_loaded,3);
    
    psf = getPsf( ratio,sensor );
    
    [I_MS_loaded, I_PAN_loaded, facY, facx] = imageMENormalization( I_MS_loaded, I_PAN_loaded );
    
    if (nbandas == 6)
        lambda = zeros(nbandas,1);
        lambda(1:4) = calclam(I_MS_loaded(:,:,1:4), I_PAN_loaded(1:ratio:end,1:ratio:end));
    else
        lambda = calclam(I_MS_loaded, I_PAN_loaded(1:ratio:end,1:ratio:end));
    end
    
    
    vecones=ones(nbandas,1);
    for i=1:nbandas
        if iscell(psf)
                [~ , ~ , betaref(i)] = restoreSAR(I_MS_loaded(:,:,i) , psf{i} ,1.e-06,100);
        else
                [~ , ~ , betaref(i)] = restoreSAR(I_MS_loaded(:,:,i) , psf ,1.e-06,100);
        end
    end
    [~ , ~ , gammaref] = restoreSAR(I_PAN_loaded , [1] ,1.e-06,100);
    givenalpha = alfaSGlogvini(I_MS_loaded,filtersetname,1.0e-6);
    
    kappa = getkappa('log');
    
    t2=tic;
    
    [I_log,  alpha, beta, gamma, W] = restSGME_Sens(I_MS_loaded, I_PAN_loaded,lambda, kappa, filtersetname,psf,nbandas,1.0e-6,50,2,...
                         gamma_alpha*vecones,gamma_gamma*vecones,gamma_gamma,givenalpha,betaref,gammaref,0.01,1000);
    time_rest=toc(t2);
                     
    I_log = imageMEBR( I_log, facY );
        
    [~, name, ~] = fileparts(imageDataFile);
    
    gamma_gamma_str = replace(sprintf('_log_%0.1f_',gamma_gamma),'.','_');
    name = strcat(name,'_SGMEFR',gamma_gamma_str,'.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_log','alpha','beta','gamma','lambda','ratio','time_rest');    
end

