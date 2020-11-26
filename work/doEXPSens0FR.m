function [MatrixResults, time_EXP] = doEXPSens0FR(imageDataFile)
% doEXPSens0FR performes a EXP reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
%
% Input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
%
% Output arguments:
%       MatrixResults         [D_lambda_EXP,D_S_EXP,QNRI_EXP,SAM_EXP,SCC_EXP]
%       time_EXP              cpu time
%
%       Example:
%
%       [MatrixResults, time_EXP] = doEXPSens0('MD');

    
    path = fileparts(mfilename('fullpath'));
    addpath(path,fullfile(path,'..','others'));
    addpath(path,fullfile(path,'Quality_Indices'));
    
    inputDir = fullfile(path,'Sensors','data');
    outputDir = fullfile(path,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
      
    t2=tic;
    
    I_EXP = imresize(I_MS_loaded,ratio,'bilinear');
    
    time_EXP=toc(t2);
    
    I_MS_Upsampled = imresize(I_MS_loaded,ratio,'bicubic');
    
    [D_lambda_EXP,D_S_EXP,QNRI_EXP,SAM_EXP,SCC_EXP] = indexes_evaluation_FS(double(I_EXP),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_EXP,D_S_EXP,QNRI_EXP,SAM_EXP,SCC_EXP];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_EXPFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_EXP','ratio','time_EXP','D_lambda_EXP','D_S_EXP','QNRI_EXP','SCC_EXP'); 
    
end

