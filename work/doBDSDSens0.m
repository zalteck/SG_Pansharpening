function [MatrixResults, time_BDSD] = doBDSDSens0(imageDataFile)
% doBDSDSens0 performes a BDSD reconstruction of a Multi-spectral image,
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
%       MatrixResults         [Q_avg_BDSD, SAM_BDSD, ERGAS_BDSD, SCC_GT_BDSD, Q_BDSD]
%       time_BDSD              cpu time
%
%       Example:
%
%       [MatrixResults, time_BDSD] = doBDSDSens0('MD');
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
    addpath(path,fullfile(path,'..','others','BDSD'));
    
    inputDir = fullfile(path,'Sensors','data');
    
    load(fullfile(inputDir,imageDataFile));  % Loading simulated ME data
      
    t2=tic;
    
    I_BDSD = BDSD(I_MS,I_PAN,ratio,size(I_MS,1),sensor);
    I_BDSD(I_BDSD>255.0) = 255.0;
    I_BDSD(I_BDSD<0.0) = 0.0;
    time_BDSD = toc(t2);
    
    
    [Q_avg_BDSD, SAM_BDSD, ERGAS_BDSD, SCC_GT_BDSD, Q_BDSD] = indexes_evaluation(I_BDSD,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    
    MatrixResults = [Q_BDSD,Q_avg_BDSD,SAM_BDSD,ERGAS_BDSD,SCC_GT_BDSD];
end

