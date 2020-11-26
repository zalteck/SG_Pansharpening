function figdmsg = dmsgfun(option,in2,in3)
%DMSGFUN  Message function for examples in the Wavelet Toolbox.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.17.4.7 $

% Tag property of objects.
%------------------------
tag_dmsgfig = 'Wdmsgfig';
tag_txtinfo = 'Axe_info';

figdmsg = wfindobj('figure','Tag',tag_dmsgfig);
switch option
    case 'create'
        % Get Globals.
        %-------------
        if isempty(figdmsg)
			Def_Btn_Height = mextglob('get','Def_Btn_Height');
            win_units  = 'pixels';
            win_height = 6*Def_Btn_Height;
            if nargin==3 ,  win_view = in3; else win_view = NaN; end
            Screen_Size = getMonitorSize;
			defFigPos = get(0,'DefaultFigurePosition');
            if ishandle(win_view)
                old_u = get(win_view,'Units');
                set(win_view,'Units',win_units);
                pos_call_win = get(win_view,'Position');
				win_width = 4.5*defFigPos(3)/5;
                xleft = pos_call_win(1)+(pos_call_win(3)-win_width)/4;
                set(win_view,'Units',old_u);
                pos_win = [xleft, pos_call_win(2), win_width, win_height];
            else
                win_width = defFigPos(3);
                pos_win = [ Screen_Size(3)-5-win_width , 0 ,...
                            win_width , win_height ];
            end
			% if Screen_Size(4)<800 , pos_win(2) = 20; end
			axe_col = 'w'; 
            figdmsg = colordef('new','none');
            set(figdmsg,...
                    'MenuBar','none',...
                    'Visible','off',...
                    'Units',win_units,...
                    'Position',pos_win,...
                    'Color',axe_col,...
                    'NumberTitle','off',...
                    'Tag',tag_dmsgfig...
                    );
			bord  = 10;
            p_text = [bord bord/5 win_width-2*bord win_height-2*bord/5];
            txt_Hdl = uicontrol(...
                    'Parent',figdmsg,    ...
                    'Style','edit',      ...
                    'Visible','off',     ...
                    'Units',win_units,   ...
                    'Position',p_text,   ...
					'FontWeight','bold', ...
					'FontSize',8,        ...
					'Max',40,            ...
					'HorizontalAlignment','left',...
                    'BackgroundColor',[1 1 1],   ...
					'ForegroundColor',[0 0 0],   ...
                    'Tag',tag_txtinfo    ...
                    );
            set([figdmsg,txt_Hdl],'Units','normalized','Visible','on');
            set(figdmsg,'Name',getWavMSG('Wavelet:wavedemoMSGRF:MSG_Win'));
        else
            set(figdmsg,'HandleVisibility','on');
            txt_Hdl = findobj(figdmsg,'Tag',tag_txtinfo);
            figure(figdmsg);
        end
		set(txt_Hdl,'String',in2);
        set(figdmsg,'HandleVisibility','off');

    case 'close'
        delete(figdmsg);
end
