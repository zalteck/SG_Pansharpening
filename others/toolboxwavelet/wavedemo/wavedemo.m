function wavedemo(option,in2,in3) %#ok<INUSD>
%WAVEDEMO Wavelet Toolbox examples.
%   WAVEDEMO brings up a GUI that allows you to choose
%   between several Wavelet Toolbox examples.

%   WAVEDEMO('auto') shows all the examples in automatic mode.
%
%   WAVEDEMO('gr_auto') shows all the examples in automatic mode:
%   first in the increasing slide order and then in the 
%   decreasing slide order.
%
%   WAVEDEMO('loop') shows all the examples in loop mode.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.15.4.10 $ $Date: 2012/06/13 09:32:22 $

tag_dem_tool  = 'Demo_Tool';
tag_btn_close = 'Demo_Close';       % tag for sub_window
tag_btn_closeBIS = 'Pus_Close_Win'; % tag for sub_window

if nargin==0
    option = 'create';
elseif (nargin==1)
    switch option
        case {'create','pref','close'}
        case {'auto','gr_auto','loop'}
        case {'democmdm','demoguim','demoscen'}
        otherwise , in2 = option; option = 'pref_b';
    end    
end

if strcmp(option,'pref') || strcmp(option,'pref_b')
    win = wfindobj('figure','Tag',tag_dem_tool);
    if ~isempty(win) , return; end
    if strcmp(option,'pref') && nargin==1 , in2 = 'default'; end
    if ~wtbxmngr('is_on') , wtbxmngr('ini'); end
    mextglob('pref',in2);
    option = 'create';
end

