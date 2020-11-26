function doothersSens0(imageDataFile)
% doothersSens0 performes reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% using other authors methods, the obtained results are compared with groundtruth following the
% Wald’s protocol, and the scores of the comparison are stored using Latex table format in a file.
%
% Input arguments:
%       imageDataFile  mat filename with the ME and Pan observations
%
% Output:
%           outputFilename (see the code bellow) file.
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
    inputDir = fullfile(path,'Sensors','data');
    outputDir = fullfile(path,'Sensors','results');
    
%% Initialization of the Matrix of Results
    NumAlgs = 18;
    NumIndexes = 5;
    MatrixResults = zeros(NumAlgs,NumIndexes);

    [MatrixResults(1,:), ~] = doEXPSens0(imageDataFile);
    [MatrixResults(2,:), ~] = doPCASens0(imageDataFile);
    [MatrixResults(3,:), ~] = doIHSSens0(imageDataFile);
    [MatrixResults(4,:), ~] = doBroveySens0(imageDataFile);
    [MatrixResults(5,:), ~] = doBDSDSens0(imageDataFile);
    [MatrixResults(6,:), ~] = doGSSens0(imageDataFile);
    [MatrixResults(7,:), ~] = doGSASens0(imageDataFile);
    [MatrixResults(8,:), ~] = doPRACSSens0(imageDataFile);
    [MatrixResults(9,:), ~] = doHPFSSens0(imageDataFile);
    [MatrixResults(10,:), ~] = doSFIMSSens0(imageDataFile);
    [MatrixResults(11,:), ~] = doIndusionSSens0(imageDataFile);
    [MatrixResults(12,:), ~] = doATWTSSens0(imageDataFile);
    [MatrixResults(13,:), ~] = doAWLPSSens0(imageDataFile);
    [MatrixResults(14,:), ~] = doATWT_M2SSens0(imageDataFile);
    [MatrixResults(15,:), ~] = doATWT_M3SSens0(imageDataFile);
    [MatrixResults(16,:), ~] = doMTF_GLPSSens0(imageDataFile);
    [MatrixResults(17,:), ~] = doMTF_GLP_HPMSens0(imageDataFile);
    [MatrixResults(18,:), ~] = doMTF_GLP_CBDSens0(imageDataFile);
    
    load(fullfile(inputDir,imageDataFile),'I_GT');
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_others','.tex');
    outputFilename = fullfile(outputDir,name);
    
    %% Print in LATEX

    if size(I_GT,3) == 4
       matrix2latex(MatrixResults,outputFilename, 'rowLabels',[{'EXP'},{'PCA'},{'IHS'},{'Brovey'},{'BDSD'},{'GS'},{'GSA'},{'PRACS'},{'HPF'},{'SFIM'},{'Indusion'},{'ATWT'},{'AWLP'},...
            {'ATWT-M2'},{'ATWT-M3'},{'MTF-GLP'},{'MTF-GLP-HPM'},{'MTF-GLP-CBD'}],'columnLabels',[{'Q4'},{'Q'},{'SAM'},{'ERGAS'},{'SCC'}],'alignment','c','format', '%.4f');
    else
       matrix2latex(MatrixResults,outputFilename, 'rowLabels',[{'EXP'},{'PCA'},{'IHS'},{'Brovey'},{'BDSD'},{'GS'},{'GSA'},{'PRACS'},{'HPF'},{'SFIM'},{'Indusion'},{'ATWT'},{'AWLP'},...
            {'ATWT-M2'},{'ATWT-M3'},{'MTF-GLP'},{'MTF-GLP-HPM'},{'MTF-GLP-CBD'}],'columnLabels',[{'Q8'},{'Q'},{'SAM'},{'ERGAS'},{'SCC'}],'alignment','c','format', '%.4f'); 
    end
end