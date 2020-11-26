function varargout = dcmddeno(varargin)
%DCMDDENO Shows de-noising tools in the Wavelet Toolbox. 
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dcmddeno' 
%
% See also DDENCMP, WAVEDEC, WCODEMAT, WDEN, WDENCMP, WNOISE.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.16.4.6 $

% Initialization and Local functions if necessary.
if nargin>0
	action = varargin{1};
	switch action
      case 'addHelp'
		% Add Help Item.
		%---------------
        hdlFig = varargin{2};
		wfighelp('addHelpItem',hdlFig,'De-noising Procedure','DENO_PROCEDURE');
        
      case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

	  case 'getFigParam'
		figName  = getWavMSG('Wavelet:wavedemoMSGRF:Denoising_1D');
		showType = 'mix8';
		varargout = {figName,showType};
	end
	return
end

if nargout<1,
  wshowdrv(mfilename)
else
  moreSTR = getWavMSG('Wavelet:wavedemoMSGRF:More'); 
  idx = 0;	
  %========== Slide 1 ==========
  idx = idx+1;
  slide(idx).code = {
	  'figHandle = gcf;'	  
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'		  	
	  '' };

  slide(idx).text = {
	  ''
      getWavMSG('Wavelet:wavedemoMSGRF:Press_StartBtn','denoising')
	  ''
	  getWavMSG('Wavelet:wavedemoMSGRF:This_EX_Uses')
	  ''};

  %========== Slide 2 ==========
  idx = idx+1;
  slide(idx).code = {
	  'sigCOL = ''r''; sigCOL_2 = ''r''; noiCOL = ''g''; denCOL = ''b'';'
	  'sqrt_snr = 3; init = 2055615866;'
	  '[xref,x] = wnoise(3,11,sqrt_snr,init);'
	  'snr = sqrt_snr^2;'
      
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  'h(1) = subplot(3,1,1);'
	  'plot(xref,sigCOL), axis([1 2048 -10 10]);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	  'h(2) = subplot(3,1,2);'
	  'plot(x,noiCOL), axis([1 2048 -10 10]);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:NoisySig_SNR'',num2str(fix(snr))));'
	  'set(h(1),''XTick'',[],''XTickLabel'',[]);'	
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_1')};

  slide(idx).info = 'wnoise';

  %========== Slide 3 ==========
  idx = idx+1;
  slide(idx).code = {
	  'lev = 5;'
	  'xd  = wden(x,''heursure'',''s'',''one'',lev,''sym8'');'

	  'h(2) = subplot(3,1,2);'
	  'set(h(2),''XTick'',[],''XTickLabel'',[]);'	
	  'h(3) = subplot(3,1,3); plot(xd); axis([1 2048 -10 10]);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:DenSig_Heur''));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_2')};

  slide(idx).info = 'wden';

  %========== Slide 4 ==========
  idx = idx+1;
  slide(idx).code = {
	  'xd  = wden(x,''rigrsure'',''s'',''one'',lev,''sym8'');'

	  'h(3) = subplot(3,1,3); plot(xd,denCOL); axis([1 2048 -10 10]);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:DenSig_SURE''));'
      
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_3')};

  slide(idx).info = 'wden';

  %========== Slide 5 ==========
  idx = idx+1;
  slide(idx).code = {
	  'xd  = wden(x,''sqtwolog'',''s'',''sln'',lev,''sym8'');'

	  'h(3) = subplot(3,1,3); plot(xd,denCOL); axis([1 2048 -10 10]);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:DenSig_FFTHR''));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_4')};

  slide(idx).info = 'wden';

  %========== Slide 6 ==========
  idx = idx+1;
  slide(idx).code = {
	  'xd  = wden(x,''minimaxi'',''s'',''sln'',lev,''sym8'');'

	  'h(3) = subplot(3,1,3); plot(xd,denCOL); axis([1 2048 -10 10]);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:DenSig_Minimax''));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_5')};

  slide(idx).info = 'wden';

  %========== Slide 7 ==========
  idx = idx+1;
  slide(idx).code = {
	  '[c,l] = wavedec(x,lev,''sym8'');'
	  'xd  = wden(x,''minimaxi'',''s'',''sln'',lev,''sym8'');'	

	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '   ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  '   h(1) = subplot(3,1,1);'
	  '   plot(xref,sigCOL), axis([1 2048 -10 10]);'
	  '   title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	  '   h(2) = subplot(3,1,2);'
	  '   plot(x,noiCOL), axis([1 2048 -10 10]);'
	  '   snr = sqrt_snr^2;'
	  '   title([''Noisy signal - Signal to noise ratio = '',num2str(fix(snr))]);'
	  '   set(h(1:2),''XTick'',[],''XTickLabel'',[]);'
	  'end'

	  'h(3) = subplot(3,1,3); plot(xd,denCOL); axis([1 2048 -10 10]);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:DenSig_Minimax''));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_6')};

  slide(idx).info = 'wden';

  %========== Slide 8 ==========
  idx = idx+1;
  slide(idx).code = {
	  'load leleccum; indx = 2600:3100;'
	  'x = leleccum(indx);'	
	  
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  'h(1) = subplot(2,1,1);'
	  'plot(indx,x,sigCOL);'
      'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	  '' };

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_7')      
	  '         load leleccum; indx = 2600:3100;'
	  '         x = leleccum(indx);'
	  ''};

  %========== Slide 9 ==========
  idx = idx+1;
  slide(idx).code = {
	  '[thr,sorh,keepapp] = ddencmp(''den'',''wv'',x);'
	  'xd = wdencmp(''gbl'',x,''db3'',2,thr,sorh,keepapp);'	
	  
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  'h(1) = subplot(2,1,1);'
	  'plot(indx,x,sigCOL);' 
      'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	  'h(2) = subplot(2,1,2);'
	  'plot(indx,xd,denCOL);' 
      'title(getWavMSG(''Wavelet:wavedemoMSGRF:DenSig''));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_8')};

  slide(idx).info = 'wdencmp';

  %========== Slide 10 ==========
  idx = idx+1;
  slide(idx).code = {
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  'init = 2055615866;'
	  'sqrt_snr = 5;'      % square root of signal to noise ratio.
	  'snr = sqrt_snr^2;'  % signal to noise ratio.
	  '[xref,x] = wnoise(1,11,sqrt_snr,init);'
	  'indx = linspace(0,1,length(x));'
	  'h(1) = subplot(2,1,1);'
	  'plot(indx,x,denCOL,indx,xref,sigCOL_2)'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:NoisOriSig''));'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:SNR'',num2str(fix(snr))))'
	  'xd = wden(x,''heursure'',''s'',''one'',5,''sym8'');'
	  'h(2) = subplot(2,1,2);'
	  'plot(indx,xd,denCOL,indx,xref,sigCOL_2);'
      'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:DenOriSig''));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_9','',5,1)};

  slide(idx).info = 'wden';

  %========== Slide 11 ==========
  idx = idx+1;
  slide(idx).code = {
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  'sqrt_snr = 4;'      % square root of signal to noise ratio.
	  'snr = sqrt_snr^2;'  % signal to noise ratio.
	  '[xref,x] = wnoise(2,11,sqrt_snr,init);'
	  'indx = linspace(0,1,length(x));'
	  'h(1) = subplot(2,1,1);'
	  'plot(indx,x,denCOL,indx,xref,sigCOL_2)'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:NoisOriSig''));'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:SNR'',num2str(fix(snr))))'
	  'xd = wden(x,''rigrsure'',''s'',''one'',5,''sym4'');'
	  'h(2) = subplot(2,1,2);'
	  'plot(indx,xd,denCOL,indx,xref,sigCOL_2);'
      'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:DenOriSig''));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_9',moreSTR,4,2)};

  slide(idx).info = 'wden';

  %========== Slide 12 ==========
  idx = idx+1;
  slide(idx).code = {
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  'sqrt_snr = 3;'      % square root of signal to noise ratio.
	  'snr = sqrt_snr^2;'  % signal to noise ratio.
	  '[xref,x] = wnoise(3,11,sqrt_snr,init);'
	  'indx = linspace(0,1,length(x));'
	  'h(1) = subplot(2,1,1);'
	  'plot(indx,x,denCOL,indx,xref,sigCOL_2)'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:NoisOriSig''));'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:SNR'',num2str(fix(snr))))'
	  'xd = wden(x,''sqtwolog'',''s'',''one'',5,''sym8'');'
	  'h(2) = subplot(2,1,2);'
	  'plot(indx,xd,denCOL,indx,xref,sigCOL_2);' 
      'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:DenOriSig''));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_9',moreSTR,3,3)};

  slide(idx).info = 'wden';

  %========== Slide 13 ==========
  idx = idx+1;
  slide(idx).code = {
	  'set(figHandle,''Name'',''1-D De-noising using wavelet'');'
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  'sqrt_snr = 2;'      % square root of signal to noise ratio.
	  'snr = sqrt_snr^2;'  % signal to noise ratio.
	  '[xref,x] = wnoise(3,11,sqrt_snr,init);'
	  'indx = linspace(0,1,length(x));'
	  'h(1) = subplot(2,1,1);'
	  'plot(indx,x,denCOL,indx,xref,sigCOL_2)'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:NoisOriSig''));'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:SNR'',num2str(fix(snr))))'
	  'xd = wden(x,''sqtwolog'',''s'',''one'',5,''sym8'');'
	  'h(2) = subplot(2,1,2);'
	  'plot(indx,xd,denCOL,indx,xref,sigCOL_2);' 
      'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:DenOriSig''));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_9',moreSTR,2,3)};

  slide(idx).info = 'wden';

  %========== Slide 14 ==========
  idx = idx+1;
  slide(idx).code = {
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  'sqrt_snr = 4;'      % square root of signal to noise ratio.
	  'snr = sqrt_snr^2;'  % signal to noise ratio.
	  '[xref,x] = wnoise(4,11,sqrt_snr,init);'
	  'indx = linspace(0,1,length(x));'
	  'h(1) = subplot(2,1,1);'
	  'plot(indx,x,denCOL,indx,xref,sigCOL_2)'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:NoisOriSig''));'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:SNR'',num2str(fix(snr))))'
	  'xd = wden(x,''minimaxi'',''s'',''one'',5,''sym4'');'
	  'h(2) = subplot(2,1,2);'
	  'plot(indx,xd,denCOL,indx,xref,sigCOL_2);' 
      'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:DenOriSig''));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_9',moreSTR,4,4)};
  
  slide(idx).info = 'wden';

  %========== Slide 15 ==========
  idx = idx+1;
  slide(idx).code = {
	  'row = 2; col = 2;'
	  'load  sinsin'
	  'sm = size(map,1);'
	  
	 ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '   delete(subplot(row,col,2));'
	  'else'
	  '   set(figHandle,''Name'',getWavMSG(''Wavelet:wavedemoMSGRF:Denoising_2D''));'
	  '   ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'
	  '   colormap(pink)'
	  '   h(1) = subplot(row,col,1);'
	  '   image(wcodemat(X,sm));' 
      '   title(getWavMSG(''Wavelet:wavedemoMSGRF:OriImg''));'
	  '   axis(''square'')'
	  '   set(h(1),''XTick'',[],''XTickLabel'',[],''YTick'',[],''YTickLabel'',[]);'
	  'end'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_10')};
  
  %========== Slide 16 ==========
  idx = idx+1;
  slide(idx).code = {
	  'init = 2055615866; rng(init,''twister'');' 
	  'x = X + 18*randn(size(X));'

	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '   delete(subplot(row,col,3));'
	  'else'
	  '   h(2) = subplot(row,col,2);'
	  '   image(wcodemat(x,sm));'
      '   title(getWavMSG(''Wavelet:wavedemoMSGRF:Noisy_Image''));'      
	  '   axis(''square'')'
	  '   set(h(2),''XTick'',[],''XTickLabel'',[],''YTick'',[],''YTickLabel'',[]);'
	  'end'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_11')};

  %========== Slide 17 ==========
  idx = idx+1;
  slide(idx).code = {
	  '[thr,sorh,keepapp] = ddencmp(''den'',''wv'',x);'
	  'xd = wdencmp(''gbl'',x,''sym4'',2,thr,sorh,keepapp);'
	  'h(3) = subplot(row,col,3);'
	  'image(wcodemat(xd,sm));'
      'title(getWavMSG(''Wavelet:wavedemoMSGRF:DenImg''));'      
	  'axis(''square'')'
	  'set(h(3),''XTick'',[],''XTickLabel'',[],''YTick'',[],''YTickLabel'',[]);'	
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmddeno_MSG_12')};

  slide(idx).info = 'wdencmp';

  varargout{1} = slide;
end
