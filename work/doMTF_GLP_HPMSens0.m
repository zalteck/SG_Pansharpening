function [MatrixResults, time_MTF_GLP_HPM, I_MTF_GLP_HPM] = doMTF_GLP_HPMSens0(imageDataFile)
% doMTF_GLP_HPMSens0 performes a MTF_GLP_HPM reconstruction of a Multi-spectral image,
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
%       MatrixResults         [Q_MTF_GLP_HPM,Q_avg_MTF_GLP_HPM,SAM_MTF_GLP_HPM,ERGAS_MTF_GLP_HPM,SCC_GT_MTF_GLP_HPM]
%       time_MTF_GLP_HPM              cpu time
%
%       Example:
%
%       [MatrixResults, time_MTF_GLP_HPM] = doMTF_GLP_HPMSens0('MD');
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
    addpath(path,fullfile(path,'..','others','GLP'));
    
    inputDir = fullfile(path,'Sensors','data');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
      
    t2=tic;
    
    I_MTF_GLP_HPM = MTF_GLP_HPM(I_PAN,I_MS,sensor,im_tag,ratio);
    I_MTF_GLP_HPM(I_MTF_GLP_HPM>255.0) = 255.0;
    I_MTF_GLP_HPM(I_MTF_GLP_HPM<0.0) = 0.0;
    time_MTF_GLP_HPM = toc(t2);
    
    
    [Q_avg_MTF_GLP_HPM, SAM_MTF_GLP_HPM, ERGAS_MTF_GLP_HPM, SCC_GT_MTF_GLP_HPM, Q_MTF_GLP_HPM] = indexes_evaluation(I_MTF_GLP_HPM,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

    
    MatrixResults = [Q_MTF_GLP_HPM,Q_avg_MTF_GLP_HPM,SAM_MTF_GLP_HPM,ERGAS_MTF_GLP_HPM,SCC_GT_MTF_GLP_HPM];
end

