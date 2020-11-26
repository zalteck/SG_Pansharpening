function [MatrixResults, time_EXP] = doEXPSens0(imageDataFile)
% doEXPSens0 performes a EXP reconstruction of a Multi-spectral image,
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
%       MatrixResults         [Q_EXP,Q_avg_EXP,SAM_EXP,ERGAS_EXP,SCC_GT_EXP]
%       time_EXP              cpu time
%
%       Example:
%
%       [MatrixResults, time_EXP] = doEXPSens0('MD');

    
    path = fileparts(mfilename('fullpath'));
    addpath(path,fullfile(path,'..','others'));
    
    inputDir = fullfile(path,'Sensors','data');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
      
    t2=tic;
    
    I_EXP = imresize(I_MS_LR,ratio,'bilinear');
    
    time_EXP=toc(t2);
    
    
    [Q_avg_EXP, SAM_EXP, ERGAS_EXP, SCC_GT_EXP, Q_EXP] = indexes_evaluation(I_EXP,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    
    MatrixResults = [Q_EXP,Q_avg_EXP,SAM_EXP,ERGAS_EXP,SCC_GT_EXP];
end

