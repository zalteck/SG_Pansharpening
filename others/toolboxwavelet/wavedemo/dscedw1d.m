function varargout = dscedw1d(varargin)
%DSCEDW1D Shows typical wavelet 1-D scenarios in the Wavelet Toolbox (Auto play). 
%
% This is a slideshow file for use with wshowdrv.m
% To see it run, type 'wshowdrv dscedw1d', 

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.13.4.6 $

% Initialization and Local functions if necessary.
if nargin>0
	action = varargin{1};
	switch action
	  case 'auto'    , wshowdrv('#autoMode',mfilename,'close');
	  case 'gr_auto' , wshowdrv('#gr_autoMode',mfilename,'close');

	  case 'getFigParam'
		figName  = getWavMSG('Wavelet:wavedemoMSGRF:DSCE_DW1D');
		showType = 'command';
		varargout = {figName,showType};
		
	  case 'slidePROC'
		  [figHandle,idxSlide]  = deal(varargin{2:end});
		  idxPREV = wshowdrv('#get_idxSlide',figHandle);
		  localPARAM = wtbxappdata('get',figHandle,'localPARAM');
		  switch idxSlide
		  	case 1
				if ~isempty(localPARAM)
					win_dw1d = localPARAM{1};
					delete(win_dw1d);
					dmsgfun('close');
					wtbxappdata('del',figHandle,'localPARAM');
				end
				% wshowdrv('#bloc_BackBtn',figHandle);
				return

			case 2
				if ~isempty(localPARAM)
					win_dw1d = localPARAM{1};
					delete(win_dw1d);
				end
				%----------------------------------------------
				% Display main window (example initialization).
				%----------------------------------------------
				win_dw1d = dw1dtool;
				%----------------------------------------------
				% Main window parameters.
				%----------------------------------------------
				tag_pop_viewm  = 'View_Mode';
				tag_valapp_scr = 'ValApp_Scr';
				pop_handles    = findobj(win_dw1d,'Style','popupmenu');
				pop_viewm      = findobj(pop_handles,'Tag',tag_pop_viewm);
				pop_app_scr    = findobj(pop_handles,'Tag',tag_valapp_scr);
				%------------------------------------------------
				localPARAM = {win_dw1d,pop_viewm,pop_app_scr};
				wtbxappdata('set',figHandle,'localPARAM',localPARAM);
				wshowdrv('#modify_cbClose',figHandle,win_dw1d,'dw1dtool');
				msg = get_Message(idxSlide);
				wshowdrv('#disp_msg',figHandle,msg,'step',localPARAM{1});
				if idxPREV<idxSlide
					figMSG = dmsgfun('handle');
					wshowdrv('#modify_cbClose',figHandle,figMSG,'dmsgfun');
				end
				return
			  
		    otherwise
				[win_dw1d,pop_viewm,pop_app_scr] = deal(localPARAM{:});
		  end

		  switch idxSlide
		    case 3
				if idxPREV<idxSlide
					%--------------------------
					% Full decomposition mode.
					%--------------------------
					sig_nam = 'noisdopp'; wav_nam = 'sym4';	lev_dec = 5;
					dw1dmngr('demo',win_dw1d,sig_nam,wav_nam,lev_dec);
					wenamngr('Inactive',win_dw1d);
				else
					set(pop_viewm,'Value',2);
					eval(get(pop_viewm,'Callback'));
				end

		    case 4
				if idxPREV<idxSlide
					%----------------
					% Separate mode.
					%----------------
					set(pop_viewm,'Value',3);
					eval(get(pop_viewm,'Callback'));
				else
					win_mopt_Params = wtbxappdata('get',figHandle,'win_mopt_Params');
					[win_mopt,chk_det_on,~,~] = deal(win_mopt_Params{:});
					figure(win_mopt);
					set(chk_det_on,'Value',1);
					pause(0.5);
					dw1ddisp('apply',win_dw1d,win_mopt);
					set(pop_app_scr,'Value',1);
					eval(get(pop_app_scr,'Callback'));
					delete(win_mopt)
					wtbxappdata('del',figHandle,'win_mopt_Params');
				end

		    case 5
				if idxPREV<idxSlide
					%--------------------------------------
					% Show and Scroll mode (app5+sig+cfs).
					%--------------------------------------
					set(pop_viewm,'Value',1);
					eval(get(pop_viewm,'Callback'));
					pause(2);
					%----------------------------------------
					% More Display Option window parameters.
					%----------------------------------------
					win_mopt_Params = makeWinOpt(figHandle,win_dw1d);
					[win_mopt,chk_det_on,~,~] = deal(win_mopt_Params{:});
					%------------------------------------------------
					pause(1);
					set(chk_det_on,'Value',0);
					pause(1);
					dw1ddisp('apply',win_dw1d,win_mopt);
					set(pop_app_scr,'Value',5);
					eval(get(pop_app_scr,'Callback'));
				else
					win_mopt_Params = wtbxappdata('get',figHandle,'win_mopt_Params');
					[win_mopt,~,~,pop_ccfs] = deal(win_mopt_Params{:});
					figure(win_mopt);
					pause(1)
					set(pop_ccfs,'Value',1);
					pause(1)
					dw1ddisp('apply',win_dw1d,win_mopt);
				end

		    case 6
				%--------------------------------------------
				% Show and Scroll mode (app5+sig+cfs ).
				%     coloration : init + all levels + abs
				%--------------------------------------------
				if idxPREV>idxSlide
					makeWinOpt(figHandle,win_dw1d);
					return;
				end
				win_mopt_Params = wtbxappdata('get',figHandle,'win_mopt_Params');
				[win_mopt,~,~,pop_ccfs] = deal(win_mopt_Params{:});
				figure(win_mopt);
				pause(1)
				set(pop_ccfs,'Value',3);
				pause(1)
				dw1ddisp('apply',win_dw1d,win_mopt);

		    case 7
				%-----------------------------------
				% Close More Display Option window.
				% And message for Histograms.
				%-----------------------------------
				if idxPREV<idxSlide
					win_mopt_Params = wtbxappdata('get',figHandle,'win_mopt_Params');
					win_mopt = win_mopt_Params{1};
					dw1ddisp('close',win_dw1d,win_mopt);
					wtbxappdata('del',figHandle,'win_mopt_Params');
					wenamngr('Inactive',win_dw1d);
				else
					win_hist_Params = wtbxappdata('get',figHandle,'win_hist_Params');
					win_hist = win_hist_Params{1};
					dw1dhist('close',win_hist);
					delete(win_hist)
					wtbxappdata('del',figHandle,'win_hist_Params');
				end

			case 8
				%--------------------------------------------------
				% Histograms window - all the detail coefficients.
				% And first message for De-noising.
				%--------------------------------------------------
				win_hist      = dw1dmngr('hist',win_dw1d);
				wenamngr('Inactive',win_hist);
				tag_det_sig   = 'Det_sig';
				tag_det_all   = 'Det_All';
				tag_sel_cfs   = 'Sel_Cfs';
				tag_show_hist = 'Show_Hist';
				uic_win_hist  = findobj(win_hist,'Type','uicontrol');
				chk_win_hist  = findobj(uic_win_hist,'Style','checkbox');
				pus_win_hist  = findobj(uic_win_hist,'Style','pushbutton');
				chk_det_sig   = findobj(chk_win_hist,'Tag',tag_det_sig);
				pus_det_all   = findobj(pus_win_hist,'Tag',tag_det_all);
				rad_sel_cfs   = findobj(uic_win_hist,'Style','radiobutton','Tag',tag_sel_cfs);
				pus_show_hist = findobj(pus_win_hist,'Tag',tag_show_hist);
				win_hist_Params = {win_hist,chk_det_sig,pus_det_all,rad_sel_cfs,pus_show_hist};
				wtbxappdata('set',figHandle,'win_hist_Params',win_hist_Params);
				%--------------------------------------------------
				set(chk_det_sig,'Value',1)      
				eval(get(chk_det_sig,'Callback')); pause(1)
				eval(get(pus_det_all,'Callback')); pause(1)
				eval(get(rad_sel_cfs,'Callback')); pause(1)
				eval(get(pus_show_hist,'Callback'));
				wenamngr('Inactive',win_hist);
				
		    case 9
				if idxPREV<idxSlide
					%------------------------------------
					% Close Histograms window.
					% And first message for Compression.
					%------------------------------------
					deleteSubFig(figHandle,'win_hist_Params');
					wenamngr('Inactive',win_dw1d);
				else
					deleteSubFig(figHandle,'win_comp_Params');
				end

		    case 10
				if idxPREV>idxSlide
					deleteSubFig(figHandle,'win_comp_Params');
					deleteSubFig(figHandle,'win_deno_Params');
				end

				%----------------------------------------
				% Compression: Initialization of  window.
				%----------------------------------------
				win_comp = dw1dmngr('comp',win_dw1d);
				wenamngr('Inactive',win_comp);
				% UTTHRGBL handlesUIC (Compression).
				%---------------------------------------
				% ud.handlesUIC = ...
				%   [fra_utl;txt_top;pop_met;...
				%    txt_sel;sli_sel;edi_sel; ...
				%    txt_nor;edi_nor;txt_npc;...
				%    txt_zer;edi_zer;txt_zpc;...
				%    tog_res;pus_est];
				%---------------------------------------
				% Memory of stored values (Compression).
				%---------------------------------------
				n_misc_comp = 'MB1_dw1dcomp';
				ind_status  = 2;
				ind_pop_mod = 8;
				pop_mod    = wmemtool('rmb',win_comp,n_misc_comp,ind_pop_mod);
				handlesUIC = utthrgbl('handlesUIC',win_comp);
				edi_zer    = handlesUIC(11);
				win_comp_Params = {win_comp,pop_mod,edi_zer,n_misc_comp,ind_status};
				wtbxappdata('set',figHandle,'win_comp_Params',win_comp_Params);
				%--------------------------------------------------
				
			case 11
				%----------------------------------------------------
				% Compression: Global mode.
				% After compression with the default threshold value.
				%----------------------------------------------------
				win_comp_Params = wtbxappdata('get',figHandle,'win_comp_Params');
				win_comp = win_comp_Params{1};
				dw1dcomp('compress',win_comp,win_dw1d);
				wenamngr('Inactive',win_comp);
				
			case 12
				%--------------------------------------
				% Compression: change the zeros value.
				%--------------------------------------
				win_comp_Params = wtbxappdata('get',figHandle,'win_comp_Params');
				[win_comp,~,edi_zer,~,~] = deal(win_comp_Params{:});
				set(edi_zer,'String',num2str(96.4));
				eval(get(edi_zer,'Callback'));
				dw1dcomp('compress',win_comp,win_dw1d);
				wenamngr('Inactive',win_comp);
				
			case 13
				%----------------------------------------------------
				% Compression: By Level mode.
				%----------------------------------------------------
				win_comp_Params = wtbxappdata('get',figHandle,'win_comp_Params');
				[win_comp,pop_mod,~,~,~] = deal(win_comp_Params{:});
				set(pop_mod,'Value',2)
				eval(get(pop_mod,'Callback'))
				wenamngr('Inactive',win_comp);
				
			case 14
				%-----------------------------------------------------
				% Compression: By Level mode.
				% After compression with the default threshold values.
				%-----------------------------------------------------
				win_comp_Params = wtbxappdata('get',figHandle,'win_comp_Params');
				win_comp = win_comp_Params{1};
				dw1dcomp('compress',win_comp,win_dw1d);
				wenamngr('Inactive',win_comp);
				
		    case 15
				%----------------------------
				% Close Compression window.
				% And message for De-noising.
				%----------------------------
				deleteSubFig(figHandle,'win_comp_Params');
				wenamngr('Inactive',win_dw1d);
			  
		    case 16
				if idxPREV>idxSlide
					deleteSubFig(figHandle,'win_deno_Params');
					lin_handles = findobj(win_dw1d,'Type','line');
					try %#ok<*TRYNC>
						lin(1) = findobj(lin_handles,'Tag','SSig_in_App');
						lin(2) = findobj(lin_handles,'Tag','SSig_in_Det');
						delete(lin);
					end
				end
				
				%--------------------------------------------------
				% De-noising: 
				%   - Initialization of  window.
				%   - De-noising with the default threshold values,
				%     with Fixed form soft thresholding method.
				%--------------------------------------------------
				win_deno = dw1dmngr('deno',win_dw1d);
				wenamngr('Inactive',win_deno);
				% UTTHRW1D handlesUIC (De-noising).
				%-------------------------------------
				% ud.handlesUIC = ...
				%   [fra_utl;txt_top;pop_met; ...
				%    rad_sof;rad_har;txt_noi;pop_noi; ...
				%    txt_BMS;sli_BMS;txt_tit(1:4),...
				%    txt_nor;edi_nor;txt_npc; ...
				%    txt_zer;edi_zer;txt_zpc; ...
				%    tog_thr;tog_res;pus_est];
				%--------------------------------------------------
				handlesUIC = utthrw1d('handlesUIC',win_deno);
				pop_met    = handlesUIC(3);
				rad_har    = handlesUIC(5);
				win_deno_Params = {win_deno,pop_met,rad_har};
				wtbxappdata('set',figHandle,'win_deno_Params',win_deno_Params);
				%--------------------------------------------------
				pause(1)
				dw1ddeno('denoise',win_deno,win_dw1d);
				wenamngr('Inactive',win_deno);				
				
			case 17
				%--------------------------------------------------
				% De-noising: 
				%   - De-noising with the default threshold values.
				%     with Fixed form hard thresholding.
				%--------------------------------------------------
				win_deno_Params = wtbxappdata('get',figHandle,'win_deno_Params');
				[win_deno,pop_met,rad_har] = deal(win_deno_Params{:});
				if idxPREV>idxSlide
					set(pop_met,'Value',1)
					eval(get(pop_met,'Callback'))
				end
				set(rad_har,'Value',1)
				eval(get(rad_har,'Callback'))
				dw1ddeno('denoise',win_deno,win_dw1d);
				wenamngr('Inactive',win_deno);

			case 18
				% De-noising: 
				%   - Change the method of thresholding to:
				%     the Penalize medium thresholding method.
				%--------------------------------------------------
				win_deno_Params = wtbxappdata('get',figHandle,'win_deno_Params');
				[~,pop_met,~] = deal(win_deno_Params{:});
				set(pop_met,'Value',6)
				eval(get(pop_met,'Callback'))
				
			case 19
				if idxPREV<idxSlide
					% De-noising: 
					%   - De-noising with the default threshold values,
					%     with Penalize medium thresholding method.
					%--------------------------------------------------
					win_deno_Params = wtbxappdata('get',figHandle,'win_deno_Params');
					win_deno = win_deno_Params{1};
					dw1ddeno('denoise',win_deno,win_dw1d);
					wenamngr('Inactive',win_deno);
				else
					dmsgfun('close');
				end

			case 20 
				if idxPREV>idxSlide
					deleteSubFig(figHandle,'win_deno_Params');
					win_deno = dw1dmngr('deno',win_dw1d);
					wenamngr('Inactive',win_deno);
					handlesUIC = utthrw1d('handlesUIC',win_deno);
					pop_met    = handlesUIC(3);
					rad_har    = handlesUIC(5);
					win_deno_Params = {win_deno,pop_met,rad_har};
					wtbxappdata('set',figHandle,'win_deno_Params',win_deno_Params);
					set(pop_met,'Value',6)
					eval(get(pop_met,'Callback'))
					dw1ddeno('denoise',win_deno,win_dw1d);
					wenamngr('Inactive',win_deno);
				else
					% DISPLAY MESSAGE ONLY!
				end

			case 21
				%-------------------------------
				% Close De-noising window
				% and update synthesized signal.
				%-------------------------------
				win_deno_Params = wtbxappdata('get',figHandle,'win_deno_Params');
				win_deno = win_deno_Params{1};
				% MemBloc1 of stored values.
				%---------------------------
				n_param_anal  = 'DWAn1d_Par_Anal';
				ind_ssig_type = 7;
				wwaiting('msg',win_deno,getWavMSG('Wavelet:commongui:WaitCompute'));
				lin_den = utthrw1d('get',win_deno,'handleTHR');
				wmemtool('wmb',win_dw1d,n_param_anal,ind_ssig_type,'ds');
				dw1dmngr('return_deno',win_dw1d,1,lin_den);
				wenamngr('Inactive',win_dw1d);
				wwaiting('off',win_deno);
				delete(win_deno)
				dmsgfun('close');
				
			case 22
				if idxPREV<idxSlide
					%----------------------------------------
					% More Display Option window parameters.
					%----------------------------------------
					win_mopt_Params = makeWinOpt(figHandle,win_dw1d);
					win_mopt = win_mopt_Params{1};
					wenamngr('Inactive',win_mopt);
					%-----------------------------------------
				else
					win_mopt_Params = wtbxappdata('get',figHandle,'win_mopt_Params');
					[win_mopt,~,chk_cfs_on,~] = deal(win_mopt_Params{:});
					set(chk_cfs_on,'Value',1);
					dw1ddisp('apply',win_dw1d,win_mopt);
				end

		    case 23
				if idxPREV<idxSlide
					win_mopt_Params = wtbxappdata('get',figHandle,'win_mopt_Params');
				else
					win_mopt_Params = makeWinOpt(figHandle,win_dw1d);
				end
				[win_mopt,~,chk_cfs_on,~] = deal(win_mopt_Params{:});
				set(chk_cfs_on,'Value',0);
				pause(1)
				dw1ddisp('apply',win_dw1d,win_mopt);

			case 24
				%-----------------------------------
				% Close More Display Option window.
				%-----------------------------------
				deleteSubFig(figHandle,'win_mopt_Params');
		  end
		  [msg,ok] = get_Message(idxSlide);
		  if ok , wshowdrv('#disp_msg',figHandle,msg,'step',win_dw1d); end
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
	  [mfilename ,'(''slidePROC'',figHandle,',int2str(idx),');']};

  %========== Slide 2 to Slide 24 ==========
  for idx = 2:24
    slide(idx).code = {[mfilename ,'(''slidePROC'',figHandle,',int2str(idx),');']}; %#ok<AGROW>
  end

  %========== Set "previous" slide indices ==========
  
  % Compression slides.
  %--------------------
  slide(12).idxPrev = 10;
  slide(13).idxPrev = 10;
  slide(14).idxPrev = 10;
  slide(15).idxPrev = 10;
  
  % De-noising slides.
  %-------------------
  slide(16).idxPrev = 10;
  slide(21).idxPrev = 20;
  slide(22).idxPrev = 20;
  %===================================================

  varargout{1} = slide;
  
