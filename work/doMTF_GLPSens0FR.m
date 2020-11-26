function [MatrixResults, time_MTF_GLP] = doMTF_GLPSens0FR(imageDataFile)
% doMTF_GLPSens0FR performes a MTF_GLP reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
% and stores the results in a .mat file into ../Sensors/results folder.
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
% Output arguments:
%       MatrixResults         [D_lambda_MTF_GLP,D_S_MTF_GLP,QNRI_MTF_GLP,SAM_MTF_GLP,SCC_MTF_GLP]
%       time_MTF_GLP              cpu time
%
%       Example:
%
%       [MatrixResults, time_MTF_GLP] = doMTF_GLPSens0('MD');
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
    I_MTF_GLP = MTF_GLP(I_PAN_loaded,I_MS_Upsampled,sensor,'none',ratio);
    I_MTF_GLP(I_MTF_GLP>255.0) = 255.0;
    I_MTF_GLP(I_MTF_GLP<0.0) = 0.0;

    time_MTF_GLP = toc(t2);
    
    addpath(path,fullfile(path,'Quality_Indices'));
    
    [D_lambda_MTF_GLP,D_S_MTF_GLP,QNRI_MTF_GLP,SAM_MTF_GLP,SCC_MTF_GLP] = indexes_evaluation_FS(double(I_MTF_GLP),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_MTF_GLP,D_S_MTF_GLP,QNRI_MTF_GLP,SAM_MTF_GLP,SCC_MTF_GLP];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_MTF_GLPFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_MTF_GLP','ratio','time_MTF_GLP','D_lambda_MTF_GLP','D_S_MTF_GLP','QNRI_MTF_GLP','SCC_MTF_GLP');  
end

