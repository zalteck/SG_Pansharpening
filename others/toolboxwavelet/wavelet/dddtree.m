function dt = dddtree(typetree,x,L,varargin)
%DDDTREE Forward real and complex double and Double-Density 
%        Dual-Tree 1-D DWT
%   DT = DDDTREE(TYPETREE,X,L,FDF,DF) returns the decomposition 
%   dual-tree or double density dual-tree structure of the vector 
%   X using the filters FDF and DF.
%
%   TYPETREE gives the type of the required tree. It may be
%   equal to 'dwt', 'cplxdt', 'ddt' or 'cplxdddt'
%
%   L is an integer which gives the level (number of stages) of 
%   the decomposition.
%
%   FDf and Df are cell arrays of vectors.
%     FDf{k}: First stage filters for tree k (k = 1,2)
%     Df{k} : Filters for remaining stages on tree k
%
%   X is a vector of even length N.
%   L and N must be such that:
%     N >= 2^(L-1)*length(filters)) and 2^L divide N.
%
%   DT is a structure which contains four fields:
%      type:    type of tree.
%      level:   level of decomposition.
%      filters: structure containing filters for 
%               decomposition and reconstruction
%          | FDf: First stage decomposition filters
%          |  Df: Decomposition filters for remaining stages
%          | FRf: First stage reconstruction filters
%          |  Rf: Reconstruction filters for remaining stages
%      cfs: coefficients of wavelet  transform 1 by L cell array
%           depending on TYPETREE (see below).
%
%	The same decomposition structure DT may be obtained using
%   the filters names instead of the filters values:
%       DT = DDDTREE(TYPETREE,X,L,fname1) or 
%       DT = DDDTREE(TYPETREE,X,L,fname1,fname2) or 
%       DT = DDDTREE(TYPETREE,X,L,{fname1,fname2})
%   The same result is obtained using:
%       DT = DDDTREE(TYPETREE,X,L,{FDF,DF}) 
%   The number of and the type of required filters depend 
%   on TYPETREE.
%    
%   cfs (1 by L cell array) is given by:
%       If TYPETREE is 'dwt' - usual dwt tree (1 filter):
%           cfs{j} - wavelet coefficients
%               j = 1,...,L  (scale)
%           cfs{L+1} - lowpass or scaling coefficients
% 
%       If TYPETREE is 'cplxdt' - complex dual tree (2 filters):
%           cfs{j}(:,:,m) - wavelet coefficients
%               j = 1,...,L  (scale)
%               m = 1 (real part) , m = 2 (imag part)
%           cfs{L+1}(:,:,m) - lowpass or scaling coefficients
% 
%       If TYPETREE is 'ddt' - real double density dual tree  (1 filters):
%           cfs{j}(:,:,k) - wavelet coefficients
%               j = 1,...,L   (scale)
%               k = 1,2       (tree number)
%           cfs{L+1}(:,:) - lowpass or scaling coefficients
% 
%       If TYPETREE is 'cplxdddt' - complex double density dual tree  (2 filters):
%           cfs{j}(:,:,k,m) - wavelet coefficients
%               j = 1,...,L   (scale)
%               k = 1,2       (tree number)
%               m = 1 (real part) , m = 2 (imag part)
%           cfs{L+1}(:,:,m) - lowpass or scaling coefficients
%
%   See also IDDDTREE, DTFILTERS, DDDTREE2.

%   M. Misiti, Y. Misiti, G. Oppenheim, L.M. Poggi 21-Dec-2012.
%   Last Revision: 22-Apr-2013.
%   Copyright 1995-2013 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $

% Check inputs
narginchk(4,5)
len = length(x);
SL = len/2^L;
if rem(len,2)
    error(getWavMSG('Wavelet:FunctionArgVal:Invalid_LengthVal','X'));    
elseif (SL-fix(SL)>0)
    error(getWavMSG('Wavelet:FunctionArgVal:Invalid_SizVal','L'));    
end

nbIN = length(varargin);
switch nbIN
    case 1
        if isnumeric(varargin{1})
            Df = varargin{1};  FDf = Df;
        elseif ischar(varargin{1})
            Df = dtfilters(varargin{1},'d');
            if iscell(Df) , FDf = Df{1}; Df = Df{2}; else FDf = Df; end      
        elseif iscell(varargin{1})
            len = length(varargin{1});
            if isnumeric(varargin{1}{1})
                if isequal(len,1)
                    Df = varargin{1}{1}; FDf = Df;
                else
                    FDf = varargin{1}{1}; Df = varargin{1}{2};
                end
            elseif ischar(varargin{1}{1})
                if isequal(len,1)
                    Df = dtfilters(varargin{1}{1},'d');
                    FDf = Df; 
                else
                    FDf = dtfilters(varargin{1}{1},'d');
                    Df = dtfilters(varargin{1}{2},'d');
                end
            else
                FDf = varargin{1}{1};
                Df  = varargin{1}{2};
            end
        end
        
    case 2
        if isnumeric(varargin{1}) || iscell(varargin{1});
            FDf = varargin{1};  
            Df = varargin{2};
        elseif ischar(varargin{1})
            FDf = dtfilters(varargin{1},'d');
            Df  = dtfilters(varargin{2},'d');
        end
