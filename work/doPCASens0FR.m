function [MatrixResults, time_PCA] = doPCASens0FR(imageDataFile)
% doPCASens0FR performes a PCA reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
% and stores the results in a .mat file into ../Sensors/results folder.%
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
% Output arguments:
%       MatrixResults         [D_lambda_PCA,D_S_PCA,QNRI_PCA,SAM_PCA,SCC_PCA]
%       time_PCA              cpu time
%
%       Example:
%
%       [MatrixResults, time_PCA] = doPCASens0('MD');
%
% This function uses other functions from
%
%    Vivone, G.; Alparone, L.; Chanussot, J.; Dalla Mura, M.; Garzelli, A.; Licciardi, G.A.; Restaino, R.; Wald, L. 
%    A critical comparison among pansharpening algorithms. IEEE Trans. Geosci. Remote Sens. 2015, 53, 2565–2586.
%
%    See : https://rscl-grss.org/coderecord.php?id=541
%
% Those functions can be found in ../others
    
    path = fileparts(mfilename('fullpath'));
    addpath(path,fullfile(path,'..','others'));
    addpath(path,fullfile(path,'Quality_Indices'));
    
    inputDir = fullfile(path,'Sensors','data');
    outputDir = fullfile(path,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    I_MS_loaded = double(I_MS_loaded);
    I_PAN_loaded = double(I_PAN_loaded);
    
    I_MS_Upsampled = imresize(I_MS_loaded,ratio,'bicubic');
    
    t2=tic;
    
    I_PCA = PCA(I_MS_Upsampled,I_PAN_loaded);
    I_PCA(I_PCA>255.0) = 255.0;
    I_PCA(I_PCA<0.0) = 0.0;
    time_PCA=toc(t2);
    
    
    
    [D_lambda_PCA,D_S_PCA,QNRI_PCA,SAM_PCA,SCC_PCA] = indexes_evaluation_FS(double(I_PCA),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_PCA,D_S_PCA,QNRI_PCA,SAM_PCA,SCC_PCA];
    
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_PCAFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_PCA','ratio','time_PCA','D_lambda_PCA','D_S_PCA','QNRI_PCA','SCC_PCA');  
end

