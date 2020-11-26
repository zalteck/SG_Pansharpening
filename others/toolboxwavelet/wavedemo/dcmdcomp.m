function varargout = dcmdcomp(varargin)
%DCMDCOMP Shows compression tools in the Wavelet Toolbox.
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dcmdcomp',
%
% See also WAVEDEC2, WCODEMAT, WDENCMP.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.14.4.4 $

% Initialization and Local functions if necessary.
if nargin>0
	action = varargin{1};
	switch action
      case 'addHelp'
		% Add Help Item.
		%---------------
        hdlFig = varargin{2};
		wfighelp('addHelpItem',hdlFig,'Compression Procedure','COMP_PROCEDURE');
        
	  case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

	  case 'getFigParam'
		figName  = getWavMSG('Wavelet:wavedemoMSGRF:Compression_1D');
		showType = 'mix9';
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
	  'figHandle = gcf;'	  
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'		  	
	  '' };

  slide(idx).text = {
	  ''
      getWavMSG('Wavelet:wavedemoMSGRF:Press_StartBtn_Comp')
	  ''
	  getWavMSG('Wavelet:wavedemoMSGRF:This_EX_Uses')
	  ''};

  %========== Slide 2 ==========
  idx = idx+1;
  slide(idx).code = {
	  'load leleccum; indx = 2600:3100;' 
	  'x = leleccum(indx);'
	  
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  'h(1) = subplot(2,1,1);'
	  'plot(indx,x,''r''), title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	  '' };

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdcomp_MSG_1')      
	  '        load leleccum; indx = 2600:3100;'
	  '        x = leleccum(indx);'
	  ''};

  %========== Slide 3 ==========
  idx = idx+1;
  slide(idx).code = {
	  'thr = 35;'
	  '[xd,cxd,lxd,perf0,perfl2] = wdencmp(''gbl'',x,''db3'',3,thr,''h'',1);'
	  
	  'set(figHandle,''Name'',''Compression 1-D'');'	
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  'h(1) = subplot(2,1,1);'
	  'plot(indx,x,''r''), title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	  
	  'set(h(1),''XTick'',[],''XTickLabel'',[]);'
	  'h(2) = subplot(2,1,2);'
	  'plot(indx,xd), title(getWavMSG(''Wavelet:wavedemoMSGRF:CompSig''));'
      'N2Str = getWavMSG(''Wavelet:wavedemoMSGRF:Norm_L2'',num2str(perfl2,''%5.2f''));'
      'N0Str = getWavMSG(''Wavelet:wavedemoMSGRF:NumberOf_ZER'',num2str(perf0,''%5.2f''));'
	  'xlabel([N2Str,'' - '',N0Str])'
	  ''};

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdcomp_MSG_2')      
	  '        thr = 35;'
	  '        [xd,cxd,lxd,perf0,perfl2] = wdencmp(''gbl'',x,''db3'',3,thr,''h'',1);'
	  ''};

  slide(idx).info = 'wdencmp';

  %========== Slide 4 ==========
  idx = idx+1;
  slide(idx).code = {
	  'subr = 1; subc = 2;'
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV<idxSlide'
	  '   set(figHandle,''Name'',''Compression 2-D'');'
	  '   ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  '   load woman; x = X(100:200,100:200);'
	  '   nbc = size(map,1);'	
	  '   h(1) = subplot(subr,subc,1);'
	  '   colormap(pink(nbc));'
	  '   image(wcodemat(x,nbc)); title(getWavMSG(''Wavelet:wavedemoMSGRF:OriImg''));'
	  '   axis(''square'');'
	  '   set(h(1),''XTick'',[],''YTick'',[]);'
	  'else'
	  '   delete(subplot(subr,subc,2));'
	  'end'
	  '' };

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:Load_OriImg')      
	  '        load woman; x = X(100:200,100:200);'
	  ''};

  %========== Slide 5 ==========
  idx = idx+1;
  slide(idx).code = {
	  'n = 5; w = ''sym2'';' 
	  '[c,l] = wavedec2(x,n,w);'
	  'thr = 20;'
	  '[xd,cxd,lxd,perf0,perfl2] = wdencmp(''gbl'',c,l,w,n,thr,''h'',1);'
	  
	  'h(2) = subplot(subr,subc,2);'
	  'image(wcodemat(xd,nbc));'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:CompImg_THR'',num2str(thr)));'
      'N2Str = getWavMSG(''Wavelet:wavedemoMSGRF:Norm_L2'',num2str(perfl2,''%5.2f''));'
      'N0Str = getWavMSG(''Wavelet:wavedemoMSGRF:NumberOf_ZER'',num2str(perf0,''%5.2f''));'
	  'xlabel({N2Str,N0Str});'
	  'axis(''square'');'
	  'set(h(2),''XTick'',[],''YTick'',[]);'	
	  '' };

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdcomp_MSG_3_0')
      '       n = 5; w = ''sym2'';'
      '       [ c,l] = wavedec2(x,n,w);'
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdcomp_MSG_3_1')      
	  ''};

  slide(idx).info = 'wdencmp';

  %========== Slide 5 ==========
  idx = idx+1;
  slide(idx).code = {
	  'thr_h = [17 18];'        % horizontal thresholds.
	  'thr_d = [19 20];'        % diagonal thresholds.
	  'thr_v = [21 22];'        % vertical thresholds.
	  'thr = [thr_h ; thr_d ; thr_v];'        
	  '[xd,cxd,lxd,perf0,perfl2] = wdencmp(''lvd'',x,''sym8'',2,thr,''h'');'

	  'h(2) = subplot(subr,subc,2);'
	  'image(wcodemat(xd,nbc));'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:CompImg_THR_2'',''[17 18;19 20;21 22]''));'
      'N2Str = getWavMSG(''Wavelet:wavedemoMSGRF:Norm_L2'',num2str(perfl2,''%5.2f''));'
      'N0Str = getWavMSG(''Wavelet:wavedemoMSGRF:NumberOf_ZER'',num2str(perf0,''%5.2f''));'
	  'xlabel({N2Str,N0Str});'
	  'axis(''square'');'
	  'set(h(2),''XTick'',[],''YTick'',[]);'	
	  '' };

  slide(idx).text = {...
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdcomp_MSG_4'), ...
	  '         thr_h = [17 18];        % horizontal thresholds.' , ...
	  '         thr_d = [19 20];        % diagonal thresholds.', ...
	  '         thr_v = [21 22];        % vertical thresholds.', ...
	  '         thr = [thr_h ; thr_d ; thr_v]', ... 
	  '         [xd,cxd,lxd,perf0,perfl2] = wdencmp(''lvd'',x,''sym8'',2,thr,''h'');', ...
	  ''};
 
  slide(idx).info = 'wdencmp';

  varargout{1} = slide;
end
