function out1 = democmdm(option,in2,in3)
%DEMOCMDM Main command-line mode examples menu in the Wavelet Toolbox.
%   DEMOCMDM creates the window for command line mode examples.

%   DEMOCMDM('auto') shows all the command line mode examples
%   in automatic mode.
%
%   DEMOCMDM('gr_auto') shows all the command line mode examples
%   in automatic mode: first in the increasing slide order
%   and then in the decreasing slide order.
%
%   DEMOCMDM('loop') shows all the command line mode examples
%   in loop mode.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.17.4.9 $ $Date: 2012/06/13 09:31:57 $

if nargin==0 , option = 'create'; end

tag_dem_tool  = 'Demo_Tool';
tag_cmdm_tool = 'Cmdm_Tool';
tag_btn_close = 'Demo_Close';
tag_sub_close = 'Cmdm_Close';

switch option
    case 'create'
        win = wfindobj('figure','Tag',tag_cmdm_tool);
        if ~isempty(win) , return; end

        % Waiting Frame construction & begin waiting.
        %--------------------------------------------
        mousefrm(0,'watch');

        % CMDM main window initialization.
        %---------------------------------
        name = getWavMSG('Wavelet:wavedemoMSGRF:Str_cmdm_Ex');
        [win_democmdm,pos_win,defBtnWidth,defBtnHeight,win_units] = ...
                wdfigutl('menu',name,[13/4 41/2],tag_cmdm_tool);
        if nargout>0 ,out1 = win_democmdm; end
        str_win_democmdm = int2str(win_democmdm);

        % Position property of objects.
        %------------------------------
        btn_width  = 3*defBtnWidth;
        btn_height = 3*defBtnHeight/2;
        btn_left   = ceil(pos_win(3)-btn_width)/2;
        btn_low    = pos_win(4)-2*defBtnHeight;
        dif_height = 2*defBtnHeight;
        pos_dw1d   = [btn_left , btn_low , btn_width , btn_height];
        btn_low    = btn_low-dif_height;
        pos_cw1d   = [btn_left , btn_low , btn_width , btn_height];
        btn_low    = btn_low-dif_height;
        pos_dw2d   = [btn_left , btn_low , btn_width , btn_height];
        btn_low    = btn_low-dif_height;
        pos_comp   = [btn_left , btn_low , btn_width , btn_height];
        btn_low    = btn_low-dif_height;
        pos_deno   = [btn_left , btn_low , btn_width , btn_height];
        btn_low    = btn_low-dif_height;
        pos_wpck   = [btn_left , btn_low , btn_width , btn_height];
        btn_low    = btn_low-dif_height;
        pos_mala   = [btn_left , btn_low , btn_width , btn_height];
        btn_low    = btn_low-dif_height;
        pos_casc   = [btn_left , btn_low , btn_width , btn_height];
        btn_low    = btn_low-dif_height;
        pos_extm   = [btn_left , btn_low , btn_width , btn_height];
        btn_low    = btn_low-dif_height;
        pos_close  = [btn_left , btn_low , btn_width , btn_height];

        % String property of objects.
        %----------------------------
        str_dw1d   = getWavMSG('Wavelet:wavedemoMSGRF:Str_dw1d');
        str_cw1d   = getWavMSG('Wavelet:wavedemoMSGRF:Str_cw1d');
        str_dw2d   = getWavMSG('Wavelet:wavedemoMSGRF:Str_dw2d');
        str_comp   = getWavMSG('Wavelet:wavedemoMSGRF:Str_comp');
        str_deno   = getWavMSG('Wavelet:wavedemoMSGRF:Str_deno');
        str_wpck   = getWavMSG('Wavelet:wavedemoMSGRF:Str_wpck');
        str_mala   = getWavMSG('Wavelet:wavedemoMSGRF:Str_mala');
        str_casc   = getWavMSG('Wavelet:wavedemoMSGRF:Str_casc');
        str_extm   = getWavMSG('Wavelet:wavedemoMSGRF:Str_extm');
        str_close  = getWavMSG('Wavelet:commongui:Str_Close');

        % Callback property of objects.
        %------------------------------
        cba_dw1d  = [mfilename '(''dw1d'',' str_win_democmdm ');'];
        cba_cw1d  = [mfilename '(''cw1d'',' str_win_democmdm ');'];
        cba_dw2d  = [mfilename '(''dw2d'',' str_win_democmdm ');'];
        cba_comp  = [mfilename '(''comp'',' str_win_democmdm ');'];
        cba_deno  = [mfilename '(''deno'',' str_win_democmdm ');'];
        cba_wpck  = [mfilename '(''wpck'',' str_win_democmdm ');'];
        cba_mala  = [mfilename '(''mala'',' str_win_democmdm ');'];
        cba_casc  = [mfilename '(''casc'',' str_win_democmdm ');'];
        cba_extm  = [mfilename '(''extm'',' str_win_democmdm ');'];
        cba_close = [mfilename '(''close'',' str_win_democmdm ');'];

        % Construction of objects.
        %-------------------------
        uicontrol(...
            'Style','pushbutton',...
            'Units',win_units,...
            'Position',pos_dw1d,...
            'String',str_dw1d,...
            'Callback',cba_dw1d...
            );
        uicontrol(...
            'Style','pushbutton',...
            'Units',win_units,...
            'Position',pos_cw1d,...
            'String',str_cw1d,...
            'Callback',cba_cw1d...
            );
        uicontrol(...
            'Style','pushbutton',...
            'Units',win_units,...
            'Position',pos_dw2d,...
            'String',str_dw2d,...
            'Callback',cba_dw2d...
            );
        uicontrol(...
            'Style','pushbutton',...
            'Units',win_units,...
            'Position',pos_comp,...
            'String',str_comp,...
            'Callback',cba_comp...
            );
        uicontrol(...
            'Style','pushbutton',...
            'Units',win_units,...
            'Position',pos_deno,...
            'String',str_deno,...
            'Callback',cba_deno...
            );
        uicontrol(...
            'Style','pushbutton',...
            'Units',win_units,...
            'Position',pos_wpck,...
            'String',str_wpck,...
            'Callback',cba_wpck...
            );
        uicontrol(...
            'Style','pushbutton',...
            'Units',win_units,...
            'Position',pos_mala,...
            'String',str_mala,...
            'Callback',cba_mala...
            );
        uicontrol(...
            'Style','pushbutton',...
            'Units',win_units,...
            'Position',pos_casc,...
            'String',str_casc,...
            'Callback',cba_casc...
            );
        uicontrol(...
            'Style','pushbutton',...
            'Units',win_units,...
            'Position',pos_extm,...
            'String',str_extm,...
            'Callback',cba_extm...
            );
        uicontrol(...
            'Style','pushbutton',...
            'Units',win_units,...
            'Position',pos_close,...
            'String',str_close,...
            'Callback',cba_close,...
            'Tag',tag_btn_close...
            );

        % Prevent OS closing.
        %--------------------
        set(win_democmdm,'CloseRequestFcn',cba_close)

        % Setting units to normalized.
        %-----------------------------
        set(findobj(win_democmdm,'Units','pixels'),'Units','Normalized');

        % Hide figure handle.
        %-------------------
        set(win_democmdm,'HandleVisibility','Off')

        % End waiting.
        %---------------
        mousefrm(0,'arrow');
        drawnow

    case 'enable'
        %*************************************************************%
        %** OPTION = 'enable' - Disable or Enable democmdm window   **%
        %*************************************************************%
        % in2 = win handle
        % in3 = 'on' or 'off'   
        %--------------------
        if isequal(in3(1:2),'of')
            mousefrm(0,'watch');
        else
            mousefrm(0,'arrow');
        end
        set(findobj(in2,'Style','pushbutton'),'Enable',in3);
        drawnow;

    case {'dw1d','cw1d','dw2d','comp','deno','wpck','mala','casc','extm'}
        %********************************************************%
        %** OPTION = 'dw1d' -  example DW1D                    **%
        %** OPTION = 'cw1d' -  example CW1D                    **%
        %** OPTION = 'dw2d' -  example DW2D                    **%
        %** OPTION = 'comp' -  example Compression             **%
        %** OPTION = 'deno' -  example De-noising              **%
        %** OPTION = 'wpck' -  example for Wavelet packets     **%
        %** OPTION = 'mala' -  example for Mallat algorithm    **%
        %** OPTION = 'casc' -  example for Cascade algorithm   **%
        %** OPTION = 'extm' -  example for Boundary distortion **%
        %********************************************************%
        expo_flag = 0;
        if nargin==1
            win = wfindobj('figure','Tag',tag_cmdm_tool);
        else
            win = in2;
			if isempty(win) , expo_flag = 1; end
        end
        if ishandle(win) , democmdm('enable',win,'off'); end
        demoname = ['dcmd' option];
		addclose = [mfilename '(''endshow'');'];
		if expo_flag
			addclose = [addclose 'mextglob(''clear''); wtbxmngr(''clear'');'];
		end
		fig = wshowdrv(demoname,addclose,tag_sub_close);
		if nargout>0 , out1 = fig; end
		mousefrm(0,'arrow');

    case {'auto','gr_auto'}
        %***************************************%
        %** OPTION = 'auto' and 'gr_auto'     **%
		%** All examples in automatic modes.  **%
        %***************************************%
		lstDEMOS = {'dw1d','cw1d','dw2d','comp','deno','wpck','mala','casc','extm'};
        win = democmdm('create');
		democmdm('enable',win,'off');
		stop = 0;
        while stop==0
			for k=1:length(lstDEMOS)
				feval(['dcmd',lstDEMOS{k}],option);
				if ~ishandle(win) , stop = 1; break; end
			end
            if ~isequal(stop,1) && nargin==2 && isequal(in2,'loop')
                stop = 0 ;
            else
                stop = 1;
            end
        end
        democmdm('close',win);
	
    case 'loop'
        %***************************************************************%
        %** OPTION = 'loop' - loop with all examples (automatic mode) **%
        %***************************************************************%
        democmdm('auto','loop');

	case 'endshow'
        %**************************************************%
        %** OPTION = 'endshow' - used to finish wshowdrv **%
        %**************************************************%
        win = wfindobj('figure','Tag',tag_cmdm_tool);
        set(findobj(win,'Style','pushbutton'),'Enable','on');
        drawnow;

    case 'close'
        %***********************************************%
        %** OPTION = 'close' - close democmdm window  **%
        %***********************************************%
        mousefrm(0,'watch')
        if nargin==2
            win_democmdm = in2;
        else
            win_democmdm = wfindobj('figure','Tag',tag_cmdm_tool);
        end

        % Closing all opened main analysis windows.
        %------------------------------------------
        pus_handles = wfindobj(0,'Style','pushbutton');
        hdls        = findobj(pus_handles,'flat','Tag',tag_sub_close);
        for i=1:length(hdls)
            hdl = hdls(i);
            try %#ok<*TRYNC>
              par = get(hdl,'Parent');
              try eval(get(hdl,'Callback')); end
              delete(par);
            end
        end

        % Closing the democmdm window.
        %-----------------------------
        try delete(win_democmdm); end

        win_ini = wfindobj('figure','Tag',tag_dem_tool);
        if ~isempty(win_ini)
            pus_handles = findobj(win_ini,'Style','pushbutton');
            set(pus_handles,'Enable','on');
        else
            mextglob('clear')
            wtbxmngr('clear')
        end
        mousefrm(0,'arrow');

    otherwise
        errargt(mfilename,getWavMSG('Wavelet:moreMSGRF:Unknown_Opt'),'msg');
        error(message('Wavelet:FunctionArgVal:Invalid_ArgVal'));
end
