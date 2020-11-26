function [MatrixResults, time_BDSD] = doBDSDSens0FR(imageDataFile)
% doBDSDSens0FR performes a BDSD reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
% and stores the results in a .mat file into ../Sensors/results folder.
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
%
% Output arguments:
%       MatrixResults         [D_lambda_BDSD,D_S_BDSD,QNRI_BDSD,SAM_BDSD,SCC_BDSD]
%       time_BDSD              cpu time
%
%       Example:
%
%       [MatrixResults, time_BDSD] = doBDSDSens0('MD'); 
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
    addpath(path,fullfile(path,'..','others','BDSD'));
    
    inputDir = fullfile(path,'Sensors','data');
    outputDir = fullfile(path,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    I_MS_Upsampled = imresize(double(I_MS_loaded),ratio,'bicubic');
    I_PAN_loaded = double(I_PAN_loaded);
    
    
    t2=tic;
    
    I_BDSD = BDSD(I_MS_Upsampled,I_PAN_loaded,ratio,size(I_MS_Upsampled,1),sensor);
    I_BDSD(I_BDSD>255.0) = 255.0;
    I_BDSD(I_BDSD<0.0) = 0.0;

    time_BDSD = toc(t2);
    
    addpath(path,fullfile(path,'Quality_Indices'));
    
    [D_lambda_BDSD,D_S_BDSD,QNRI_BDSD,SAM_BDSD,SCC_BDSD] = indexes_evaluation_FS(double(I_BDSD),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_BDSD,D_S_BDSD,QNRI_BDSD,SAM_BDSD,SCC_BDSD];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_BDSDFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_BDSD','ratio','time_BDSD','D_lambda_BDSD','D_S_BDSD','QNRI_BDSD','SCC_BDSD');  
end

