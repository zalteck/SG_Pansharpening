function varargout = dguidw2d(varargin)
%DGUIDW2D Shows discrete 2-D wavelet GUI tools in the Wavelet Toolbox.
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dguidw2d', 
%   
%   See also DWT2, IDWT2, WAVEDEC2, WAVEREC2.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
% $Revision: 1.13.4.5 $

% Initialization and Local functions if necessary.
if nargin>0
	action = varargin{1};
	switch action
	  case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

	  case 'getFigParam'
		figName  = getWavMSG('Wavelet:wavedemoMSGRF:DGUI_DW2D');
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
		idxPREV = wshowdrv('#get_idxSlide',figHandle);
	    localPARAM = wtbxappdata('get',figHandle,'localPARAM');
		if idxSlide==2
			if isempty(localPARAM)
				active_fig = dw2dtool;
				dw2dmngr('demo',active_fig,'woman2','sym4',2);
				wenamngr('Inactive',active_fig);
				tag_pop_declev  = 'Pop_DecLev';
				tag_pop_viewm   = 'Pop_ViewM';
				tag_pus_full    = char(...
					'Pus_Full.1','Pus_Full.2',...
					'Pus_Full.3','Pus_Full.4'...
					);
				pop_handles     = findobj(active_fig,'Style','popupmenu');
				pus_handles     = findobj(active_fig,'Style','pushbutton');
				pop_viewm       = findobj(pop_handles,'Tag',tag_pop_viewm);
				pop_decm        = findobj(pop_handles,'Tag',tag_pop_declev);
				pus_full        = findobj(pus_handles,'Tag',tag_pus_full(4,:));
				cba_viewm       = get(pop_viewm,'Callback');
				cba_decm        = get(pop_decm,'Callback');
				cba_full        = get(pus_full,'Callback');
				figTMP          = [];
				localPARAM = {active_fig,pop_viewm,cba_viewm,pop_decm,cba_decm,cba_full,figTMP};
				wtbxappdata('set',figHandle,'localPARAM',localPARAM);
				wshowdrv('#modify_cbClose',figHandle,active_fig,'dw2dtool');
			else
				[~,pop_viewm,cba_viewm,~,~,~,~] = deal(localPARAM{:});
				set(pop_viewm,'Value',1);
				eval(cba_viewm);
			end
			return
		end
			
		[active_fig,pop_viewm,cba_viewm,pop_decm,cba_decm,cba_full,figTMP] = deal(localPARAM{:});
		switch idxSlide
		  case 3
              msg = getWavMSG('Wavelet:wavedemoMSGRF:dguidw2d_MSG_1');
			  wshowdrv('#gui_wait',figHandle,active_fig,msg); 
			  msg = getWavMSG('Wavelet:wavedemoMSGRF:dguidw2d_MSG_2');
			  wshowdrv('#gui_wait',figHandle,active_fig,msg); 
			  set(pop_viewm,'Value',2);
			  eval(cba_viewm);

		  case 4
			  if idxPREV<idxSlide
			      msg = getWavMSG('Wavelet:wavedemoMSGRF:dguidw2d_MSG_3');
				  wshowdrv('#gui_wait',figHandle,active_fig,msg); 
				  set(pop_viewm,'Value',1);
				  eval(cba_viewm);
			  else
				  eval(cba_full);
			  end

		  case 5
			  if idxPREV<idxSlide
			      msg = getWavMSG('Wavelet:wavedemoMSGRF:dguidw2d_MSG_4');
				  wshowdrv('#gui_wait',figHandle,active_fig,msg); 
				  eval(cba_full);
			  else
				  set(pop_decm,'Value',2);
				  eval(cba_decm);
			  end
			  
		  case 6
			  if idxPREV<idxSlide
			      msg = getWavMSG('Wavelet:wavedemoMSGRF:dguidw2d_MSG_5');
				  wshowdrv('#gui_wait',figHandle,active_fig,msg); 
				  set(pop_decm,'Value',1);
				  eval(cba_decm);
			  else
				  eval(cba_full);
			  end
			  
		  case 7
			  if idxPREV<idxSlide
			      msg = getWavMSG('Wavelet:wavedemoMSGRF:dguidw2d_MSG_6');
				  wshowdrv('#gui_wait',figHandle,active_fig,msg); 
				  eval(cba_full);
			  else
				  set(pop_decm,'Value',1);
				  eval(cba_decm);
			  end
			  
		  case 8
			  if idxPREV<idxSlide
			      msg = getWavMSG('Wavelet:wavedemoMSGRF:dguidw2d_MSG_7');
				  wshowdrv('#gui_wait',figHandle,active_fig,msg); 
				  set(pop_decm,'Value',2);
				  eval(cba_decm);
			  else
				  delete(figTMP);  modify_localPARAM(figHandle,localPARAM,[]);
			  end

		  case 9
			  if idxPREV<idxSlide
			      msg = getWavMSG('Wavelet:wavedemoMSGRF:dguicomp_MSG_1');
				  wshowdrv('#gui_wait',figHandle,active_fig,msg); 
				  figTMP = dw2dmngr('comp',active_fig);
				  modify_localPARAM(figHandle,localPARAM,figTMP);
				  wenamngr('Inactive',figTMP);
			      msg = getWavMSG('Wavelet:wavedemoMSGRF:dguicomp_MSG_3');
				  wshowdrv('#gui_wait',figHandle,figTMP,msg); 
				  dw2dcomp('compress',figTMP,active_fig);
			  else
				  delete(figTMP);  modify_localPARAM(figHandle,localPARAM,[]);
			  end
			  
		  case 10
			  delete(figTMP);  modify_localPARAM(figHandle,localPARAM,[]);
			  pause(2)
			  dw2dmngr('return_comp',active_fig,0);
			  wenamngr('Inactive',active_fig);
			  msg = getWavMSG('Wavelet:wavedemoMSGRF:dguideno_MSG_1');
			  wshowdrv('#gui_wait',figHandle,active_fig,msg); 
			  figTMP = dw2dmngr('deno',active_fig);
			  modify_localPARAM(figHandle,localPARAM,figTMP);
			  wenamngr('Inactive',figTMP);
			  msg = getWavMSG('Wavelet:wavedemoMSGRF:dguideno_MSG_3');
			  wshowdrv('#gui_wait',figHandle,figTMP,msg); 
			  dw2ddeno('denoise',figTMP,active_fig);

		  case 11
			  delete(figTMP);  modify_localPARAM(figHandle,localPARAM,[]);
			  pause(2)
			  dw2dmngr('return_deno',active_fig,0);
			  wenamngr('Inactive',active_fig);
			  msg = getWavMSG('Wavelet:wavedemoMSGRF:dguistat_MSG');
			  wshowdrv('#gui_wait',figHandle,active_fig,msg); 
			  figTMP = dw2dmngr('stat',active_fig);
			  modify_localPARAM(figHandle,localPARAM,figTMP);
			  dw2dstat('demo',figTMP);
			  wenamngr('Inactive',figTMP);

		  case 12
			  delete(figTMP);  modify_localPARAM(figHandle,localPARAM,[]);
			  msg = getWavMSG('Wavelet:wavedemoMSGRF:dguihist_MSG');			 
              wshowdrv('#gui_wait',figHandle,active_fig,msg); 
			  figTMP = dw2dmngr('hist',active_fig);
			  modify_localPARAM(figHandle,localPARAM,figTMP);
			  dw2dhist('demo',figTMP);
			  wenamngr('Inactive',figTMP);

		  case 13
			  delete(figTMP); modify_localPARAM(figHandle,localPARAM,[]);
			  pause(2)
			  
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

  %========== Slide 2 to Slide 13 ==========
  for idx = 2:13
    slide(idx).code = {[mfilename ,'(''slidePROC'',figHandle,',int2str(idx),');']};
  end
  
  varargout{1} = slide;
  
end

%------------------------------------------------------------------------------------------%
function modify_localPARAM(figHandle,localPARAM,figTMP)

localPARAM{end} = figTMP;
wtbxappdata('set',figHandle,'localPARAM',localPARAM);	   
%------------------------------------------------------------------------------------------%
