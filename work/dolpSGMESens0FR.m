function dolpSGMESens0FR(imageDataFile, p, filtersetname, gamma_gamma)
% dolpSGMESens0FR performes a SG lp pansharpening of a Multi-spectral image, 
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file, using the given parameter value, 
% and stores the results in a .mat file into ../Sensors/results folder.
%
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%       p                       p parameter of lp norm
%       filtersetname           'fohv'   or 'fo'
%                               'fohv' first order horizontal and vertical
%                               differences
%                               'fo' first order horizontal, vertical and
%                               diagonal differences
%       gamma_gamma             gamma parameter value for gamma hyperprior
%
%       Example:
%
%       dolpSGMESens0('MD', 1,'fohv',0.0)
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
    givenalpha = alfaSGlpvini(I_MS_loaded,p,filtersetname,1.0e-5);

    kappa = getkappa('lp',p);
    
    t2=tic;
    
    [I_lp,  alpha, beta, gamma, W] = restSGME_Sens(I_MS_loaded, I_PAN_loaded,lambda, kappa, filtersetname,psf,nbandas,1.0e-6,50,2,...
                         gamma_alpha*vecones,gamma_gamma*vecones,gamma_gamma,givenalpha,betaref,gammaref);
    
    time_rest=toc(t2);
    
    I_lp = imageMEBR( I_lp, facY );
    
    [~, name, ~] = fileparts(imageDataFile);
    
    gamma_gamma_str = replace(sprintf('_l%0.1f_%0.1f_',p,gamma_gamma),'.','_');
    name = strcat(name,'_SGMEFR',gamma_gamma_str,'.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_lp','alpha','beta','gamma','lambda','ratio','time_rest');  
end

