function [MatrixResults, time_GS] = doGSSens0(imageDataFile)
% doGSSens0 performes a GS reconstruction of a Multi-spectral image,
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
%       MatrixResults         [Q_GS,Q_avg_GS,SAM_GS,ERGAS_GS,SCC_GT_GS]
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
    addpath(path,fullfile(path,'..','others'));
    addpath(path,fullfile(path,'..','others','GS'));
    
    inputDir = fullfile(path,'Sensors','data');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
      
    t2=tic;
    
    I_GS = GS(I_MS,I_PAN);
    I_GS(I_GS>255.0) = 255.0;
    I_GS(I_GS<0.0) = 0.0;
    time_GS = toc(t2);
    
    
    [Q_avg_GS, SAM_GS, ERGAS_GS, SCC_GT_GS, Q_GS] = indexes_evaluation(I_GS,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    
    MatrixResults = [Q_GS,Q_avg_GS,SAM_GS,ERGAS_GS,SCC_GT_GS];
end

