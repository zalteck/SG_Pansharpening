function varargout = cwtftinfo2(ARG)
%CWTFTINFO2 Information on wavelets for CWTFT2
% CWTFTINFO2 provides information on the available wavelets  
% for 2-D Continuous Wavelet Transform using FFT.
% The wavelets are defined by their Fourier transform.
%
% The formulae giving the Fourier transform of 
% the wavelet which short name (see below) is SNAME 
% will be displayed using CWTFTINFO2(SNAME).   
%
% The table below gives the short name of each wavelet
% and the associated parameters: first, the name of parameter 
% and then the default value.
%
% WAV_Param_Table = {...
%     'morl'      , {'Omega0',6;'Sigma',1;'Epsilon',1};
%     'mexh'      , {'p',2;'sigmax',1;'sigmay',1};
%     'paul'      , {'p',4};
%     'dog'       , {'alpha',1.25};
%     'cauchy'    , {'alpha','pi/6';'L',4;'M',4;'sigma',1};
%     'escauchy'  , {'alpha','pi/6';'L',4;'M',4;'sigma',1};
%     'gaus'      , {'p',1;'sigmax',1;'sigmay',1};
%     'wheel'     , {'sigma',2};
%     'fan'       , {'Omega0X',5.336;'Sigma',1;'Epsilon',1;'J',6.5};
%     'pethat'    , {};...
%     'dogpow'    , {'alpha',1.25;'p',2};
%     'esmorl'    , {'Omega0',6;'Sigma',1;'Epsilon',1};
%     'esmexh'    , {'Sigma',1;'Epsilon',0.5};
%     'gaus2'     , {'p',1;'sigmax',1;'sigmay',1};
%     'gaus3'     , {'A',1;'B',1;'p',1;'sigmax',1;'sigmay',1};
%     'isodog'    , {'alpha',1.25,1.25};  
%     'dog2'      , {'alpha',1.25,1.25};
%     'isomorl'   , {'Omega0',6;'Sigma',1};
%     'rmorl'     , {'Omega0',6;'Sigma',1;'Epsilon',1};
%     'endstop1'  , {'Omega0',6};
%     'endstop2'  , {'Omega0',6;'Sigma',1};
%     'gabmexh'   , {'Omega0',5.336;'Epsilon',1};
%     'sinc'      , {'Ax',1;'Ay',1;'p',1;'Omega0X',0;'Omega0Y',0};
%     };
%
% The various wavelets may be grouped in families as follow:
%   MORLET:  'morl'   , 'esmorl' , 'rmorl' , 'isomorl'
%   DOG:     'dog'    , 'isodog' , 'dog2'  , 'dogpow'
%   GAUSS:   'mexh'   , 'gaus'   , 'gaus2' , 'gaus3' , 'esmexh'
%   PAUL:    'paul'
%   CAUCHY:  'cauchy' , 'escauchy'
%   WHEEL:   'wheel', 'pethat'
%   MISCELLANEOUS : 'endstop1' , 'endstop2' , 'gabmexh' , 'sinc' , 'fan'
%
%   REFERENCES
%     Two-Dimensional Wavelets and their Relatives
%     J.-P. Antoine, R. Murenzi, P. Vandergheynst andS. Twareque Ali 
%     Cambridge University Press - 2004
%
%     Two-dimensional wavelet transform profilometry
%     Fringe Pattern Analysis Using Wavelet
%     Liverpool John Moores University 
%     http://www.ljmu.ac.uk
%
%   See also CWTFT2

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 04-Jan-2013.
%   Last Revision: 15-Apr-2013.
%   Copyright 1995-2013 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $ $Date: 2013/05/03 18:19:45 $

if nargin<1
    help cwtftinfo2
else
    try
        fig_EQ = show_EQUA(ARG);
        if nargout>0 , varargout{1} = fig_EQ; end
    catch ME %#ok<NASGU>
        error(getWavMSG('Wavelet:FunctionArgVal:Invalid_ArgNamVar',ARG));
    end
end


%--------------------------------------------------------------------------
function fig_EQ = show_EQUA(ARG)

Lst_WAV = {...
    'morl','mexh','paul','dog' ,'cauchy','gaus', ...
    'wheel','fan','pethat','dogpow','esmorl','esmexh', ...
    'escauchy','gaus2','gaus3','isodog','dog2','isomorl',  ...
    'rmorl','endstop1','endstop2','gabmexh','sinc'  ...
    };
if isequal(ARG,'popCB')
    idx_WAV = get(gcbo,'Value');
else
    idx_WAV = find(strcmpi(ARG,Lst_WAV));
end
if ~ismember(idx_WAV,1:23) ; return; end
imgName = [Lst_WAV{idx_WAV} '.png'];

X = imread(imgName);
fig_EQ = wfindobj(0,'type','figure','Tag','Info_EQUA');
if isempty(fig_EQ)
    % H = 0.34; W = 0.56;
    % posEQ = [0.11 0.50 W H];
    posEQ = [0.11 0.35 0.60 0.48];
    fig_EQ = figure('Visible','Off','Units','normalized',...
        'Position',posEQ,'Menubar','None','NumberTitle','Off', ...
        'Color','w','Tag','Info_EQUA','Colormap',copper(255));
    axes('Units','Normalized','Position',[0.075 0.075 0.85 0.85], ...
        'NextPlot','Replace','Tag','axes_EQ','Visible','Off');
    uicontrol('Style','PopupMenu','String',Lst_WAV, ...
        'Position',[20 10 100 20],'Value',idx_WAV, ...
        'Tag','Pop_EQ_Names','Callback',[mfilename '(''popCB'')'], ...
        'Parent',fig_EQ);
end
axe_EQ = wfindobj(fig_EQ,'type','axes');
Pop_EQ = wfindobj(fig_EQ,'style','PopupMenu');
set(Pop_EQ,'Value',idx_WAV);
image(X,'Visible','On','Parent',axe_EQ); 
axis(axe_EQ,'image'); 
set(axe_EQ,'Xtick',[],'Ytick',[])
[~, imgName] = fileparts(imgName); 
title(imgName,'Parent',axe_EQ,'FontSize',36, ...
    'FontWeight','Bold','Color',[0 90 255]/255)
set(fig_EQ,'Visible','On')
%--------------------------------------------------------------------------

