function MatrixResults = doQNRindsSens0FR(imageDataFile,FRRestImage)
% the obtained results are quantitatively evaluated using QNR measures.
% and stores the results in a .mat file into ../Sensors/results folder.%
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
% Output arguments:
%       MatrixResults         [D_lambda,D_S,QNR,SAM,SCC]
%       time_PCA              cpu time
%
%       Example:
%
%       [MatrixResults, time_PCA] = doPCASens0('MD');
    
    FRRestImage(FRRestImage>255.0) = 255.0;
    FRRestImage(FRRestImage<0.0) = 0.0;
    
    path = fileparts(mfilename('fullpath'));
    addpath(path,fullfile(path,'Quality_Indices'));
    
    inputDir = fullfile(path,'Sensors','data');
    
    load(fullfile(inputDir,imageDataFile));
    
    I_MS_loaded = double(I_MS_loaded);
    I_PAN_loaded = double(I_PAN_loaded);
    
    I_MS_Upsampled = imresize(I_MS_loaded,ratio,'bicubic');
    
    
    [D_lambda,D_S,QNR,SAM,SCC] = indexes_evaluation_FS(double(FRRestImage),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda,D_S,QNR,SAM,SCC];
    
end

