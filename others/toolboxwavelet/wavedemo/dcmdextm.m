function varargout = dcmdextm(varargin)
%DCMDEXTM Shows border distortions tools in the Wavelet Toolbox. 
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dcmdextm' 
%
% See also DWTMODE, WAVEDEC, WAVEDEC2, WRCOEF2. 

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.14.4.6 $  $Date: 2012/06/13 09:31:54 $

% Initialization and Local functions if necessary.
if nargin>0
	action = varargin{1};
	switch action
      case 'addHelp'
		% Add Help Item.
		%---------------
        hdlFig = varargin{2};
		wfighelp('addHelpItem',hdlFig, ...
            getWavMSG('Wavelet:wavedemoMSGRF:Str_extm'),'BORDER_DIST');
        
	  case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

	  case 'getFigParam'
		figName  = getWavMSG('Wavelet:wavedemoMSGRF:Str_extm');
		showType = 'mix6';
		varargout = {figName,showType};
		
	  case 'localPROC_1'
		[figHandle,modeDWT,axeHDL,strTIT] = deal(varargin{2:end});
		dataSTRUCT = wtbxappdata('get',figHandle,'dataSTRUCT');
		[x,lev,wname,nbcol] = deal(dataSTRUCT{:});
		dwtmode(modeDWT,'silent');
		[c,l] = wavedec(x,lev,wname);
		len = length(x);
		cfd = zeros(lev,len);
		for k = 1:lev
			d = detcoef(c,l,k);
			d = d(:)';
			d = d(ones(1,2^k),:);
			cfd(k,:) = wkeep1(d(:)',len);
		end
		cfd =  cfd(:);
		I = find(abs(cfd)<sqrt(eps));
		cfd(I) = zeros(size(I));
		cfd    = reshape(cfd,lev,len);
		imgCFS = wcodemat(cfd,nbcol);
		tics = 1:lev; labs = int2str((1:lev)');
		axes(axeHDL); image(imgCFS); %#ok<*MAXES>
		set(axeHDL,'YTickLabelMode','manual','YTick',tics, ...
			'YTickLabel',labs,'YDir','normal','Box','On');
		ylabel(getWavMSG('Wavelet:commongui:Str_level'));
		title(strTIT);
		colormap(pink(nbcol));
		
	  case 'localPROC_2'
		[figHandle,modeDWT,axeHDL,strTIT] = deal(varargin{2:end});
		dataSTRUCT = wtbxappdata('get',figHandle,'dataSTRUCT');
		[X,lev,wname,nbcol] = deal(dataSTRUCT{:});
		dwtmode(modeDWT,'silent');
		[c,s] = wavedec2(X,lev,wname);
	    a = wrcoef2('a',c,s,wname,lev);
		imgCFS = wcodemat(a,nbcol);
		axes(axeHDL); image(imgCFS);
		set(axeHDL,'XTick',[],'YTick',[]);
		title(strTIT);

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
	  'try'
	  '   wtbxappdata(''del'',figHandle,''local_AXES'');'
	  '   wtbxappdata(''del'',figHandle,''dataSTRUCT'');'
	  'end'
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow; '		  	
	  '' };

  slide(idx).text = {
	  ''
      getWavMSG('Wavelet:wavedemoMSGRF:Press_StartBtn_Extm')
	  ''
	  getWavMSG('Wavelet:wavedemoMSGRF:This_EX_Uses')
	  ''};
  
  %========== Slide 2 ==========
  idx = idx+1;
  slide(idx).code = {
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV<idxSlide'
	  '   wshowdrv(''#set_axes'',figHandle,[4,1]);'
	  '   h = wshowdrv(''#get_axes'',figHandle);'
	  '   load nearbrk; signal = nearbrk; clear nearbrk'
	  '   lev = 5; wname = ''db2''; nbcol = 128;'
	  '   dataSTRUCT = {signal,lev,wname,nbcol};'
	  '   colormap(pink(nbcol));'
	  '   axes(h(1)); plot(signal,''r'');'
	  '   title(getWavMSG(''Wavelet:wavedemoMSGRF:OriSig_scddvbrk''));'
	  '   wtbxappdata(''set'',figHandle,''local_AXES'',h);'
	  '   wtbxappdata(''set'',figHandle,''dataSTRUCT'',dataSTRUCT);'
	  'else '
	  '   h = wtbxappdata(''get'',figHandle,''local_AXES'');'
	  'end'
	  'set(findobj(h(2:4)),''Visible'',''Off'');'
	  'set(findobj(h(1)),''Visible'',''On'');'
	  '' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdextm_MSG_1')};

  %========== Slide 3 ==========
  idx = idx+1;
  slide(idx).code = {
	['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	'if idxPREV>idxSlide'
	'   set(findobj(h(2:4)),''Visible'',''Off'');'
	'   set(findobj(h(1)),''Visible'',''On'');'
	'end'
	'' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdextm_MSG_2')};

  slide(idx).info = 'dwtmode';

  %========== Slide 4 ==========
  idx = idx+1;
  slide(idx).code = {
	['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	'if idxPREV<idxSlide'
	'   modeDWT = ''zpd'';'
	'   strTIT = getWavMSG(''Wavelet:wavedemoMSGRF:Cfs_ZPD'');'
	[   mfilename ,'(''localPROC_1'',figHandle,modeDWT,h(2),strTIT);']
	'end'
	'set(findobj(h(3:4)),''Visible'',''Off'');'
	'set(findobj(h(1:2)),''Visible'',''On'');'	
	'' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdextm_MSG_3')};
 
  slide(idx).info = 'wavedec';

  %========== Slide 5 ==========
  idx = idx+1;
  slide(idx).code = {
	['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	'if idxPREV<idxSlide'
	'   modeDWT = ''sym'';'
	'   strTIT = getWavMSG(''Wavelet:wavedemoMSGRF:Cfs_SYM'');'
	[   mfilename ,'(''localPROC_1'',figHandle,modeDWT,h(3),strTIT);']
	'end'
	'set(findobj(h(4)),''Visible'',''Off'');'
	'set(findobj(h(1:3)),''Visible'',''On'');'	
	'' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdextm_MSG_4')};
 
  slide(idx).info = 'wavedec';

  %========== Slide 6 ==========
  idx = idx+1;
  slide(idx).code = {
	['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	'if idxPREV<idxSlide'
	'   modeDWT = ''spd'';'
	'   strTIT = getWavMSG(''Wavelet:wavedemoMSGRF:Cfs_SPD'');'
	[   mfilename ,'(''localPROC_1'',figHandle,modeDWT,h(4),strTIT);']
	'else'
	'	dataSTRUCT = wtbxappdata(''get'',figHandle,''dataSTRUCT'');'
	'   nbcol = dataSTRUCT{4};'
	'   colormap(pink(nbcol));'
	'end'
	'set(findobj(h(1:4)),''Visible'',''On'');'	
	'' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdextm_MSG_5')};
 
  slide(idx).info = 'wavedec';

  %========== Slide 7 ==========
  idx = idx+1;
  slide(idx).code = {
	['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	'colormap(cool(2))'	  
	'' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdextm_MSG_6')};
 
  slide(idx).info = 'dwtmode';

  %========== Slide 8 ==========
  idx = idx+1;
  slide(idx).code = {
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV<idxSlide'
	  '   wshowdrv(''#set_axes'',figHandle,[2,2]);'
	  '   h = wshowdrv(''#get_axes'',figHandle);'
	  '   load geometry; [row,col] = size(X);'
	  '   lev = 3; wname = ''sym4''; nbcol = size(map,1);'
	  '   dataSTRUCT = {X,lev,wname,nbcol};'
	  '   colormap(pink(nbcol));'
	  '   axes(h(1)); image(wcodemat(X,nbcol));'
	  '   title(getWavMSG(''Wavelet:wavedemoMSGRF:OriImg_X''));'
	  '   wtbxappdata(''set'',figHandle,''local_AXES'',h);'
	  '   wtbxappdata(''set'',figHandle,''dataSTRUCT'',dataSTRUCT);'
	  'else'
	  '   h = wtbxappdata(''get'',figHandle,''local_AXES'');'
	  'end'
	  'set(findobj(h(2:4)),''Visible'',''Off'');'
	  'set(findobj(h(1)),''Visible'',''On'');'	
	'' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdextm_MSG_7')};
 
  slide(idx).info = 'dwtmode';

  slide(idx).idxPrev = 1; 

  %========== Slide 9 ==========
  idx = idx+1;
  slide(idx).code = {
	['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	'if idxPREV<idxSlide'
	'   modeDWT = ''zpd'';'
	'   strTIT = getWavMSG(''Wavelet:wavedemoMSGRF:App3_ZPD'');'
	[   mfilename ,'(''localPROC_2'',figHandle,modeDWT,h(2),strTIT);']
	'end'
	'set(findobj(h(3:4)),''Visible'',''Off'');'
	'set(findobj(h(1:2)),''Visible'',''On'');'
	'' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdextm_MSG_8')};
 
  slide(idx).info = 'wavedec2';

  %========== Slide 10 ==========
  idx = idx+1;
  slide(idx).code = {
	['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	'if idxPREV<idxSlide'
	'   modeDWT = ''sym'';'
	'   strTIT = getWavMSG(''Wavelet:wavedemoMSGRF:App3_SYM'');'
	[   mfilename ,'(''localPROC_2'',figHandle,modeDWT,h(3),strTIT);']
	'end'
	'set(findobj(h(4)),''Visible'',''Off'');'
	'set(findobj(h(1:3)),''Visible'',''On'');'
	'' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdextm_MSG_9')};
 
  slide(idx).info = 'wrcoef2';

  %========== Slide 11 ==========
  idx = idx+1;
  slide(idx).code = {
	['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	'if idxPREV<idxSlide'
	'   modeDWT = ''spd'';'
	'   strTIT = getWavMSG(''Wavelet:wavedemoMSGRF:App3_SPD'');'
	[   mfilename ,'(''localPROC_2'',figHandle,modeDWT,h(4),strTIT);']
	'end'
	'set(findobj(h(1:4)),''Visible'',''On'');'
	'' };

  slide(idx).text = {getWavMSG('Wavelet:wavedemoMSGRF:dcmdextm_MSG_10')};
 
  slide(idx).info = 'wrcoef2';

  varargout{1} = slide;
end