switch option
    case 'create'
        win = wfindobj('figure','Tag',tag_dem_tool);
        if ~isempty(win) , return; end

        % Waiting Frame construction & begin waiting.
        %--------------------------------------------
        mousefrm(0,'watch');
        clc
        disp(getWavMSG('Wavelet:commongui:WaitLoad'));
        drawnow;

        % WAVEDEMO main window initialization.
        %-------------------------------------
        name = getWavMSG('Wavelet:wavedemoMSGRF:WTBX_DEMO');
        [win_wavedemo,pos_win,defBtnWidth,defBtnHeight,win_units] = ...
                wdfigutl('menu',name,[11/4 19/2],tag_dem_tool);
        winSTR = sprintf('%25.18f',win_wavedemo);
        set(win_wavedemo,'CloseRequestFcn',...
            [mfilename '(''close'',' winSTR ')'])

        % Position property of objects.
        %------------------------------
        btn_width   = 2.3*defBtnWidth;
        btn_height  = 3*defBtnHeight/2;
        btn_left    = ceil((pos_win(3)-btn_width)/2);
        btn_low     = pos_win(4)-5*defBtnHeight/2;
        dif_height  = 2*defBtnHeight;
        pos_cmdm    = [btn_left , btn_low , btn_width , btn_height];
        btn_low     = btn_low-dif_height;
        pos_guim    = [btn_left , btn_low , btn_width , btn_height];
        btn_low     = btn_low-dif_height;
        pos_sc1d    = [btn_left , btn_low , btn_width , btn_height];
        btn_low     = btn_low-dif_height;
        pos_close   = [btn_left , btn_low , btn_width , btn_height];

        % String property of objects.
        %----------------------------
        str_cmdm    = getWavMSG('Wavelet:wavedemoMSGRF:Str_cmdm');
        str_guim    = getWavMSG('Wavelet:wavedemoMSGRF:Str_guim');
        str_sc1d    = getWavMSG('Wavelet:wavedemoMSGRF:Str_sc1d');
        str_close   = getWavMSG('Wavelet:commongui:Str_Close');

        % Callback property of objects.
        %------------------------------
        cba_close   = [mfilename '(''close'');'];

        % Construction of objects.
        %-------------------------
        pus_cmdm  = uicontrol('Parent',win_wavedemo,...
                                        'Style','pushbutton',...
                                        'Units',win_units,...
                                        'Position',pos_cmdm,...
                                        'String',str_cmdm...
                                        );
        pus_guim  = uicontrol('Parent',win_wavedemo,...
                                        'Style','pushbutton',...
                                        'Units',win_units,...
                                        'Position',pos_guim,...
                                        'String',str_guim...
                                        );
        pus_sc1d  = uicontrol('Parent',win_wavedemo,...
                                        'Style','pushbutton',...
                                        'Units',win_units,...
                                        'Position',pos_sc1d,...
                                        'String',str_sc1d...
                                        );
        uicontrol('Parent',win_wavedemo,...
            'Style','pushbutton',...
            'Units',win_units,...
            'Position',pos_close,...
            'String',str_close,...
            'Callback',cba_close...
            );

        % Callback property of objects.
        %------------------------------
        str_btn   = num2mstr([pus_cmdm;pus_guim;pus_sc1d]);
        cba_cmdm  = [mfilename '(''democmdm'',' str_btn ');'];
        cba_guim  = [mfilename '(''demoguim'',' str_btn ');'];
        cba_sc1d  = [mfilename '(''demoscen'',' str_btn ');'];
        set(pus_cmdm,'Callback',cba_cmdm);
        set(pus_guim,'Callback',cba_guim);
        set(pus_sc1d,'Callback',cba_sc1d);

        % Setting units to normalized.
        %-----------------------------
        set(findobj(win_wavedemo,'Units','pixels'),'Units','Normalized');

        % Hide figure handle.
        %--------------------
        set(win_wavedemo,'HandleVisibility','off')

        % End waiting.
        %---------------
        clc
        mousefrm(0,'arrow');
        drawnow

    case 'democmdm'
        %******************************************************%
        %** OPTION = 'democmdm' - Command line mode examples **%
        %******************************************************%
        mousefrm(0,'watch')
        set(in2,'Enable','off')
        mousefrm(0,'arrow');
        feval('democmdm');

    case 'demoguim'
        %*********************************************%
        %** OPTION = 'demoguim' - GUI mode examples **%
        %*********************************************%
        mousefrm(0,'watch')
        set(in2,'Enable','off')
        mousefrm(0,'arrow');
        feval('demoguim');

    case 'demoscen'
        %**********************************************%
        %** OPTION = 'demoscen' - Short 1D scenario  **%
        %**********************************************%
        % in3 for auto mode
        %-------------------
        mousefrm(0,'watch')
        set(in2,'Enable','off')
        mousefrm(0,'arrow');
        feval('demoscen');

    case {'auto','gr_auto'}
        %**************************************%
        %** OPTION = 'auto' and 'gr_auto'    **%
		%** All examples in automatic modes. **%
        %**************************************%
        wavedemo('create');
        win = wfindobj('figure','Tag',tag_dem_tool);
        btn = findobj(win,'Style','pushbutton');
        mousefrm(0,'watch')
        set(btn,'Enable','off')
        stop = 0;
        while stop==0
			stop = ~ishandle(win);
			if ~stop , feval('democmdm',option); end
			stop = ~ishandle(win);
			if ~stop , feval('demoguim',option); end
			stop = ~ishandle(win);
			if ~stop , feval('demoscen',option); end
            if ~isequal(stop,1) && nargin==2 && isequal(in2,'loop')
                stop = 0 ;
            else
                stop = 1;
            end
        end
        if ishandle(btn) , set(btn,'Enable','on'); end
        mousefrm(0,'arrow');
        wavedemo('close');

    case 'loop'
        %***************************************************************%
        %** OPTION = 'loop' - loop with all examples (automatic mode) **%
        %***************************************************************%
        wavedemo('auto','loop');

    case 'close'
        %***********************************************%
        %** OPTION = 'close' - close wavedemo window  **%
        %***********************************************%
        mousefrm(0,'watch')
        win = wfindobj('figure','Tag',tag_dem_tool);

        % Closing all opened main analysis windows.
        %------------------------------------------
        pus_handles = wfindobj(0,'Style','pushbutton');
        hdls        = findobj(pus_handles,'flat','Tag',tag_btn_close);
        for i=1:length(hdls)
            try eval(get(hdls(i),'Callback')); end
        end
        try %#ok<*TRYNC>
            hdls = findobj(pus_handles,'flat','Tag',tag_btn_closeBIS);
            for k=1:length(hdls)
                try 
                    FigChild = get(hdls(k),'Parent');
                    eval(get(FigChild,'CloseRequestFcn'));
                end
            end
        end
        try
            WfigPROP = wtbxappdata('get',win,'WfigPROP');
            FigChild = WfigPROP.FigChild;
            for k=1:length(FigChild)
                try eval(get(FigChild,'CloseRequestFcn')); end
            end
        end

        % Closing the wavedemo window.
        %-----------------------------
        try delete(win); end
        mextglob('clear');
        wtbxmngr('clear');
        mousefrm(0,'arrow');

    otherwise
        errargt(mfilename,getWavMSG('Wavelet:moreMSGRF:Unknown_Opt'),'msg');
        error(message('Wavelet:FunctionArgVal:Invalid_ArgVal'));
end
