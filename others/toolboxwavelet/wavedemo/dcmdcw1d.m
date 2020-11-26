function varargout = dcmdcw1d(varargin)
%DCMDCW1D Shows continuous 1-D wavelet tools in the Wavelet Toolbox.
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dcmdcw1d' 
%
% See also DETCOEF, CWT, WAVEDEC, WCODEMAT. 

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.14.4.6 $

% Initialization and Local functions if necessary.
if nargin>0
	action = varargin{1};
	switch action
      case 'addHelp'
		% Add Help Item.
		%---------------
        hdlFig = varargin{2};
		wfighelp('addHelpItem',hdlFig,'Continuous Transform','CW_TRANSFORM');
		wfighelp('addHelpItem',hdlFig,'Continuous Versus Discrete (1)','CW_CONTDISC1');	
		wfighelp('addHelpItem',hdlFig,'Continuous Versus Discrete (2)','CW_CONTDISC2');
        
	  case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

	  case 'getFigParam'
		figName  = getWavMSG('Wavelet:wavedemoMSGRF:Continuous_1D');
		showType = 'mix6';
		varargout = {figName,showType};

	  case 'localPROC_1'
		[x,sigCOL] = deal(varargin{2:end}); 
	    ax = subplot(3,1,1);
	    plot(x,sigCOL); title(getWavMSG('Wavelet:commongui:Str_AnalSig'));
	    set(ax,'XLim',[0 length(x)])
	  
	  case 'localPROC_2'
		[x,lev,wname,nbcol] = deal(varargin{2:end});
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
		cfd = wcodemat(cfd,nbcol,'row');
		colormap(pink(nbcol));
		ax  = subplot(3,1,2); image(cfd);
		tics = 1:lev; labs = int2str((1:lev)');
		set(ax,...
			'YTickLabelMode','manual','YDir','normal', ...
			'Box','On','YTick',tics,'YTickLabel',labs ...
			);
		title(getWavMSG('Wavelet:wavedemoMSGRF:DWT_AbsCfs'));
		ylabel(getWavMSG('Wavelet:commongui:Str_Level'));

	  case 'localPROC_3'
		[x,scales,wname,map] = deal(varargin{2:end});
	    ax = subplot(3,1,3); axes(ax); %#ok<*MAXES>
	    cwt(x,scales,wname,'plot');
	    colormap(map);
	    tt = get(ax,'YTickLabel');
	    [r,c] = size(tt);
	    yl = char(32*ones(r,c));
	    for k = 1:3:r , yl(k,:) = tt(k,:); end
	    set(ax,'YTickLabel',yl);	
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
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;'		  	
	  '' };

  slide(idx).text = {
	  ''
      getWavMSG('Wavelet:wavedemoMSGRF:Press_StartBtn','continuous wavelet')
	  ''
	  getWavMSG('Wavelet:wavedemoMSGRF:This_EX_Uses')
	  ''};

  %========== Slide 2 ==========
  idx = idx+1;
  slide(idx).code = {
	  'lev = 5; wname = ''sym2''; nbcol = 64;'	  
	  'load vonkoch; lv = 510; vonkoch = vonkoch(1:lv);'
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV<idxSlide'
	  [   mfilename ,'(''localPROC_1'',vonkoch,''r'');']
	  '   xtick = get(subplot(3,1,1),''XTick'');'
	  '   xtickLab = get(subplot(3,1,1),''XTickLabel'');'
	  'end'
	  '' };

  slide(idx).text = {
	  getWavMSG('Wavelet:wavedemoMSGRF:Load_OriFractSig')
	  '        load vonkoch; lv = 510;'
	  '        vonkoch = vonkoch(1:lv);'
	  ''};

  %========== Slide 3 ==========
  idx = idx+1;
  slide(idx).code = {
	  '' };

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdcw1d_MSG_1')      
	  '        [c,l] = wavedec(vonkoch,5,''sym2'');'
	  ''};

  slide(idx).info = 'wavedec';

  %========== Slide 4 ==========
  idx = idx+1;
  slide(idx).code = {
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '   delete(subplot(3,1,2));'
	  '   set(subplot(3,1,1),''XTick'',xtick,''XTickLabel'',xtickLab);'
	  'end'
	  '' };

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdcw1d_MSG_2')      
	  ''};

  slide(idx).info = 'detcoef';

  %========== Slide 5 ==========
  idx = idx+1;
  slide(idx).code = {
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '    delete(subplot(3,1,3));'
	  '    set(subplot(3,1,2),''XTick'',xtick,''XTickLabel'',xtickLab);'
	  'else'
	  '    set(subplot(3,1,1),''XTick'',[]);'
	  [    mfilename ,'(''localPROC_2'',vonkoch,lev,wname,nbcol);']
	  'end'
	  '' };

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdcw1d_MSG_3')      
	  '        colormap(pink(64));'
	  '        img = image(wcodemat(cfs_Exp,64,''row''));' 	
	  ''};

  slide(idx).info = 'wcodemat';

  %========== Slide 6 ==========
  idx = idx+1;
  slide(idx).code = {
	  'lev = 5; wname = ''sym2''; nbcol = 64; scales = [1:32];'
	  'signal = vonkoch; map = pink(nbcol);'
	  ['idxPREV = wshowdrv(''#get_idxSlide'',figHandle); idxSlide = ' int2str(idx) ';']
	  'if idxPREV>idxSlide'
	  '   ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;'
	      [mfilename ,'(''localPROC_1'',signal,''r'');']
	  '   set(subplot(3,1,1),''XTick'',[]);'
	  [   mfilename ,'(''localPROC_2'',signal,lev,wname,nbcol);']
	  'end'
	  'set(subplot(3,1,2),''XTick'',[]);'
	  [mfilename ,'(''localPROC_3'',signal,scales,wname,map);']
	  '' };

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdcw1d_MSG_4')      
	'        coefs = cwt(vonkoch,1:32,''sym2'',''plot'');'
	'        colormap(pink(64));'
	''};

  slide(idx).info = 'cwt';
  
  
  %========== Slide 7 ==========
  idx = idx+1;
  slide(idx).code = {
	  'lev = 5; wname = ''db1''; nbcol = 64; scales = [1:32];'
	  'load freqbrk; signal = freqbrk; clear freqbrk;'
	  'map = cool(128);'
	  'ax = findall(figHandle,''Type'',''axes''); delete(ax); drawnow;'
	  [mfilename ,'(''localPROC_1'',signal,''r'');']
	  'set(subplot(3,1,1),''XTick'',[]);'
	  [mfilename ,'(''localPROC_2'',signal,lev,wname,nbcol);']
	  'set(subplot(3,1,2),''XTick'',[]);'
	  [mfilename ,'(''localPROC_3'',signal,scales,wname,map);']
	  '' };

  slide(idx).text = {
      getWavMSG('Wavelet:wavedemoMSGRF:dcmdcw1d_MSG_5')      
	  '        wname   = ''db1'';' 
	  '        scales  = [1:32];' 
	  '        load freqbrk' 
	  ''};
  
  slide(idx).info = 'cwt';

  varargout{1} = slide;
end
