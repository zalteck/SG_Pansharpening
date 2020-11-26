function [MatrixResults, time_MTF_GLP_HPM] = doMTF_GLP_HPMSens0FR(imageDataFile)
% doMTF_GLP_HPMSens0FR performes a MTF_GLP_HPM reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
% and stores the results in a .mat file into ../Sensors/results folder.
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
% Output arguments:
%       MatrixResults         [D_lambda_MTF_GLP_HPM,D_S_MTF_GLP_HPM,QNRI_MTF_GLP_HPM,SAM_MTF_GLP_HPM,SCC_MTF_GLP_HPM]
%       time_MTF_GLP_HPM              cpu time
%
%       Example:
%
%       [MatrixResults, time_MTF_GLP_HPM] = doMTF_GLP_HPMSens0('MD');
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
    addpath(path,fullfile(path,'..','others','GLP'));
    
    inputDir = fullfile(cd,'Sensors','data');
    outputDir = fullfile(cd,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    I_MS_Upsampled = imresize(double(I_MS_loaded),ratio,'bicubic');
    I_PAN_loaded = double(I_PAN_loaded);
    
    t2=tic;
    I_MTF_GLP_HPM = MTF_GLP_HPM(I_PAN_loaded,I_MS_Upsampled,sensor,'none',ratio);
    I_MTF_GLP_HPM(I_MTF_GLP_HPM>255.0) = 255.0;
    I_MTF_GLP_HPM(I_MTF_GLP_HPM<0.0) = 0.0;

    time_MTF_GLP_HPM = toc(t2);
    
    addpath(path,fullfile(path,'Quality_Indices'));
    
    [D_lambda_MTF_GLP_HPM,D_S_MTF_GLP_HPM,QNRI_MTF_GLP_HPM,SAM_MTF_GLP_HPM,SCC_MTF_GLP_HPM] = indexes_evaluation_FS(double(I_MTF_GLP_HPM),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_MTF_GLP_HPM,D_S_MTF_GLP_HPM,QNRI_MTF_GLP_HPM,SAM_MTF_GLP_HPM,SCC_MTF_GLP_HPM];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_MTF_GLP_HPMFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_MTF_GLP_HPM','ratio','time_MTF_GLP_HPM','D_lambda_MTF_GLP_HPM','D_S_MTF_GLP_HPM','QNRI_MTF_GLP_HPM','SCC_MTF_GLP_HPM');  
end

