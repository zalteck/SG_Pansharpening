function [MatrixResults, time_GSA] = doGSASens0FR(imageDataFile)
% doGSASens0FR performes a GSA reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
% and stores the results in a .mat file into ../Sensors/results folder.
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
%
% Output arguments:
%       MatrixResults         [D_lambda_GSA,D_S_GSA,QNRI_GSA,SAM_GSA,SCC_GSA]
%       time_GSA              cpu time
%
%       Example:
%
%       [MatrixResults, time_GSA] = doGSASens0('MD');
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
    addpath(path,fullfile(path,'..','others','toolboxwavelet','wavelet'));
    
    inputDir = fullfile(cd,'Sensors','data');
    outputDir = fullfile(cd,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    I_MS_Upsampled = imresize(double(I_MS_loaded),ratio,'bicubic');
    I_PAN_loaded = double(I_PAN_loaded); 
    
    t2=tic;
    I_GSA = GSA(I_MS_Upsampled,I_PAN_loaded,I_MS_loaded,ratio);
    I_GSA(I_GSA>255.0) = 255.0;
    I_GSA(I_GSA<0.0) = 0.0;

    time_GSA = toc(t2);
    
    addpath(path,fullfile(path,'Quality_Indices'));
    
    [D_lambda_GSA,D_S_GSA,QNRI_GSA,SAM_GSA,SCC_GSA] = indexes_evaluation_FS(double(I_GSA),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_GSA,D_S_GSA,QNRI_GSA,SAM_GSA,SCC_GSA];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_GSAFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_GSA','ratio','time_GSA','D_lambda_GSA','D_S_GSA','QNRI_GSA','SCC_GSA');  
end

