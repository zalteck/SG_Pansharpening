function varargout = dguiwmul(varargin)
%DGUIWMUL Shows Multivariate denoising tool in the Wavelet Toolbox.
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dguiwmul', 

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 11-Apr-2006.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2012/06/13 09:32:15 $

% Initialization and Local functions if necessary.
if nargin>0
	action = varargin{1};
	switch action
	  case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

	  case 'getFigParam'
		  figName  = getWavMSG('Wavelet:wavedemoMSGRF:DGUI_WMSUL');
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
			  active_fig = wmuldentool;
			  wenamngr('Inactive',active_fig);
			  localPARAM = {active_fig};
			  wtbxappdata('set',figHandle,'localPARAM',localPARAM);
			  wshowdrv('#modify_cbClose_NEW',figHandle,active_fig,'wfustool');
		  else
			  active_fig = deal(localPARAM{:});
		  end
		  numDEM = idxSlide-1;
          nbDEM = 20;
		  if ismember(numDEM,(1:nbDEM))
              wmuldentool('demoPROC',active_fig,[],[],numDEM);
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
  
  %========== Slide 2 to 21 ==========
  for idx = 2:21
	  slide(idx).code = {
		  [mfilename ,'(''slidePROC'',figHandle,', int2str(idx), ');']
	  };
  end
  
  varargout{1} = slide;
  
end

