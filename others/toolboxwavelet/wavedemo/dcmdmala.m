function varargout = dcmdmala(varargin)
%DCMDMALA Shows Mallat algorithm in the Wavelet Toolbox. 
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dcmdmala', 
%
% See also CONV, DWT, IDWT, DYADDOWN, DYADUP, WFILTERS, WKEEP.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.13.4.6 $

% DEMALLAT Short example about basic steps of FWT 1-D.
% Non documented function, example function file.

% Initialization and Local functions if necessary.
if nargin>0
	action = varargin{1};
	switch action
	  case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

	  case 'getFigParam'
		figName  = getWavMSG('Wavelet:wavedemoMSGRF:Mallat_ALG');
		showType = 'mix6';
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
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	  '' };
 
  slide(idx).text = {
	  ''
      getWavMSG('Wavelet:wavedemoMSGRF:Press_StartBtn_Mala')
	  ''
	  getWavMSG('Wavelet:wavedemoMSGRF:This_EX_Uses')
	  ''};

  %========== Slide 2 ==========
  idx = idx+1;
  slide(idx).code = {
	  's = 2 + kron(ones(1,8),[1 -1]) + ((1:16).^2)/32 + 0.2*randn(1,16);'
	  'h(1) = subplot(3,1,1); plot(s,''r'');'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	  'set(h(1),''XLim'',[1 16])'
	  'delete(findobj([subplot(3,2,3);subplot(3,2,4)]));'
	  '' };

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_1')      
	  '         s = 2 + kron(ones(1,8),[1 -1]) + ...' 
	  '             ((1:16).^2)/32 + 0.2*randn(1,16);'
	  ''};
  
  %========== Slide 3 ==========
  idx = idx+1;
  slide(idx).code = {
	  '[Lo_D,Hi_D] = wfilters(''db1'',''d'');'
	  'x_fil = 1:length(Lo_D);'
	  'stemCOL = ''b'';'
	  'h(3) = subplot(3,2,3); wdstem(h(3),x_fil,Lo_D,stemCOL);'
	  'xlabel(''Lo_D'');'
	  'h(4) = subplot(3,2,4); wdstem(h(4),x_fil,Hi_D,stemCOL);'
	  'xlabel(''Hi_D'');'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_2')};

  slide(idx).info = 'wfilters';

  %========== Slide 4 ==========
  idx = idx+1;
  slide(idx).code = {
	  'sm = sum(Lo_D);'
	  'h(3) = subplot(3,2,3);' 
      'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:Lo_D_sum'',num2str(sm)));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_3')};

  %========== Slide 5 ==========
  idx = idx+1;
  slide(idx).code = {
	  'nrm = norm(Lo_D);'
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '   h(3) = subplot(3,2,3); wdstem(h(3),x_fil,Lo_D,stemCOL);'
	  '   h(4) = subplot(3,2,4); wdstem(h(4),x_fil,Hi_D,stemCOL);'
	  '   xlabel(''Hi_D'');'
	  'end'
	  'h(3) = subplot(3,2,3);' 
      'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:Lo_D_norm'',num2str(nrm)));'
	  '' };
 
  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_4')};

  %========== Slide 6 ==========
  idx = idx+1;
  slide(idx).code = {
	  'tempo = conv(s,Lo_D);'
	  'set(subplot(3,1,1),''XTickLabel'',[]);'
	  'h(2) = subplot(3,1,2); plot(tempo);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:s_Lo_D_conv''));'
	  'set(h(2),''XLim'',[1 length(tempo)]);'
	  'delete(subplot(3,2,5));'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_5')};

  %========== Slide 7 ==========
  idx = idx+1;
  slide(idx).code = {
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '   h(2) = subplot(3,1,2); plot(tempo);'
	  '   title(getWavMSG(''Wavelet:wavedemoMSGRF:s_Lo_D_conv''));'
	  '   set(h(2),''XLim'',[1 length(tempo)]);'
	  'end'
	  'ca1 = dyaddown(tempo);'
	  'h(5) = subplot(3,2,5); plot(ca1);'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:AppCfs_ca1''));'
	  'set(h(5),''XLim'',[1 length(ca1)]);'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_6')};

  slide(idx).info = 'dyaddown';

  %========== Slide 8 ==========
  idx = idx+1;
  slide(idx).code = {
	  'h(3) = subplot(3,2,3); wdstem(h(3),x_fil,Lo_D,stemCOL);'
	  'h(4) = subplot(3,2,4); wdstem(h(4),x_fil,Hi_D,stemCOL);'
	  'xlabel(''Hi_D'');'
	  ''};

  slide(idx).text = {''};

  %========== Slide 9 ==========
  idx = idx+1;
  slide(idx).code = {
	  'sm = sum(Hi_D);'
	  'h(4) = subplot(3,2,4);'
      'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:Hi_D_sum'',num2str(sm)));'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_7')};

  %========== Slide 10 ==========
  idx = idx+1;
  slide(idx).code = {
	  'nrm = norm(Hi_D);'
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '   h(3) = subplot(3,2,3); wdstem(h(3),x_fil,Lo_D,stemCOL);'
	  '   h(4) = subplot(3,2,4); wdstem(h(4),x_fil,Hi_D,stemCOL);'
	  'end'
	  'h(4) = subplot(3,2,4);'
      'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:Hi_D_norm'',num2str(nrm)));'
	  ''};
  
  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_8')};

  %========== Slide 11 ==========
  idx = idx+1;
  slide(idx).code = {
	  'tempo = conv(s,Hi_D);'
	  'h(2) = subplot(3,1,2); plot(tempo);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:s_Hi_D_conv''));'
	  'set(h(2),''XLim'',[1 length(tempo)]);'
	  'delete(subplot(3,2,6));'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_9')};

  %========== Slide 12 ==========
  idx = idx+1;
  slide(idx).code = {
	  'cd1 = dyaddown(tempo);'
	  
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '   h(5) = subplot(3,2,5); plot(ca1);'
	  '   xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:AppCfs_ca1''));'
	  '   set(h(5),''XLim'',[1 length(ca1)]);'
	  'end'
	  'h(6) = subplot(3,2,6); plot(cd1);'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:DetCfs_cd1''));'
	  'set(h(6),''XLim'',[1 length(cd1)]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_10')};
  
  slide(idx).info = 'dyaddown';

  %========== Slide 13 ==========
  idx = idx+1;
  slide(idx).code = {
	  '[ca1,cd1] = dwt(s,''db1'');'
	  
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '   h(1) = subplot(3,1,1); plot(s,''r'');'
	  '   title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	  '   set(h(1),''XLim'',[1 16],''XTick'',[])'
	  '   tempo = conv(s,Hi_D);'
	  '   h(2) = subplot(3,1,2); plot(tempo);'
	  '   title(getWavMSG(''Wavelet:wavedemoMSGRF:s_Hi_D_conv''));'
	  '   set(h(2),''XLim'',[1 length(tempo)]);'
	  'end'
	  
	  'h(5) = subplot(3,2,5); plot(ca1,''g'');'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:AppCfs_ca1''));'
	  'set(h(5),''XLim'',[1 length(ca1)]);'
	  'h(6) = subplot(3,2,6); plot(cd1,''g'');'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:DetCfs_cd1''));'
	  'set(h(6),''XLim'',[1 length(cd1)]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_11')};

  slide(idx).info = 'dwt';

  %========== Slide 14 ==========
  idx = idx+1;
  slide(idx).code = {
	  '[Lo_R,Hi_R] = wfilters(''db1'',''r'');'
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	  'h(3) = subplot(3,2,3); wdstem(h(3),x_fil,Lo_R,stemCOL);'
	  'xlabel(''Lo_R'');'
	  'h(4) = subplot(3,2,4); wdstem(h(4),x_fil,Hi_R,stemCOL);'
	  'xlabel(''Hi_R'');'
	  'h(1) = subplot(3,2,1); plot(ca1,''g'');'
	  'set(h(1),''XLim'',[1 length(ca1)]);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:AppCfs_ca1''));'
	  'h(2) = subplot(3,2,2); plot(cd1,''g'');'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:DetCfs_cd1''));'
	  'set(h(2),''XLim'',[1 length(cd1)]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_12')};

  slide(idx).info = 'wfilters';

  %========== Slide 15 ==========
  idx = idx+1;
  slide(idx).code = {
	  'tempo = dyadup(cd1);'
	  'subplot(3,2,3); xlabel('''');'
	  'subplot(3,2,4); xlabel('''');'
	  'h(3) = subplot(3,1,3); plot(tempo);'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:UpCfs_Cd1''));'
	  'set(h(3),''XLim'',[1 length(tempo)]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_13')};

  slide(idx).info = 'dyadup';

  %========== Slide 16 ==========
  idx = idx+1;
  slide(idx).code = {
	  'tempo = conv(tempo,Hi_R);'
	  'h(3) = subplot(3,1,3); plot(tempo);'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:UpDetCfs_HiRconv''));'
	  'set(h(3),''XLim'',[1 length(tempo)]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_14')};

  %========== Slide 17 ==========
  idx = idx+1;
  slide(idx).code = {
	  'd1 = wkeep(tempo,16);'
	  'h(3) = subplot(3,1,3); plot(d1);'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:RecDet_d1''));'
	  'set(h(3),''XLim'',[1 length(d1)]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_15')};

  slide(idx).info = 'wkeep';

  %========== Slide 18 ==========
  idx = idx+1;
  slide(idx).code = {
	  'tempo = dyadup(ca1);'
	  'h(3) = subplot(3,1,3); plot(tempo);'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:UpCfs_Ca1''));'
	  'set(h(3),''XLim'',[1 length(tempo)]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_16')};

  slide(idx).info = 'dyadup';

  %========== Slide 19 ==========
  idx = idx+1;
  slide(idx).code = {
	  'tempo = conv(tempo,Lo_R);'
	  'h(3) = subplot(3,1,3); plot(tempo);'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:UpAppCfs_LoRconv''));'
	  'set(h(3),''XLim'',[1 length(tempo)]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_17')};

  %========== Slide 20 ==========
  idx = idx+1;
  slide(idx).code = {
	  'a1 = wkeep(tempo,16);'
	  
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '   h(3) = subplot(3,2,3); wdstem(h(3),x_fil,Lo_R,stemCOL);'
	  '   h(4) = subplot(3,2,4); wdstem(h(4),x_fil,Hi_R,stemCOL);'
	  '   h(1) = subplot(3,2,1); plot(ca1,''g'');'
	  '   set(h(1),''XLim'',[1 length(ca1)]);'
	  '   title(getWavMSG(''Wavelet:wavedemoMSGRF:AppCfs_ca1''));'
	  '   h(2) = subplot(3,2,2); plot(cd1,''g'');'
	  '   title(getWavMSG(''Wavelet:wavedemoMSGRF:DetCfs_cd1''));'
	  '   set(h(2),''XLim'',[1 length(cd1)]);'
	  'end'
	  
	  'h(3) = subplot(3,1,3); plot(a1);'
	  'xlabel(getWavMSG(''Wavelet:wavedemoMSGRF:RecApp_d1''));'
	  'set(h(3),''XLim'',[1 length(a1)]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_18')};

  slide(idx).info = 'wkeep';

  %========== Slide 21 ==========
  idx = idx+1;
  slide(idx).code = {
	  'a0 = a1 + d1;'
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	  'h(1) = subplot(3,1,1); plot(s,''r'');'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	  'set(h(1),''XLim'',[1 16]);'
	  'pause(1)'
	  'set(h(1),''XTickLabel'',[]);'
	  'h(2) = subplot(3,1,2); plot(1:16,a1,1:16,d1);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:a1_d1''));'
	  'set(h(2),''XLim'',[1 16]);'
	  'pause(1)'
	  'set(h(2),''XTickLabel'',[]);'
	  'h(3) = subplot(3,1,3); plot(a0);'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:RecSig_a0_EQ_a1plusd1''));'
	  'set(h(3),''XLim'',[1 16]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_19')};
  
  %========== Slide 22 ==========
  idx = idx+1;
  slide(idx).code = {
	  'a0 = idwt(ca1,cd1,''db1'',16);'
	  'h(3) = subplot(3,1,3); plot(a0,''g'');'
	  'title(getWavMSG(''Wavelet:wavedemoMSGRF:RecSig_a0''));'
	  'set(h(3),''XLim'',[1 16]);'
	  ''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdmala_MSG_20')};

  slide(idx).info = 'idwt';

  varargout{1} = slide;
end
