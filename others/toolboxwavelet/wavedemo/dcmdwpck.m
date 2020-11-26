function varargout = dcmdwpck(varargin)
%DCMDWPCK Shows wavelet packet tools in the Wavelet Toolbox. 
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dcmdwpck' 
%
% See also DDENCMP, WCODEMAT, WDEN, WDENCMP, WNOISE, WPDENCMP.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.14.4.8 $

% Initialization and Local functions if necessary.
if nargin>0
	action = varargin{1};
	switch action
      case 'addHelp'
		% Add Help Item.
		%---------------
        hdlFig = varargin{2};
		wfighelp('addHelpItem',hdlFig, ...
            getWavMSG('Wavelet:wavedemoMSGRF:Str_wpck'),'WP_PACKETS');
		wfighelp('addHelpItem',hdlFig, ...
            getWavMSG('Wavelet:dw1dRF:HLP_CompProc'),'COMP_PROCEDURE');
        wfighelp('addHelpItem',hdlFig, ...
            getWavMSG('Wavelet:dw1dRF:HLP_DenoProc'),'DENO_PROCEDURE');
        
      case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

	  case 'getFigParam'
		figName  = getWavMSG('Wavelet:wavedemoMSGRF:WPCK_Example');
		showType = 'mix7';
		varargout = {figName,showType};
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
	  'figHandle = gcf;';
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; '		  	
	  '' };

  slide(idx).text = {
	  ''
      getWavMSG('Wavelet:wavedemoMSGRF:Press_StartBtn','wavelet packet')
	  ''
	  getWavMSG('Wavelet:wavedemoMSGRF:This_EX_Uses')
	  ''};

  %========== Slide 2 ==========
  idx = idx+1;
  slide(idx).code = {
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; '		  	
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdwpck_MSG_1')};

  %========== Slide 3 ==========
  idx = idx+1;
  slide(idx).code = {
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if (idxPREV<idxSlide) | (idxPREV>idxSlide+1)'
	  '   init = 2055615866; rng(init,''twister'');' 
	  '   [xref,x] = wnoise(5,11,7,init);'
	  '   wshowdrv(''#set_axes'',figHandle,[4,1]);'
	  '   h = wshowdrv(''#get_axes'',figHandle);'
	  '   set(h(1),''Visible'',''on'');'    
	  '   axes(h(1)); plot(xref,''r'');' 
      '   title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	  '   axis([1 length(xref) min(xref)-eps max(xref)+eps]);'
	  '   set(h(2),''Visible'',''on'');'
	  '   axes(h(2)); plot(x,''g'');'
      '   title(getWavMSG(''Wavelet:wavedemoMSGRF:Noisy_Signal''));'      
	  '   axis([1 length(x) min(x)-eps max(x)+eps]);'
	  '   p3 = get(h(3),''Position''); p4 = get(h(4),''Position'');'
	  '   p5 = [p4(1:3), p3(2)+p3(4)-p4(2)];'
	  '   try , delete(h(5)); end'
	  '   h(5) = axes(''Position'',p5,''Visible'',''Off'');'
	  '   wtbxappdata(''set'',figHandle,''local_AXES'',h);'
	  'else'
	  '   h = wtbxappdata(''get'',figHandle,''local_AXES'');'
	  '   set(findobj(h(3)),''Visible'',''off'');'
	  'end'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdwpck_MSG_2')};

  slide(idx).info = 'wnoise';

  %========== Slide 4 ==========
  idx = idx+1;
  slide(idx).code = {
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';'] 
	  'if idxPREV<idxSlide'
	  '   xwpd = wtbxappdata(''get'',h(3),''xwpd'');'
	  '   if isempty(xwpd)'
	  '      n = length(x); thr = sqrt(2*log(n*log(n)/log(2)));'
	  '      xwpd = wpdencmp(x,''s'',4,''sym4'',''sure'',thr,1);'
	  '      wtbxappdata(''set'',h(3),''xwpd'',xwpd);'
	  '   end'
	  '   set(h(3),''Visible'',''on'');'
	  '   axes(h(3)); plot(xwpd);'
      '   title(getWavMSG(''Wavelet:wavedemoMSGRF:DenSig_WP''));'            
	  '   axis([1 length(xwpd) min(xwpd)-eps max(xwpd)+eps]);'
	  'else'
	  '   set(findobj(h(4)),''Visible'',''off'');'
	  'end'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdwpck_MSG_3')};

  slide(idx).info = 'wpdencmp';

  %========== Slide 5 ==========
  idx = idx+1;
  slide(idx).code = {
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV<idxSlide'
	  '   xwd = wtbxappdata(''get'',h(4),''xwd'');'
	  '   if isempty(xwd)'
	  '      xwd = wden(x,''rigrsure'',''s'',''one'',4,''sym4'');'
	  '      wtbxappdata(''set'',h(4),''xwd'',xwd);'
	  '   end'
	  '   set(h(4),''Visible'',''on'');'
	  '   axes(h(4)); plot(xwd);'
      '   title(getWavMSG(''Wavelet:wavedemoMSGRF:DenSig_WAV''));'                  
	  '   axis([1 length(xwd) min(xwd)-eps max(xwd)+eps]);'
	  'else'
	  '   set(findobj(h(5)),''Visible'',''Off'');'
	  '   set(findobj(h(3:4)),''Visible'',''On'');'
	  '   xlim = get(h(3),''XLim'');'
	  '   set(h([1,2,5]),''XLim'',xlim);'
	  'end'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdwpck_MSG_4')};

  slide(idx).info = 'wden';

  %========== Slide 6 ==========
  idx = idx+1;
  slide(idx).code = {
	  'xwpd = wtbxappdata(''get'',h(3),''xwpd'');'
	  'xwd  = wtbxappdata(''get'',h(4),''xwd'');'
	  'set(findobj(h(3:4)),''Visible'',''Off'')'
	  'set(h(1:2),''XTickLabel'',[]);'
	  'set(h(5),''Visible'',''on'');'
	  'ind = 1:800;'
	  'axes(h(5)); plot(ind,xwd(ind),''b'',ind,xwpd(ind),''m'')'
      'title(getWavMSG(''Wavelet:wavedemoMSGRF:DenSig_WP_WAV''));'                  
	  'set(h([1,2,5]),''XLim'',[1 800]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdwpck_MSG_5')};

  %========== Slide 7 ==========
  idx = idx+1;
  slide(idx).code = {
	  'load detfingr'
	  '[r,c] = size(X);  X = X(1:2:r,1:2:c);' 
	  'sm = size(map,1); colormap(pink(sm))'
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if (idxPREV<idxSlide) | (idxPREV>idxSlide+1)'
	  '   ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; '	
	  '   tmp = subplot(1,2,1); image(wcodemat(X,sm));'
      '   title(getWavMSG(''Wavelet:wavedemoMSGRF:OriImg''));'
	  '   axis(''square'');'
	  '   set(tmp,''XTick'',[],''YTick'',[]);'
	  'else'
	  '   set(findobj(subplot(1,2,2)),''Visible'',''Off'')'
	  'end'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdwpck_MSG_6')};

  slide(idx).idxPrev = 3;

  %========== Slide 8 ==========
  idx = idx+1;
  slide(idx).code = {
	  'set(findobj(subplot(1,2,2)),''Visible'',''Off'')'
	  ''};

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdwpck_MSG_7')
      '        sorh = ''h''; lev = 3;'
	  '        crit = ''shannon'';'
	  '        thr = 30;'
	  '        keepapp = 1;'
	  '        [xd,t,perf0,perfl2] = ... '
	  '                wpdencmp(X,sorh,lev,''bior6.8'',crit,thr,keepapp);'
	  ''};

  slide(idx).info = 'wpdencmp';

  %========== Slide 9 ==========
  idx = idx+1;
  slide(idx).code = {
	  'ax = subplot(1,2,1);'
	  'denFLAG_1 = wtbxappdata(''get'',ax,''denFLAG_1'');'
	  'if isempty(denFLAG_1)'
	  '   lev = 3; sorh = ''h''; crit = ''shannon''; thr = 30; keepapp = 1;'
	  '   [xd,t,perf0,perfl2] = wpdencmp(X,sorh,lev,''bior6.8'',crit,thr,keepapp);'
	  '   tmp = subplot(1,2,2); image(wcodemat(xd,sm));'
      '   title(getWavMSG(''Wavelet:commongui:CompImg''));'
      '   N2Str = getWavMSG(''Wavelet:wavedemoMSGRF:Norm_L2'',num2str(perfl2,''%5.2f''));'
      '   N0Str = getWavMSG(''Wavelet:wavedemoMSGRF:NumberOf_ZER'',num2str(perf0,''%5.2f''));'
	  '   xlabel({N2Str,N0Str});'
	  '   axis(''square'');'
	  '   set(tmp,''XTick'',[],''YTick'',[]);'
	  '   wtbxappdata(''set'',ax,''denFLAG_1'',1);'
	  'else'
	  '  set(findobj(subplot(1,2,2)),''Visible'',''On'')'
	  'end'
	  ''};

  slide(idx).text = slide(idx-1).text;

  slide(idx).info = 'wpdencmp';

  %========== Slide 10 ==========
  idx = idx+1;
  slide(idx).code = {
	  'load  sinsin;  X = X(1:64,1:64);'
	  'sm = size(map,1); colormap(pink(sm))'
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV<idxSlide'
	  '   ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; '	  
	  '   tmp = subplot(2,2,1); image(wcodemat(X,sm));' 
      '   title(getWavMSG(''Wavelet:wavedemoMSGRF:OriImg''));'
	  '   set(tmp,''XTick'',[],''YTick'',[]);'
	  'else'
	  '   set(findobj(subplot(2,2,2)),''Visible'',''Off'')'
	  'end'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdwpck_MSG_8')};

  slide(idx).idxPrev = 7;

  %========== Slide 11 ==========
  idx = idx+1;
  slide(idx).code = {
	  'init = 2055615866; rng(init,''twister'');'
	  'x = X+15*randn(size(X));'
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV<idxSlide'
	  '   tmp = subplot(2,2,2); image(wcodemat(x,sm));' 
      '   title(getWavMSG(''Wavelet:wavedemoMSGRF:Noisy_Image''));'
	  '   set(tmp,''XTick'',[],''YTick'',[]);'
	  'else'
	  '   set(findobj(subplot(2,2,3)),''Visible'',''Off'')'
	  'end'
	  ''};
  
  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdwpck_MSG_9')
	  '        init = 2055615866; rng(init,''twister'');'
	  '        x = X+15*randn(size(X));'
	  ''};
  
  %========== Slide 12 ==========
  idx = idx+1;
  slide(idx).code = {
	  'ax = subplot(2,2,1);'
	  'denFLAG_2 = wtbxappdata(''get'',ax,''denFLAG_2'');'
	  'if isempty(denFLAG_2)'
	  '   [thr,sorh,keepapp,crit] = ddencmp(''den'',''wp'',x);'
	  '   n  = length(x(:)); thr = sqrt(2*log(n*log(n)/log(2)))*15;'
	  '   xd = wpdencmp(x,sorh,3,''sym4'',crit,thr,keepapp);'
	  '   tmp = subplot(2,2,3); image(wcodemat(xd,sm));'
      '   title(getWavMSG(''Wavelet:wavedemoMSGRF:DenoImg''));'
	  '   set(tmp,''XTick'',[],''YTick'',[]);'
	  '   wtbxappdata(''set'',ax,''denFLAG_2'',1);'
	  'else'
	  '   set(findobj(subplot(2,2,3)),''Visible'',''On'')'
	  'end'
	  ''};
  
  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdwpck_MSG_10')};

  slide(idx).info = 'wpdencmp';

  varargout{1} = slide;
end
