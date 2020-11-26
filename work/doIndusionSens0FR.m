function [MatrixResults, time_Indusion] = doIndusionSens0FR(imageDataFile)
% doIndusionSens0FR performes a Indusion reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
% and stores the results in a .mat file into ../Sensors/results folder.
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
%
% Output arguments:
%       MatrixResults         [D_lambda_Indusion,D_S_Indusion,QNRI_Indusion,SAM_Indusion,SCC_Indusion]
%       time_Indusion              cpu time
%
%       Example:
%
%       [MatrixResults, time_Indusion] = doIndusionSens0('MD');
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
    addpath(path,fullfile(path,'..','others','Indusion'));
    
    inputDir = fullfile(cd,'Sensors','data');
    outputDir = fullfile(cd,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    I_MS_loaded = double(I_MS_loaded);
    I_PAN_loaded = double(I_PAN_loaded);
    
    I_MS_Upsampled = imresize(I_MS_loaded,ratio,'bicubic');
    
    t2=tic;
    I_Indusion = Indusion(I_PAN_loaded,I_MS_loaded,ratio);
    I_Indusion(I_Indusion>255.0) = 255.0;
    I_Indusion(I_Indusion<0.0) = 0.0;

    time_Indusion = toc(t2);
    
    addpath(path,fullfile(path,'Quality_Indices'));
    
    [D_lambda_Indusion,D_S_Indusion,QNRI_Indusion,SAM_Indusion,SCC_Indusion] = indexes_evaluation_FS(double(I_Indusion),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_Indusion,D_S_Indusion,QNRI_Indusion,SAM_Indusion,SCC_Indusion];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_IndusionFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_Indusion','ratio','time_Indusion','D_lambda_Indusion','D_S_Indusion','QNRI_Indusion','SCC_Indusion');  
end

