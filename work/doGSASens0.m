function [MatrixResults, time_GSA] = doGSASens0(imageDataFile)
% doGSASens0 performes a GSA reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% the obtained results are compared with groundtruth following the
% Wald’s protocol, and the scores of the comparison are returned.
%
% Input arguments:
%       imageDataFile  mat filename with the ME and Pan
%                               observations
%
%
% Output arguments:
%       MatrixResults         [Q_GSA,Q_avg_GSA,SAM_GSA,ERGAS_GSA,SCC_GT_GSA]
%       tempo_GSA              cpu time
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
    
    inputDir = fullfile(path,'Sensors','data');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
      
    t2=tic;
    
    I_GSA = GSA(I_MS,I_PAN,I_MS_LR,ratio);
    I_GSA(I_GSA>255.0) = 255.0;
    I_GSA(I_GSA<0.0) = 0.0;
    time_GSA = toc(t2);
    
    
    [Q_avg_GSA, SAM_GSA, ERGAS_GSA, SCC_GT_GSA, Q_GSA] = indexes_evaluation(I_GSA,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    
    MatrixResults = [Q_GSA,Q_avg_GSA,SAM_GSA,ERGAS_GSA,SCC_GT_GSA];
end

