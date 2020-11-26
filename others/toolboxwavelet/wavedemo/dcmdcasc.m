function varargout = dcmdcasc(varargin)
%DCMDCASC Shows cascade algorithm in the Wavelet Toolbox.
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dcmdcasc' 
%   
%   See also WAVEFUN.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.14.4.5 $

% Initialization and Local functions if necessary.
if nargin>0
	action = varargin{1};
	switch action
	  case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

	  case 'getFigParam'
		figName  = getWavMSG('Wavelet:wavedemoMSGRF:Cascade_ALG');
		showType = 'mix9';
		varargout = {figName,showType};
		
	  case 'initShowViewer'
		figHandle = varargin{2};
		slideData = get(figHandle,'UserData');
		autoHndl = slideData.autoHndl;
		propAuto = get(autoHndl,{'Units','Position','BackgroundColor'});
		txtBkColor = get(slideData.slitxtHndl,'BackgroundColor');
		pos  = propAuto{2};
		hBtn = pos(4);
		pos(2) = pos(2)-2*hBtn;
		popstr = {'sym4','sym8','db3','db5','db8','coif1','coif5'};
		txtstr = getWavMSG('Wavelet:commongui:Str_Wavelet');
		propUIC = {'Units',propAuto{1},'Position',pos,'BackgroundColor',txtBkColor};
		slideData.txtLocHandle = uicontrol('Parent',figHandle,...
			'Style','text','String',txtstr,propUIC{:});
		pos(2) = pos(2)-hBtn+hBtn/3;
		propUIC = {'Units',propAuto{1},'Position',pos,'BackgroundColor',propAuto{3}};
		propAuto{2} = pos;
		propUIC{4} = propAuto{2};		
		slideData.popLocHandle = uicontrol('Parent',figHandle,...
			'Style','popupmenu','String',popstr,propUIC{:},'Tag','popWave');
		set(figHandle,'UserData',slideData);
	end
	return
end

if nargout<1,
  wshowdrv(mfilename)
else
  idx = 0;	
  %========== Slide 1 ==========
  idx = idx+1;
  slide(idx).code = {
	'figHandle = gcf;' 
	'ax  = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	'popTMP = findobj(figHandle,''Style'',''popupmenu'');'
	'set(popTMP,''Enable'',''on'');'
	'' };

  slide(idx).text = {
	''
    getWavMSG('Wavelet:wavedemoMSGRF:Press_StartBtn_Casc')
	''
	getWavMSG('Wavelet:wavedemoMSGRF:This_EX_Uses')
	''};

  %========== Slide 2 ==========
  idx = idx+1;
  slide(idx).code = {
	'pop = findobj(figHandle,''Style'',''popupmenu'');'
	'lstWAV = get(pop,''String''); idxWAV = get(pop,''Value'');'
	'set(pop,''Enable'',''off'');'
	'wname = lstWAV{idxWAV};'
	'comma = char(39);'
	'newTXT = [''        wname = '',comma,wname,comma,'';''];'
	'wshowdrv(''#modify_Comment'',figHandle,3,newTXT);'
	'ax = findall(figHandle,''Type'',''axes''); delete(ax); h = [];'		  	
	'strINIT = getWavMSG(''Wavelet:wavedemoMSGRF:dcmdcasc_MSG_1'',wname);'
	'iter = 10;'
	'for i = 1:iter'
	'    [phi,psi,xval] = wavefun(wname,i);'
	'    plot(xval,psi);'
	'    hold on'
	'	 title(getWavMSG(''Wavelet:wavedemoMSGRF:dcmdcasc_MSG_2'',wname,i));'
	'    if      i==1 ,           pause(2)'
	'    elseif  (1<i) & (i<=4) , pause(1)'
	'    else ,                   pause(0.5)'
	'    end'
	'    drawnow'
	'end'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:dcmdcasc_MSG_3'',wname,iter));'
	'linw = 2;'
	'h = plot(xval,psi,''r'',''LineWidth'',linw);'
	'drawnow'
	'hold off'
	'' };

  slide(idx).text = {
    getWavMSG('Wavelet:wavedemoMSGRF:dcmdcasc_MSG_4')      
	'        wname = ''sym4'';'
	'        iter = 10;'
	'        for i = 1:iter'
	'            [phi,psi,xval] = wavefun(wname,i);'
	'            plot(xval,psi);'
	'            hold on'
	'            drawnow'
	'        end'
	''};

  slide(idx).info = 'wavefun';

  %========== Slide 3 ==========
  idx = idx+1;
  slide(idx).code = {
	'ax = findall(figHandle,''Type'',''axes''); delete(ax); h = [];'
	'wshowdrv(''#modify_Comment'',figHandle,3,newTXT);'
	'strINIT = getWavMSG(''Wavelet:wavedemoMSGRF:dcmdcasc_MSG_1'',wname);'
	'[phi,psi,xval] = wavefun(wname,iter);'
	'h = plot(xval,psi,''r'',''LineWidth'',linw);'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:dcmdcasc_MSG_5'',wname,iter));'
	'drawnow'
	'' };

  slide(idx).text = {
    getWavMSG('Wavelet:wavedemoMSGRF:dcmdcasc_MSG_4')      
	'        wname = ''sym4'';'
	'        iter = 10;'
	'        [phi,psi,xval] = wavefun(wname,iter);'
	'        plot(xval,psi,''r'');'
	''};

  slide(idx).info = 'wavefun';

  varargout{1} = slide;
end


