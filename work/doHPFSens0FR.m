function [MatrixResults, time_HPF] = doHPFSens0FR(imageDataFile)
% doHPFSens0FR performes a HPF reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
% and stores the results in a .mat file into ../Sensors/results folder.
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
%
% Output arguments:
%       MatrixResults         [D_lambda_HPF,D_S_HPF,QNRI_HPF,SAM_HPF,SCC_HPF]
%       time_HPF              cpu time
%
%       Example:
%
%       [MatrixResults, time_HPF] = doHPFSens0('MD');
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
    
    inputDir = fullfile(cd,'Sensors','data');
    outputDir = fullfile(cd,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    I_MS_Upsampled = imresize(double(I_MS_loaded),ratio,'bicubic');
    I_PAN_loaded = double(I_PAN_loaded);
    
    t2=tic;
    I_HPF = HPF(I_MS_Upsampled,I_PAN_loaded,ratio);
    I_HPF(I_HPF>255.0) = 255.0;
    I_HPF(I_HPF<0.0) = 0.0;

    time_HPF = toc(t2);
    
    addpath(path,fullfile(path,'Quality_Indices'));
    
    [D_lambda_HPF,D_S_HPF,QNRI_HPF,SAM_HPF,SCC_HPF] = indexes_evaluation_FS(double(I_HPF),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_HPF,D_S_HPF,QNRI_HPF,SAM_HPF,SCC_HPF];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_HPFFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_HPF','ratio','time_HPF','D_lambda_HPF','D_S_HPF','QNRI_HPF','SCC_HPF');  
end

