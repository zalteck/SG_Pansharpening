function [MatrixResults, time_IHS] = doIHSSens0(imageDataFile)
% doIHSSens0 performes an IHS reconstruction of a Multi-spectral image,
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
%       MatrixResults         [Q_IHS,Q_avg_IHS,SAM_IHS,ERGAS_IHS,SCC_GT_IHS]
%       time_IHS              cpu time
%
%       Example:
%
%       [MatrixResults, time_IHS] = doIHSSens0('MD');

    
    path = fileparts(mfilename('fullpath'));
    addpath(path,fullfile(path,'..','others'));
    
    inputDir = fullfile(path,'Sensors','data');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
      
    t2=tic;
    
    I_IHS = IHS(I_MS,I_PAN);
    I_IHS(I_IHS>255.0) = 255.0;
    I_IHS(I_IHS<0.0) = 0.0;
    time_IHS = toc(t2);
    
    
    [Q_avg_IHS, SAM_IHS, ERGAS_IHS, SCC_GT_IHS, Q_IHS] = indexes_evaluation(I_IHS,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    
    MatrixResults = [Q_IHS,Q_avg_IHS,SAM_IHS,ERGAS_IHS,SCC_GT_IHS];
end

