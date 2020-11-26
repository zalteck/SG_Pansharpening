function varargout = dguimdw1d(varargin)
%DGUIMDW1D Shows Multisignal 1D Analysis tool in the Wavelet Toolbox.
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dguiwmspca', 

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 24-Sep-2006.
%   Last Revision: 12-Apr-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2012/05/04 00:20:12 $

% Initialization and Local functions if necessary.
if nargin>0
	action = varargin{1};
	switch action
	  case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

	  case 'getFigParam'
		  figName  = 'Wavelet GUI Example: Multisignal Analysis';
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
			  active_fig = mdw1dtool;
			  wenamngr('Inactive',active_fig);
			  localPARAM = {active_fig};
			  wtbxappdata('set',figHandle,'localPARAM',localPARAM);
			  wshowdrv('#modify_cbClose_NEW',figHandle,active_fig,'wfustool');
		  else
			  active_fig = deal(localPARAM{:});
		  end
		  numDEM = idxSlide-1;
          nbDEM = 21;
		  if ismember(numDEM,(1:nbDEM))
              mdw1dtool('demoPROC',active_fig,[],[],numDEM);
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
  
  %========== Slide 2 to 22 ==========
  for idx = 2:22
	  slide(idx).code = {
		  [mfilename ,'(''slidePROC'',figHandle,', int2str(idx), ');']
	  };
  end
  
  varargout{1} = slide;
  
end