end


%------------------------------------------------------------------------------------------%
function deleteSubFig(figHandle,win_Params_Name)

win_Params = wtbxappdata('get',figHandle,win_Params_Name);
if ~isempty(win_Params)
	win = win_Params{1};
	if ishandle(win) , delete(win); end
	wtbxappdata('del',figHandle,win_Params_Name);
end
%------------------------------------------------------------------------------------------%
function win_mopt_Params = makeWinOpt(figHandle,win_dw1d)

win_mopt = dw1ddisp('create',win_dw1d);
wenamngr('Inactive',win_mopt);
tag_cfs_on   = 'Chk_Cfs';
tag_det_on   = 'Chk_Det';
tag_pop_ccfs = 'Pop_CCfs';
uic_win_mopt = findobj(win_mopt,'Type','uicontrol');
chk_det_on   = findobj(uic_win_mopt,'Tag',tag_det_on);
chk_cfs_on   = findobj(uic_win_mopt,'Tag',tag_cfs_on);
pop_ccfs     = findobj(uic_win_mopt,'Tag',tag_pop_ccfs);
win_mopt_Params = {win_mopt,chk_det_on,chk_cfs_on,pop_ccfs};
wtbxappdata('set',figHandle,'win_mopt_Params',win_mopt_Params);
%------------------------------------------------------------------------------------------%
function [msg,ok_msg] = get_Message(idxSlide)

ok_msg = 1;
switch idxSlide
    case 2 , msg = getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_1');
    case 3
        msg = {
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_2')), ...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_3')), ...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_4')), ...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_5')), ...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_6'))  ...
            };
    case 4
        msg = {...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_7')), ...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_8')), ...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_9'))  ...
            };
    case 6 , msg = getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_10');
    case 7 , msg = getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_11');
    case 8 , msg = getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_12');
    case 9 , msg = getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_13'); 
    case 10
        msg = {...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_14')), ...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_15')), ...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_16'))  ...
            };
    case 12 , msg = getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_17');
    case 13 , msg = getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_18');
    case 15
        msg = {...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_19')), ...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_20')), ...
            char(getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_21'))  ...
            };
    case 16
        msg = getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_22');
        ok_msg = 1;
        
    % case 17 , % msg = getWavMSG('Wavelet:commongui:Wait');
        
    case 20 , msg = getWavMSG('Wavelet:wavedemoMSGRF:dscedw1d_MSG_23');
        
    otherwise
        msg = '';
        ok_msg = 0;
end
%------------------------------------------------------------------------------------------%
