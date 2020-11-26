function [MatrixResults, time_PRACS] = doPRACSSens0FR(imageDataFile)
% doPRACSSens0FR performes a PRACS reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
% and stores the results in a .mat file into ../Sensors/results folder.
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
%
% Output arguments:
%       MatrixResults         [D_lambda_PRACS,D_S_PRACS,QNRI_PRACS,SAM_PRACS,SCC_PRACS]
%       time_PRACS              cpu time
%
%       Example:
%
%       [MatrixResults, time_PRACS] = doPRACSSens0('MD');
% 
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
    
    I_MS_loaded = double(I_MS_loaded);
    I_PAN_loaded = double(I_PAN_loaded);
    
    I_MS_Upsampled = imresize(I_MS_loaded,ratio,'bicubic'); 
    
    t2=tic;
    I_PRACS = PRACS(I_MS_Upsampled,I_PAN_loaded,ratio);
    I_PRACS(I_PRACS>255.0) = 255.0;
    I_PRACS(I_PRACS<0.0) = 0.0;

    time_PRACS = toc(t2);
    
    addpath(path,fullfile(path,'Quality_Indices'));
    
    [D_lambda_PRACS,D_S_PRACS,QNRI_PRACS,SAM_PRACS,SCC_PRACS] = indexes_evaluation_FS(double(I_PRACS),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_PRACS,D_S_PRACS,QNRI_PRACS,SAM_PRACS,SCC_PRACS];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_PRACSFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_PRACS','ratio','time_PRACS','D_lambda_PRACS','D_S_PRACS','QNRI_PRACS','SCC_PRACS');  
end

