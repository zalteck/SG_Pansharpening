function varargout = dguiiext(varargin)
%DGUIIEXT Shows Image extension GUI tools in the Wavelet Toolbox.
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dguiiext',

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 03-Jul-99.
%   Last Revision: 12-Apr-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.7.4.4 $  $Date: 2012/05/04 00:20:11 $

% Initialization and Local functions if necessary.
if nargin>0
    action = varargin{1};
    switch action
        case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
        case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

        case 'getFigParam'
            figName  = 'Wavelet GUI Example: Image Extension';
            showType = 'command';
            varargout = {figName,showType};

        case 'slidePROC_Init'
            figHandle = varargin{2};
            localPARAM = wtbxappdata('get',figHandle,'localPARAM');
            if ~isempty(localPARAM)
                active_fig = localPARAM{1};
                delete(active_fig);
                wtbxappdata('del',figHandle,'localPARAM');
            end

        case 'slidePROC'
            [figHandle,idxSlide]  = deal(varargin{2:end});
            localPARAM = wtbxappdata('get',figHandle,'localPARAM');
            if isempty(localPARAM)
                active_fig = imgxtool;
                wenamngr('Inactive',active_fig);
                localPARAM = {active_fig};
                wtbxappdata('set',figHandle,'localPARAM',localPARAM);
                wshowdrv('#modify_cbClose',figHandle,active_fig,'imgxtool');
            else
                active_fig = deal(localPARAM{:});
            end
            numDEM = idxSlide-1;
            demoSET = {...
                'woman2'  , 'ext'   , {'zpd' , [220,200] , 'both' , 'both'} , 'BW' ; ...
                'woman2'  , 'trunc' , {'nul' , [ 96, 96] , 'both' , 'both'} , 'BW' ; ...
                'wbarb'   , 'ext'   , {'sym' , [512,200] , 'right', 'both'} , 'BW' ; ...
                'noiswom' , 'ext'   , {'sym' , [512,512] , 'right', 'down'} , 'BW' ; ...
                'noiswom' , 'ext'   , {'ppd' , [512,512] , 'right', 'down'} , 'BW' ; ...
                'wbarb'   , 'ext'   , {'sym' , [512,512] , 'both' , 'both'} , 'BW' ; ...
                'facets'  , 'ext'   , {'ppd' , [512,512] , 'both' , 'both'} , 'COL' ; ...
                'mandel'  , 'ext'   , {'sym' , [512,512] , 'left' , 'both'} , 'COL'  ...
                };
            nbDEM = size(demoSET,1);
            if ismember(numDEM,1:nbDEM)
                paramDEM = demoSET(numDEM,:);
                imgxtool('demo',active_fig,paramDEM{:});
                wfigmngr('storeValue',active_fig,'File_Save_Flag',1);
                wenamngr('Inactive',active_fig);
            end
    end
    return
end

if nargout<1,
    wshowdrv(mfilename)
else
    idx = 0;	slide(1).code = {}; slide(1).text = {};

    %========== Slide 1 ==========
    idx = idx+1;
    slide(idx).code = {
        'figHandle = gcf;'
        [mfilename ,'(''slidePROC_Init'',figHandle);']
        '' };

    %========== Slide 2 to 9 ==========
    for idx = 2:9
        slide(idx).code = {
            [mfilename ,'(''slidePROC'',figHandle,', int2str(idx), ');']
            };
    end

    varargout{1} = slide;

end

