function varargout = dcmddw1d(varargin)
%DCMDDW1D Shows discrete 1-D wavelet tools in the Wavelet Toolbox.
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dcmddw1d' 
%
% See also APPCOEF, DETCOEF, DWT, IDWT, UPCOEF,
%          WAVEDEC, WAVEREC, WRCOEF. 

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
		wfighelp('addHelpItem',hdlFig,'Wavelet Decomposition','DW1D_DECOMPOS');
          
	  case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');
	  case 'getFigParam'
		figName  = getWavMSG('Wavelet:wavedemoMSGRF:Orthogonal_1D');
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
	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'		  	
	'' };

  slide(idx).text = {
	''
    getWavMSG('Wavelet:wavedemoMSGRF:Press_StartBtn','1-D wavelet')
	''
	getWavMSG('Wavelet:wavedemoMSGRF:This_EX_Uses')
	''};
	
  %========== Slide 2 ==========
  idx = idx+1;
  slide(idx).code = {
	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	'load leleccum; s = leleccum(1:3920);'
	'ls = length(s);'
	'clear leleccum'
	'h(1) = subplot(2,1,1); plot(1:ls,s,''r'')'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	'set(h(1),''XLim'',[1,ls]);'
	'' };

  slide(idx).text = {
	getWavMSG('Wavelet:wavedemoMSGRF:Load_Ori1DSig')
	'        load leleccum; s = leleccum(1:3920);'
	'        ls = length(s);'
	''};

  %========== Slide 3 ==========
  idx = idx+1;
  slide(idx).code = {
	'[ca1,cd1] = dwt(s,''db1'');'

	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; h = [];'		  	
	'h(1) = subplot(2,1,1); plot(1:ls,s,''r'')'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	'set(h(1),''XLim'',[1,ls]);'

	'h(3) = subplot(2,2,3); plot(1:length(ca1),ca1);'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:AppCfs_ca1''));'
	'set(h(3),''XLim'',[1,length(ca1)]);'  
	'h(4) = subplot(2,2,4); plot(1:length(cd1),cd1);'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:DetCfs_cd1''));'
	'set(h(4),''XLim'',[1,length(cd1)]);'   
	'' };

  slide(idx).text = {
	getWavMSG('Wavelet:wavedemoMSGRF:PerformDEC_db1')
 	'        [ca1,cd1] = dwt(s,''db1'');'
	''};

  slide(idx).info = 'dwt';

  %========== Slide 4 ==========
  idx = idx+1;
  slide(idx).code = {
	'a1 = upcoef(''a'',ca1,''db1'',1,ls);'
    'd1 = upcoef(''d'',cd1,''db1'',1,ls);'

	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	'h(1) = subplot(3,1,1); plot(1:ls,s,''r'');'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	'h(2) = subplot(3,1,2); plot(1:ls,a1);'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:Approx_a1''));'
	'h(3) = subplot(3,1,3); plot(1:ls,d1);'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:Detail_d1''));'
	'set(h(1:2),''XTick'',[],''XTickLabel'',[]);' 
	'set(h,''XLim'',[1,ls]);' 	
	''};

  slide(idx).text = {
	getWavMSG('Wavelet:wavedemoMSGRF:PerformREC_ca1cd1')
	'        a1 = upcoef(''a'',ca1,''db1'',1,ls);'
	'        d1 = upcoef(''d'',cd1,''db1'',1,ls);'
	''};

  slide(idx).info = 'upcoef';

  %========== Slide 5 ==========
  idx = idx+1;
  slide(idx).code = {
	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	'h(1) = subplot(3,1,1); plot(1:ls,s,''r'');'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	'h(2) = subplot(3,1,2); plot(1:ls,a1+d1);'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:AppDet_a1_plus_d1''));'
	'set(h(1),''XTick'',[],''XTickLabel'',[]);'
	'set(h,''XLim'',[1,ls]);' 		
	''};

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:Plot_a1_plus_d1'),''};

  slide(idx).info = 'upcoef';

  %========== Slide 6 ==========
  idx = idx+1;
  slide(idx).code = {
	'a0 = idwt(ca1,cd1,''db1'',ls);'
	  
	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	'h(1) = subplot(3,1,1); plot(1:ls,s,''r'');'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	'h(2) = subplot(3,1,2); plot(1:ls,a1+d1);'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:AppDet_a1_plus_d1''));'
	'set(h(1:2),''XTick'',[],''XTickLabel'',[]);'
	  
	'h(3) = subplot(3,1,3); plot(1:ls,a0);'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:RecSig_a0''));'
	'set(h,''XLim'',[1,ls]);' 			
	''};

  slide(idx).text = {
	getWavMSG('Wavelet:wavedemoMSGRF:InvertDec_s')
	'        a0 = idwt(ca1,cd1,''db1'',ls);'
	''};

  slide(idx).info = 'idwt';

  %========== Slide 7 ==========
  idx = idx+1;
  slide(idx).code = {
	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	'[c,l] = wavedec(s,3,''db1'');'
	'h(1) = subplot(5,1,1); plot(1:ls,s,''r'');'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	'set(h,''XLim'',[1,ls]);' 				
	''};

  slide(idx).text = {
	getWavMSG('Wavelet:wavedemoMSGRF:DecLev3_db1')
	'        [c,l] = wavedec(s,3,''db1'');'
	''};

  slide(idx).info = 'wavedec';

  %========== Slide 8 ==========
  idx = idx+1;
  slide(idx).code = {
	'ca3 = appcoef(c,l,''db1'',3);'		  	  

	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	'h(1) = subplot(5,1,1); plot(1:ls,s,''r'');'
	'set(h(1),''XTick'',[],''XTickLabel'',[],''XLim'',[1,ls]);' 	
	'h(2) = subplot(5,8,9); plot(1:length(ca3),ca3);'
	'subplot(5,1,1); title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s_ca3''));'
	''};

  slide(idx).text = {
    getWavMSG('Wavelet:wavedemoMSGRF:ExtAppCfsLev3_fromCL')      
	'        ca3 = appcoef(c,l,''db1'',3);'
	''};

  slide(idx).info = 'appcoef';

  %========== Slide 9 ==========
  idx = idx+1;
  slide(idx).code = {
	'cd3 = detcoef(c,l,3);'
	'cd2 = detcoef(c,l,2);'		  	  
	'cd1 = detcoef(c,l,1);'

	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	'h(1) = subplot(5,1,1); plot(1:ls,s,''r'');'
	'set(h(1),''XTick'',[],''XTickLabel'',[],''XLim'',[1,ls]);' 	
	'h(2) = subplot(5,8,9); plot(1:length(ca3),ca3);'

	'subplot(5,1,1); title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s_ca3d3''));'
	'set(h(2),''XTick'',[],''XTickLabel'',[]);' 	
	'h(3) = subplot(5,8,17); plot(1:length(cd3),cd3);'
	'pause(1)'
	'subplot(5,1,1); title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s_ca3d3d2''));'
	'set(h(3),''XTick'',[],''XTickLabel'',[]);' 	
	'h(4) = subplot(5,4,13); plot(1:length(cd2),cd2);'
	'pause(1)'
	'subplot(5,1,1); title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s_ca3d3d2d1''));'
	'set(h(4),''XTick'',[],''XTickLabel'',[]);' 	
	'h(5) = subplot(5,2,9); plot(1:length(cd1),cd1);'		
	''};

  slide(idx).text = {
    getWavMSG('Wavelet:wavedemoMSGRF:ExtDetCfsLev123_fromCL')      
	'        cd3 = detcoef(c,l,3);'
	'        cd2 = detcoef(c,l,2);'
	'        cd1 = detcoef(c,l,1);'
	''};

  slide(idx).info = 'detcoef';

  %========== Slide 10 ==========
  idx = idx+1;
  slide(idx).code = {
	'a3 = wrcoef(''a'',c,l,''db1'',3);'

	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	'h(1) = subplot(5,1,1); plot(s,''r'');'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:s_and_a3''));'
	'h(2) = subplot(5,1,2); plot(1:ls,a3);'
	'set(h(1),''XTick'',[],''XTickLabel'',[]);'
	'set(h,''XLim'',[1,ls]);'		
	''};

  slide(idx).text = {
    getWavMSG('Wavelet:wavedemoMSGRF:RecAppLev3_fromCL')      
	'        a3 = wrcoef(''a'',c,l,''db1'',3);'
	''};

  slide(idx).info = 'wrcoef';

  %========== Slide 11 ==========
  idx = idx+1;
  slide(idx).code = {
	'd3 = wrcoef(''d'',c,l,''db1'',3);'
	'd2 = wrcoef(''d'',c,l,''db1'',2);'
	'd1 = wrcoef(''d'',c,l,''db1'',1);'
	
	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	'h(1) = subplot(5,1,1); plot(s,''r'');'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:s_and_a3d3d2d1''));'
	'h(2) = subplot(5,1,2); plot(1:ls,a3);'
	
	'h(3) = subplot(5,1,3); plot(1:ls,d3);'
	'h(4) = subplot(5,1,4); plot(1:ls,d2);'
	'h(5) = subplot(5,1,5); plot(1:ls,d1);'
	'set(h(1:4),''XTick'',[],''XTickLabel'',[]);'
	'set(h,''XLim'',[1,ls]);'	
	''};

  slide(idx).text = {
    getWavMSG('Wavelet:wavedemoMSGRF:RecDetLev123_fromCL')      
	'        d3 = wrcoef(''d'',c,l,''db1'',3);'
	'        d2 = wrcoef(''d'',c,l,''db1'',2);'
	'        d1 = wrcoef(''d'',c,l,''db1'',1);'  
	''};

  slide(idx).info = 'wrcoef';

  %========== Slide 12 ==========
  idx = idx+1;
  slide(idx).code = {
	'a0 = waverec(c,l,''db1'');'
	'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;  h = [];'		  	
	'h(1) = subplot(2,1,1); plot(s,''r'');'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_s''));'
	'h(2) = subplot(2,1,2); plot(1:ls,a0);'
	'title(getWavMSG(''Wavelet:wavedemoMSGRF:RecSig_a0''));'
	'set(h,''XLim'',[1,ls]);'		
	''};

  slide(idx).text = {
    getWavMSG('Wavelet:wavedemoMSGRF:RecSignal_fromCL')      
	'        a0 = waverec(c,l,''db1'');'
	''};

  slide(idx).info = 'waverec';

  varargout{1} = slide;
end