end

switch typetree
    case 'dwt'
    % Discrete 1-D Wavelet Transform
        % Decomposition
        cfs = cell(1,L+1);
        for j = 1:L
            [x,cfs{j}] = decFB(x,Df);
        end
        cfs{L+1} = x;

    case 'realdt'
    % Dual-tree real Discrete 1-D Wavelet Transform
        % normalization
        x = x/sqrt(2);
        cfs = cell(1,L+1);
        
        % Tree 1 and 2
        for k= 1:2  
            y = x;
            for j = 1:L
                if j==1 , decF = FDf{k}; else decF = Df{k}; end
                [y,cfs{j}(:,:,k)] = decFB(y,decF);
            end
            cfs{L+1}(:,:,k) = y;
        end        
        
    case 'cplxdt'
    % Dual-tree Complex Discrete 1-D Wavelet Transform
        % normalization
        x = x/sqrt(2);
        cfs = cell(1,L+1);
        
        % Tree 1 and 2
        for k= 1:2  
            y = x;
            for j = 1:L
                if j==1 , decF = FDf{k}; else decF = Df{k}; end
                [y,cfs{j}(:,:,k)] = decFB(y,decF);
            end
            cfs{L+1}(:,:,k) = y;
        end        

    case 'ddt'
    % Double-Density Discrete 1-D Wavelet Transform
        cfs = cell(1,L+1);
        for j = 1:L
            [x,cfs{j}(:,:,1),cfs{j}(:,:,2)] = decFB3(x,Df);
        end
        cfs{L+1} = x;
        
    case 'cplxdddt'
    % Double-Density Dual-Tree 1-D Wavelet Transform (complex)
        % normalization
        x = x/sqrt(2);
        cfs = cell(1,L+1);
         
        % Tree 1 and 2
        for k = 1:2 
            y = x;
            for j = 1:L
                if j==1 , decF = FDf{k}; else decF = Df{k}; end
                [y,cfs{j}(:,:,1,k),cfs{j}(:,:,2,k)] = decFB3(y,decF);
            end
            cfs{L+1}(:,:,k) = y;
        end
end
dt.type = typetree;
dt.level = L;
F.FDf = FDf; F.Df  = Df;
if ~iscell(FDf)
    F.FRf = flipud(FDf);
else
    for k = 1:length(FDf) , FDf{k} = flipud(FDf{k}); end
    F.FRf = FDf;
end
if ~iscell(Df)
    F.Rf = flipud(Df);
else
    for k = 1:length(Df) , Df{k} = flipud(Df{k}); end
    F.Rf = Df;
end
dt.filters = F;
dt.cfs = cfs;

%-------------------------------------------------------------------------
function [Lo,Hi] = decFB(x,Df)
% Decomposition filter bank
% INPUT:
%    x - N-point vector, where
%            1) N is even
%            2) N >= length(Df)
%    Df - analysis filters
%    Df(:, 1) - lowpass filter (even length)
%    Df(:, 2) - highpass filter (even length)
% OUTPUT:
%    Lo - Low frequecy output
%    Hi - High frequency output

N = length(x);
D = length(Df)/2;
x = wshift('1d',x,D);

% lowpass filter
Lo = dyaddown(conv(x,Df(:,1)),1);
Lo(1:D) = Lo(N/2+(1:D)) + Lo(1:D);
Lo = Lo(1:N/2);

% highpass filter
Hi = dyaddown(conv(x,Df(:,2)),1);
Hi(1:D) = Hi(N/2+(1:D)) + Hi(1:D);
Hi = Hi(1:N/2);
%-------------------------------------------------------------------------
function [Lo,H1,H2] = decFB3(x,Df)
% Decomposition Filter Bank (three filters)
%
% INPUT:
%     x - N-point vector (N even and N >= length(Df))
%    Df - analysis filters (even lengths)
%       Df(:,1)   - lowpass filter
%       Df(:,2:3) - two highpass filters
%
% OUTPUT:
%     Lo - low frequency output
%     H1, H2 - first and second high frequency output

N = length(x);
D = length(Df)/2;
x = wshift('1d',x,D);

% lowpass filter
Lo = dyaddown(conv(x,Df(:,1)),1);
Lo(1:D) = Lo(N/2+(1:D)) + Lo(1:D);
Lo = Lo(1:N/2);

% first highpass filter
H1 = dyaddown(conv(x,Df(:,2)),1);
H1(1:D) = H1(N/2+(1:D)) + H1(1:D);
H1 = H1(1:N/2);

% second highpass filter
H2 = dyaddown(conv(x,Df(:,3)),1);
H2(1:D) = H2(N/2+(1:D)) + H2(1:D);
H2 = H2(1:N/2);
%-------------------------------------------------------------------------
