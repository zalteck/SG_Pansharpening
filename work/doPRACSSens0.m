function [MatrixResults, time_PRACS, I_PRACS] = doPRACSSens0(imageDataFile)
% doPRACSSens0 performes a PRACS reconstruction of a Multi-spectral image,
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
%       MatrixResults         [Q_PRACS,Q_avg_PRACS,SAM_PRACS,ERGAS_PRACS,SCC_GT_PRACS]
%       time_PRACS              cpu time
%
%       Example:
%
%       [MatrixResults, time_PRACS] = doPRACSSens0('MD');
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
    
    inputDir = fullfile(path,'Sensors','data');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
      
    t2=tic;
    
    I_PRACS = PRACS(I_MS,I_PAN,ratio);
    I_PRACS(I_PRACS>255.0) = 255.0;
    I_PRACS(I_PRACS<0.0) = 0.0;
    time_PRACS = toc(t2);
    
    
    [Q_avg_PRACS, SAM_PRACS, ERGAS_PRACS, SCC_GT_PRACS, Q_PRACS] = indexes_evaluation(I_PRACS,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    
    MatrixResults = [Q_PRACS,Q_avg_PRACS,SAM_PRACS,ERGAS_PRACS,SCC_GT_PRACS];
end

