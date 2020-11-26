function [MatrixResults, time_AWLP] = doAWLPSSens0(imageDataFile)
% doAWLPSSens0 performes a AWLP reconstruction of a Multi-spectral image,
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
%       MatrixResults         [Q_AWLP,Q_avg_AWLP,SAM_AWLP,ERGAS_AWLP,SCC_GT_AWLP]
%       time_AWLP              cpu time
%
%       Example:
%
%       [MatrixResults, time_AWLP] = doAWLPSSens0('MD');
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
    
    I_AWLP = AWLP(I_MS,I_PAN,ratio);
    I_AWLP(I_AWLP>255.0) = 255.0;
    I_AWLP(I_AWLP<0.0) = 0.0;
    time_AWLP = toc(t2);
    
    
    [Q_avg_AWLP, SAM_AWLP, ERGAS_AWLP, SCC_GT_AWLP, Q_AWLP] = indexes_evaluation(I_AWLP,I_GT,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);

    
    MatrixResults = [Q_AWLP,Q_avg_AWLP,SAM_AWLP,ERGAS_AWLP,SCC_GT_AWLP];
end

