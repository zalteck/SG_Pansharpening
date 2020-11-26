function [MatrixResults, time_GS] = doGSSens0FR(imageDataFile)
% doGSSens0FR performes a GS reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
% and stores the results in a .mat file into ../Sensors/results folder.
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
%
% Output arguments:
%       MatrixResults         [D_lambda_GS,D_S_GS,QNRI_GS,SAM_GS,SCC_GS]
%       time_GS              cpu time
%
%       Example:
%
%       [MatrixResults, time_GS] = doGSSens0('MD'); 
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
    addpath(path,fullfile(path,'..','others','GS'));
    
    inputDir = fullfile(path,'Sensors','data');
    outputDir = fullfile(path,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    I_MS_Upsampled = imresize(double(I_MS_loaded),ratio,'bicubic');
    I_PAN_loaded = double(I_PAN_loaded);

    
    t2=tic;
    
    I_GS = GS(I_MS_Upsampled,I_PAN_loaded);
    I_GS(I_GS>255.0) = 255.0;
    I_GS(I_GS<0.0) = 0.0;

    time_GS = toc(t2);
    
    addpath(path,fullfile(path,'Quality_Indices'));
    
    [D_lambda_GS,D_S_GS,QNRI_GS,SAM_GS,SCC_GS] = indexes_evaluation_FS(double(I_GS),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_GS,D_S_GS,QNRI_GS,SAM_GS,SCC_GS];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_GSFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_GS','ratio','time_GS','D_lambda_GS','D_S_GS','QNRI_GS','SCC_GS');  
end

