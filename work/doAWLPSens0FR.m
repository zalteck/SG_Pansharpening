function [MatrixResults, time_AWLP] = doAWLPSens0FR(imageDataFile)
% doAWLPSens0FR performes a AWLP reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are quantitatively evaluated using QNR measures.
% and stores the results in a .mat file into ../Sensors/results folder.
% input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
% Output arguments:
%       MatrixResults         [D_lambda_AWLP,D_S_AWLP,QNRI_AWLP,SAM_AWLP,SCC_AWLP]
%       time_AWLP              cpu time
%
%       Example:
%
%       [MatrixResults, time_AWLP] = doAWLPSens0('MD');
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
    addpath(path,fullfile(path,'..','others','Wavelet'));
    addpath(path,fullfile(path,'..','others','toolboxwavelet','wavelet')); 
    
    inputDir = fullfile(cd,'Sensors','data');
    outputDir = fullfile(cd,'Sensors','results');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
    
    I_MS_Upsampled = imresize(double(I_MS_loaded),ratio,'bicubic');
    I_PAN_loaded = double(I_PAN_loaded);
    
    t2=tic;
    I_AWLP = AWLP(I_MS_Upsampled,I_PAN_loaded,ratio);
    I_AWLP(I_AWLP>255.0) = 255.0;
    I_AWLP(I_AWLP<0.0) = 0.0;

    time_AWLP = toc(t2);
    
    addpath(path,fullfile(path,'Quality_Indices'));
    
    [D_lambda_AWLP,D_S_AWLP,QNRI_AWLP,SAM_AWLP,SCC_AWLP] = indexes_evaluation_FS(double(I_AWLP),double(I_MS_loaded),...
        double(I_PAN_loaded),L,thvalues,double(I_MS_Upsampled),sensor,im_tag,ratio);
    
    MatrixResults = [D_lambda_AWLP,D_S_AWLP,QNRI_AWLP,SAM_AWLP,SCC_AWLP];
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_AWLPFR','.mat');
    outputFilename = fullfile(outputDir,name);
    
    save(outputFilename,'I_AWLP','ratio','time_AWLP','D_lambda_AWLP','D_S_AWLP','QNRI_AWLP','SCC_AWLP');  
end

