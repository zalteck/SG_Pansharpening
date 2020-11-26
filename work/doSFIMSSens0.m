function [MatrixResults, time_SFIM] = doSFIMSSens0(imageDataFile)
% doSFIMSSens0 performes a SFIM reconstruction of a Multi-spectral image,
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
%       MatrixResults         [Q_SFIM,Q_avg_SFIM,SAM_SFIM,ERGAS_SFIM,SCC_GT_SFIM]
%       time_SFIM              cpu time
%
%       Example:
%
%       [MatrixResults, time_SFIM] = doSFIMSSens0('MD');
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
    
    I_SFIM = SFIM(I_MS,I_PAN,ratio);
    I_SFIM(I_SFIM>255.0) = 255.0;
    I_SFIM(I_SFIM<0.0) = 0.0;
    time_SFIM = toc(t2);
    
    
    [Q_avg_SFIM, SAM_SFIM, ERGAS_SFIM, SCC_GT_SFIM, Q_SFIM] = indexes_evaluation(I_SFIM,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    
    MatrixResults = [Q_SFIM,Q_avg_SFIM,SAM_SFIM,ERGAS_SFIM,SCC_GT_SFIM];
end

