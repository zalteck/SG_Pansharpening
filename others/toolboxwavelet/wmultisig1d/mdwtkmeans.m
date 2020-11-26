function S = mdwtkmeans(X,varargin)
%MDWTKMEANS Kmeans construction of clusters from DWT decomposition.
%   S = MDWTKMEANS(X) constructs clusters from hierarchical trees 
%   cluster trees. The input X is a matrix which is decomposed in 
%   row direction with the DWT, using Haar's wavelet and the maximum
%   allowed level (fix(log2(size(X,2))).
%
%   S = MDWTKMEANS(X,'PropName1',PropVal1,'PropName2',PropVal2,,...)
%   The valid choices for PropName are:
%     'dirDec'   : 'r' (row) or 'c' (column).
%     'level'    : level of DWT decomposition.
%                  default is: level = fix(log2(size(X,d))) (d = 1 or 2).
%     'wname'    : wavelet used for the DWT - default is 'haar'.
%     'dwtEXTM'  : DWT extension mode (see DWTMODE).
%     'distance' - see KMEANS   - default is 'seuclidean'.
%     'maxclust' - number of clusters - default is 6.
%                    The input may be a vector.
%     'lst2clu'  : Cell array which contains the list of data to classify.
%          If N is the level of decomposition, allowed values are:
%             's'   (signal)
%             'aj'  (approximation at level j),
%             'dj'  (detail at level j), 
%             'caj' (coefficients of approximation at level j),
%             'cdj' (coefficients of detail at level j),
%                    with j = 1 , ... ,N 
%             The default is: {'s' ; 'ca1' ; ... ; 'caN'}.
%
%   The output S is a structure such that for each partition j:
%     S.IdxCLU(:,j) containts the cluster numbers obtained from the  
%                      hierarchical cluster tree (See CLUSTER).
%    N.B.: If maxclustVal is a vector, IdxCLU is a multidimensional
%          array such that IdxCLU(:,j,k) containts the cluster   
%          numbers obtained from the hierarchical cluster tree  
%          for k clusters.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 13-Nov-2005.
%   Last Revision: 17-Feb-2011.
%   Copyright 1995-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.6 $ $Date: 2011/04/12 20:46:28 $

% Check input.
nbIN = length(varargin);
error(nargchk(0,Inf,nbIN,'struct'))
if isstruct(X)
    dec = X;
    decFLAG = true;
elseif isnumeric(X)
    decFLAG = false;
else
    error(message('Wavelet:FunctionArgVal:Invalid_ArgTyp'))
end

% Default values.
%----------------
% level_DEF = defined below
% Data_ToCLUST_DEF = defined below
dirDec_DEF  = 'r';
wname_DEF   = 'haar';
distPAR_DEF = 'sqEuclidean';
NbCLU_DEF   = 6;
%----------------------------------

% Initialize.
%------------
dirDec = '';
level = [];
wname = '';
dwtEXTM  = 'sym';
distPAR = '';
Data_ToCLUST = '';
NbCLU   = [];
EmptyPAR = 'drop';
startVAL = 'sample';
RepVAL   = 1;        
Maxiter  = 100;

% Check inputs.
%--------------
for k=1:2:nbIN
    argName = lower(varargin{k});
    argVAL  = varargin{k+1};
    switch argName
        case 'dirdec'   ,    dirDec  = lower(argVAL(1));
        case 'level'    ,    level   = argVAL;
        case 'wname'    ,    wname   = argVAL;  
        case 'dwtextm'  , dwtEXTM = argVAL;                
        case 'distance' ,    distPAR = argVAL;
        case 'maxclust' ,    NbCLU   = argVAL;
        case 'lst2clu'  ,    Data_ToCLUST = argVAL;
        case 'start'    ,    startVAL = argVAL;
        case 'replicates' ,  RepVAL = argVAL;
        case 'maxiter' ,     Maxiter = argVAL;
        case 'emptyaction' , EmptyPAR = argVAL;
    end
end

% Initialize and Check inputs (finish).
%--------------------------------------
if isempty(wname) ,   wname = wname_DEF; end
if isempty(distPAR) , distPAR = distPAR_DEF; end
if isempty(NbCLU) ,   NbCLU = NbCLU_DEF; end
if decFLAG
    dirDec = dec.dirDec;
    if isequal(dirDec,'c') , dec = mswdecfunc('transpose',dec); end
    wname = dec.wname;
    level = dec.level;
    nbSIG = dec.dataSize(1);
else
    if isempty(wname) ,  wname = wname_DEF; end
    if isempty(dirDec) , dirDec = lower(dirDec_DEF(1)); end
    if isequal(dirDec,'c') , X = X'; end
    [nbSIG,nbVAL] = size(X);
    level_DEF = fix(log2(nbVAL));
    if isempty(level) , level = level_DEF; end
end
Data_ToCLUST_DEF = cell(1,level+1);
Data_ToCLUST_DEF(1) = {'s'};
for k=1:level
    Data_ToCLUST_DEF{k+1}= ['ca' int2str(k)];
end
if isempty(Data_ToCLUST) , Data_ToCLUST = Data_ToCLUST_DEF; end
nbPART = length(Data_ToCLUST);

if decFLAG
    if any(strcmp(Data_ToCLUST,'s')) , X = mdwtrec(dec); end
elseif level>0
    dec = mdwtdec('r',X,level,wname,'dwtEXTM',dwtEXTM);
end

nb_NbCLU = length(NbCLU);
IdxCLU   = zeros(nbSIG,nbPART,nb_NbCLU);
% centerCLU = zeros(nbPART,nb_NbCLU,nbVAL);
for j=1:nbPART
    partName = lower(Data_ToCLUST{j});
    switch partName(1)
        case 's'
            XtoCLU = X;
        case {'a','d'}
            num = str2double(partName(2:end));
            XtoCLU = mdwtrec(dec,partName(1),num);
        case 'c'
            num = str2double(partName(3:end));
            switch partName(2)
                case 'd' , XtoCLU = dec.cd{num};
                case 'a' , XtoCLU = mdwtrec(dec,'ca',num);
            end
    end
        
    % Compute clusters.
    for k = 1:nb_NbCLU
        [IdxCLU(:,j,k),~,~,D] = kmeans(XtoCLU,NbCLU(k),...
            'Distance',distPAR,'EmptyAction',EmptyPAR,...
            'Start',startVAL,'Replicates',RepVAL,'Maxiter',Maxiter); %#ok<NASGU>
    end
end
S = struct('IdxCLU',IdxCLU);
