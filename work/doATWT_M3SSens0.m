function [MatrixResults, time_ATWTM3] = doATWT_M3SSens0(imageDataFile)
% doATWT_M3SSens0 performes a ATWT_M3 reconstruction of a Multi-spectral image,
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
%       MatrixResults         [Q_ATWTM3,Q_avg_ATWTM3,SAM_ATWTM3,ERGAS_ATWTM3,SCC_GT_ATWTM3]
%       time_ATWTM3              cpu time
%
%       Example:
%
%       [MatrixResults, time_ATWTM3] = doATWT_M3SSens0('MD');
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
    addpath(path,fullfile(cd,'..','others','Wavelet'));
    addpath(path,fullfile(path,'..','others','toolboxwavelet','wavelet'));
    
    inputDir = fullfile(path,'Sensors','data');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
      
    t2=tic;
    
    I_ATWTM3 = ATWT_M3(I_MS,I_PAN,ratio);
    I_ATWTM3(I_ATWTM3>255.0) = 255.0;
    I_ATWTM3(I_ATWTM3<0.0) = 0.0;
    time_ATWTM3 = toc(t2);
    
    
    [Q_avg_ATWTM3, SAM_ATWTM3, ERGAS_ATWTM3, SCC_GT_ATWTM3, Q_ATWTM3] = indexes_evaluation(I_ATWTM3,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

    
    MatrixResults = [Q_ATWTM3,Q_avg_ATWTM3,SAM_ATWTM3,ERGAS_ATWTM3,SCC_GT_ATWTM3];
end

