function [MatrixResults, time_Indusion] = doIndusionSSens0(imageDataFile)
% doIndusionSSens0 performes a SFIM reconstruction of a Multi-spectral image,
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
%       MatrixResults         [Q_Indusion,Q_avg_Indusion,SAM_Indusion,ERGAS_Indusion,SCC_GT_Indusion]
%       time_SFIM              cpu time
%
%       Example:
%
%       [MatrixResults, time_Indusion] = doIndusionSSens0('MD');
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
    addpath(path,fullfile(cd,'..','others','Indusion'));
    
    inputDir = fullfile(path,'Sensors','data');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
      
    t2=tic;
    
    I_Indusion = Indusion(I_PAN,I_MS_LR,ratio);
    I_Indusion(I_Indusion>255.0) = 255.0;
    I_Indusion(I_Indusion<0.0) = 0.0;
    time_Indusion = toc(t2);
    
    
    [Q_avg_Indusion, SAM_Indusion, ERGAS_Indusion, SCC_GT_Indusion, Q_Indusion] = indexes_evaluation(I_Indusion,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

    
    MatrixResults = [Q_Indusion,Q_avg_Indusion,SAM_Indusion,ERGAS_Indusion,SCC_GT_Indusion];
end

