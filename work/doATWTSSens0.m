function [MatrixResults, time_ATWT] = doATWTSSens0(imageDataFile)
% doIndusionSSens0 performes a ATWT reconstruction of a Multi-spectral image,
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
%       MatrixResults         [Q_ATWT,Q_avg_ATWT,SAM_ATWT,ERGAS_ATWT,SCC_GT_ATWT]
%       time_ATWT              cpu time
%
%       Example:
%
% 
% This function uses other functions from
%
%    Vivone, G.; Alparone, L.; Chanussot, J.; Dalla Mura, M.; Garzelli, A.; Licciardi, G.A.; Restaino, R.; Wald, L. 
%    A critical comparison among pansharpening algorithms. IEEE Trans. Geosci. Remote Sens. 2015, 53, 2565–2586.
%
%    See : https://rscl-grss.org/coderecord.php?id=541
%
% Those functions can be found in ../others%       [MatrixResults, time_ATWT] = doATWTSSens0('MD');

    
    path = fileparts(mfilename('fullpath'));
    addpath(path,fullfile(path,'..','others'));
    addpath(path,fullfile(cd,'..','others','Wavelet'));
    addpath(path,fullfile(path,'..','others','toolboxwavelet','wavelet'));
    
    inputDir = fullfile(path,'Sensors','data');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
      
    t2=tic;
    
    I_ATWT = ATWT(I_MS,I_PAN,ratio);
    I_ATWT(I_ATWT>255.0) = 255.0;
    I_ATWT(I_ATWT<0.0) = 0.0;
    time_ATWT = toc(t2);
    
    
    [Q_avg_ATWT, SAM_ATWT, ERGAS_ATWT, SCC_GT_ATWT, Q_ATWT] = indexes_evaluation(I_ATWT,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

    
    MatrixResults = [Q_ATWT,Q_avg_ATWT,SAM_ATWT,ERGAS_ATWT,SCC_GT_ATWT];
end

