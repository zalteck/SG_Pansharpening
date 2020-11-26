function [MatrixResults, time_IHS] = doIHSSens0FR(imageDataFile)
% doIHSSens0FR performes a IHS reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
%
% Output arguments:
%       MatrixResults         [D_lambda_IHS,D_S_IHS,QNRI_IHS,SAM_IHS,SCC_IHS]
%       time_IHS              cpu time
%
%       Example:
%
%       [MatrixResults, time_IHS] = doIHSSens0('MD');  

    path = fileparts(mfilename('fullpath'));
    addpath(path,fullfile(path,'..','others'));
    
    inputDir = fullfile(path,'Sensors','data');
    outputDir = fullfile(path,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    I_MS_Upsampled = imresize(double(I_MS_loaded),ratio,'bicubic');
    I_PAN_loaded = double(I_PAN_loaded);
    
    
    t2=tic;
    
    I_IHS = IHS(I_MS_Upsampled,I_PAN_loaded);
    I_IHS(I_IHS>255.0) = 255.0;
    I_IHS(I_IHS<0.0) = 0.0;
    time_IHS = toc(t2);
    
    [D_lambda_IHS,D_S_IHS,QNRI_IHS,SAM_IHS,SCC_IHS] = indexes_evaluation_FS(double(I_IHS),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_IHS,D_S_IHS,QNRI_IHS,SAM_IHS,SCC_IHS];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_IHSFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_IHS','ratio','time_IHS','D_lambda_IHS','D_S_IHS','QNRI_IHS','SCC_IHS');  
end

