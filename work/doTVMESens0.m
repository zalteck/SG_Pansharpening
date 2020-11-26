function doTVMESens0(imageDataFile, gamma_alpha)
% doTVMESens0 performes a TV pansharpening of a Multi-spectral image, 
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file, using the given parameter value, 
% and stores the results in a .mat file into ../Sensors/results folder.
%
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%       gamma_alpha             gamma parameter value for alpha hyperprior
%
% the results obtained have been compared with groundtruth following the
% Wald’s protocol.
%       Example:
%
%       doTVMESens0('MD', 0.8)
%
%   M. Vega, J. Mateos, R. Molina, and A. K. Katsaggelos, “Super resolution of multispectral images using TV image models,” 
%   in International Conference on Knowledge-Based and Intelligent Information and Engineering Systems, 2008, pp. 408–415.

    
    path = fileparts(mfilename('fullpath'));
    addpath(path,fullfile(path,'..','source'));
    
    inputDir = fullfile(path,'Sensors','data');
    outputDir = fullfile(path,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    nbandas = size(I_MS_LR,3);
    
    psf = getPsf( ratio,sensor );
    
    [I_MS_LR, I_PAN, facY, facx] = imageMENormalization( I_MS_LR, I_PAN );
    
    if (nbandas == 6)
        lambda = zeros(nbandas,1);
        lambda(1:4) = calclam(I_MS(:,:,1:4), I_PAN);
    else
        lambda = calclam(I_MS, I_PAN);
    end

    vecones=ones(nbandas,1);
    for i=1:nbandas
        if iscell(psf)
                [~ , ~ , betaref(i)] = restoreSAR(I_MS_LR(:,:,i) , psf{i} ,1.e-06,100);
        else
                [~ , ~ , betaref(i)] = restoreSAR(I_MS_LR(:,:,i) , psf ,1.e-06,100);
        end
    end
    [~ , ~ , gammaref] = restoreSAR(I_PAN , [1] ,1.e-06,100);
    givenalpha = vecones;
    for i=1:nbandas
        givenalpha(i) = alfaTVpvini(I_MS_LR(:,:,i),2)*0.1;
    end
    
    t2=tic;
    
    [I_TV,  alpha, beta, gamma] = TVME_Sens(I_MS_LR, I_PAN,lambda,psf, nbandas,1.0e-6,50,2,...
                         gamma_alpha*vecones,0.8*vecones,0.8,givenalpha,betaref,gammaref);
    
    time_rest=toc(t2);
    
    I_TV = imageMEBR( I_TV, facY );
    
    I_TV(I_TV>255.0) = 255.0;
    I_TV(I_TV<0.0) = 0.0;
        
    
    [Q_avg_TV, SAM_TV, ERGAS_TV, SCC_GT_TV, Q_TV] = indexes_evaluation(I_TV,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    
    MatrixResults = [Q_TV,Q_avg_TV,SAM_TV,ERGAS_TV,SCC_GT_TV];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    gamma_alpha_str = replace(sprintf('_%0.1f_',gamma_alpha),'.','_');
    name = strcat(name,'_TVME',gamma_alpha_str,'.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_TV','alpha','beta','gamma','lambda','ratio','time_rest','Q_avg_TV','SAM_TV','ERGAS_TV','SCC_GT_TV','Q_TV','MatrixResults');  
end

