function doothersSens0FR(imageDataFile)
% doothersSens0FR performes reconstruction of a Multi-spectral image,
% whose relevant information is contained in ./Sensors/data/imageDataFile.mat file,
% using other authors methods, the obtained results are quantitatively evaluated using QNR measures.
% The scores of the comparison are stored using Latex table format in a file.
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

    [MatrixResults(1,:), ~] = doEXPSens0FR(imageDataFile);
    [MatrixResults(2,:), ~] = doPCASens0FR(imageDataFile);
    [MatrixResults(3,:), ~] = doIHSSens0FR(imageDataFile);
    [MatrixResults(4,:), ~] = doBroveySens0FR(imageDataFile);
    [MatrixResults(5,:), ~] = doBDSDSens0FR(imageDataFile);
    [MatrixResults(6,:), ~] = doGSSens0FR(imageDataFile);
    [MatrixResults(7,:), ~] = doGSASens0FR(imageDataFile);
    [MatrixResults(8,:), ~] = doPRACSSens0FR(imageDataFile);
    [MatrixResults(9,:), ~] = doHPFSens0FR(imageDataFile);
    [MatrixResults(10,:), ~] = doSFIMSens0FR(imageDataFile);
    [MatrixResults(11,:), ~] = doIndusionSens0FR(imageDataFile);
    [MatrixResults(12,:), ~] = doATWTSens0FR(imageDataFile);
    [MatrixResults(13,:), ~] = doAWLPSens0FR(imageDataFile);
    [MatrixResults(14,:), ~] = doATWT_M2Sens0FR(imageDataFile);
    [MatrixResults(15,:), ~] = doATWT_M3Sens0FR(imageDataFile);
    [MatrixResults(16,:), ~] = doMTF_GLPSens0FR(imageDataFile);
    [MatrixResults(17,:), ~] = doMTF_GLP_HPMSens0FR(imageDataFile);
    [MatrixResults(18,:), ~] = doMTF_GLP_CBDSens0FR(imageDataFile);
    
    load(fullfile(inputDir,imageDataFile),'I_GT');
    
    [~, name, ~] = fileparts(imageDataFile);
    
    name = strcat(name,'_othersFR','.tex');
    outputFilename = fullfile(outputDir,name);
    
    %% Print in LATEX

    
   matrix2latex(MatrixResults,outputFilename, 'rowLabels',[{'EXP'},{'PCA'},{'IHS'},{'Brovey'},{'BDSD'},{'GS'},{'GSA'},{'PRACS'},{'HPF'},{'SFIM'},{'Indusion'},{'ATWT'},{'AWLP'},...
        {'ATWT-M2'},{'ATWT-M3'},{'MTF-GLP'},{'MTF-GLP-HPM'},{'MTF-GLP-CBD'}],'columnLabels',[{'D_lambda'},{'D_S'},{'QNR'},{'SAM'},{'SCC'}],'alignment','c','format', '%.4f');
    
end