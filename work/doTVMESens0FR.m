function doTVMESens0FR(imageDataFile, gamma_alpha)
% doTVMESens0FR performes a TV pansharpening of a Multi-spectral image, 
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file, using the given parameter value, 
% and stores the results in a .mat file into ../Sensors/results folder.
%
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%       gamma_alpha             gamma parameter value for alpha hyperprior
%
%       Example:
%
%       doTVMESens0FR('MD', 0.8)
%
%   M. Vega, J. Mateos, R. Molina, and A. K. Katsaggelos, “Super resolution of multispectral images using TV image models,” 
%   in International Conference on Knowledge-Based and Intelligent Information and Engineering Systems, 2008, pp. 408–415.
    
    path = fileparts(mfilename('fullpath'));
    addpath(path,fullfile(path,'..','source'));
    
    inputDir = fullfile(path,'Sensors','data');
    outputDir = fullfile(path,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    I_MS_loaded = double(I_MS_loaded);
    I_PAN_loaded = double(I_PAN_loaded);
    
    nbandas = size(I_MS_loaded,3);
    
    psf = getPsf( ratio,sensor );
    
    [I_MS_loaded, I_PAN_loaded, facY, facx] = imageMENormalization( I_MS_loaded, I_PAN_loaded);
    
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
    givenalpha = vecones;
    for i=1:nbandas
        givenalpha(i) = alfaTVpvini(I_MS_loaded(:,:,i),2)*0.1;
    end
    
    t2=tic;
    
    [I_TV,  alpha, beta, gamma] = TVME_Sens(I_MS_loaded, I_PAN_loaded,lambda,psf, nbandas,1.0e-6,50,2,...
                         gamma_alpha*vecones,0.8*vecones,0.8,givenalpha,betaref,gammaref);
                     
    time_rest=toc(t2);
    
    I_TV = imageMEBR( I_TV, facY );
    
    [~, name, ~] = fileparts(imageDataFile);
    
    gamma_alpha_str = replace(sprintf('_%0.1f_',gamma_alpha),'.','_');
    name = strcat(name,'_TVMEFR',gamma_alpha_str,'.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_TV','alpha','beta','gamma','lambda','ratio','time_rest');  
end

