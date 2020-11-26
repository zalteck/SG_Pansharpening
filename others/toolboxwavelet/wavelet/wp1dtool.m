function varargout = wp1dtool(option,varargin)
%WP1DTOOL Wavelet packets 1-D tool.
%   VARARGOUT = WP1DTOOL(OPTION,VARARGIN)
%
%   OPTION = 'create' , 'close' , 'read' , 'show'

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision 01-Nov-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.20.4.11 $ $Date: 2012/12/03 01:57:43 $

% Test inputs.
%-------------
if nargin==0 , option = 'create'; end
[option,winAttrb] = utguidiv('ini',option,varargin{:});

% Default values.
%----------------
% max_lev_anal = 12;
default_nbcolors = 128;

% Memory Blocks of stored values.
%================================
% MB0.
%-----
n_InfoInit   = 'WP1D_InfoInit';
% ind_filename = 1;
% ind_pathname = 2;
nb0_stored   = 2;

% MB1.
%-----
n_param_anal   = 'WP1D_Par_Anal';
% ind_sig_name   = 1;
% ind_wav_name   = 2;
% ind_lev_anal   = 3;
% ind_ent_anal   = 4;
% ind_ent_par    = 5;
% ind_sig_size   = 6;
% ind_act_option = 7;
% ind_thr_val    = 8;
nb1_stored     = 8;

% MB2.
%-----
n_wp_utils = 'WP_Utils';
% ind_tree_lin  = 1;
% ind_tree_txt  = 2;
% ind_type_txt  = 3;
% ind_sel_nodes = 4;
ind_gra_area  = 5;
% ind_nb_colors = 6;
nb2_stored    = 6;

% Tag property of objects.
%-------------------------
tag_m_exp_wrks = 'm_exp_wrks';
% tag_m_savesyn = 'Save_Syn';
% tag_m_savedec = 'Save_Dec';
tag_pus_anal  = 'Pus_Anal';
tag_pus_deno  = 'Pus_Deno';
tag_pus_comp  = 'Pus_Comp';
tag_pus_btree = 'Pus_Btree';
tag_pus_blev  = 'Pus_Blev';
tag_inittree  = 'Pus_InitTree';
tag_wavtree   = 'Pus_WavTree';
tag_curtree   = 'Pop_CurTree';
tag_nodlab    = 'Pop_NodLab';
tag_nodact    = 'Pop_NodAct';
tag_nodsel    = 'Pus_NodSel';
tag_txt_full  = 'Txt_Full';
tag_pus_full  = {'Pus_Full.1';'Pus_Full.2';'Pus_Full.3';'Pus_Full.4'};
tag_txt_colm  = 'Txt_ColM';
tag_pop_colm  = 'Txt_PopM';
tag_axe_t_lin = 'Axe_TreeLines';
tag_axe_sig   = 'Axe_Sig';
tag_axe_pack  = 'Axe_Pack';
tag_axe_cfs   = 'Axe_Cfs';
tag_axe_col   = 'Axe_Col';
tag_sli_size  = 'Sli_Size';
tag_sli_pos   = 'Sli_Pos';

switch option
    case 'create'
        % Get Globals.
        %-------------
        [Def_Txt_Height,Def_Btn_Height,Def_Btn_Width, ...
         X_Spacing,Y_Spacing,Def_FraBkColor] = ...
            mextglob('get',...
              'Def_Txt_Height','Def_Btn_Height','Def_Btn_Width',   ...
              'X_Spacing','Y_Spacing','Def_FraBkColor');

        % Wavelet Packets 1-D window initialization.
        %-------------------------------------------
        [win_wptool,pos_win,win_units,str_numwin,...
                pos_frame0,Pos_Graphic_Area] = ...
                    wfigmngr('create',getWavMSG('Wavelet:wp1d2dRF:NamWinWP_1D'),...
                               winAttrb,'ExtFig_Tool',mfilename,1,1,0);
        set(win_wptool,'Tag',mfilename);
        if nargout>0 , varargout{1} = win_wptool; end
		
		% Add Help for Tool.
		%------------------
		wfighelp('addHelpTool',win_wptool, ...
            getWavMSG('Wavelet:commongui:HLP_OneDim'),'WP1D_GUI');

		% Add Help Item.
		%----------------
		wfighelp('addHelpItem',win_wptool, ...
            getWavMSG('Wavelet:wp1d2dRF:HLP_WP'),'WP_PACKETS');
		wfighelp('addHelpItem',win_wptool, ...
            getWavMSG('Wavelet:commongui:HLP_Tool'),'WP_TOOLS');
		wfighelp('addHelpItem',win_wptool, ...
            getWavMSG('Wavelet:commongui:HLP_LoadSave'),'WP_LOADSAVE');

        % Menu construction for current figure.
        %--------------------------------------
		[m_files,m_load,m_save] = ...
			wfigmngr('getmenus',win_wptool,'file','load','save');
        set(m_save,'Enable','Off');
        
        m_loadtst = uimenu(m_files,...
            'Label',getWavMSG('Wavelet:commongui:Lab_Example'), ...
            'Position',3,'Separator','Off'...
            );        
        m_imp_wrks = uimenu(m_files,...
            'Label',getWavMSG('Wavelet:commongui:Lab_Import'), ...
            'Position',4,'Separator','On'  ...
            );
        m_exp_wrks = uimenu(m_files,...
            'Label',getWavMSG('Wavelet:commongui:Lab_Export'),  ...
            'Position',5,'Enable','Off','Separator','Off', ...
            'Tag',tag_m_exp_wrks ...            
            );

        uimenu(m_load,...
            'Label',getWavMSG('Wavelet:commongui:Str_Sig'), ...
            'Position',1,      ...
            'Callback',['wp1dmngr(''load_sig'',' str_numwin ');'] ...
            );
        uimenu(m_load,...
            'Label',getWavMSG('Wavelet:commongui:Str_Decomp'), ...
            'Position',2, ...
            'Callback',['wp1dmngr(''load_dec'',' str_numwin ');'] ...
            );
        
        uimenu(m_save,...
            'Label',getWavMSG('Wavelet:commongui:Str_SynSig'),...
            'Position',1,        ...
            'Callback',['wp1dmngr(''save_synt'',' str_numwin ');'] ...
            );
        uimenu(m_save,...
            'Label',getWavMSG('Wavelet:commongui:Str_Decomp'), ...
            'Position',2,         ...
            'Callback',['wp1dmngr(''save_dec'',' str_numwin ');'] ...
            );        

        % Submenu of test signals.
        %-------------------------
        beg_call_str = ['wp1dmngr(''demo'',' str_numwin];

        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_1');
        end_call_str    = ',''sumsin'',''db1'',2,''shannon'');';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);

        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_2');        
        end_call_str    = ',''freqbrk'',''haar'',3,''shannon'');';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_3');        
        end_call_str    = ',''mfrqbrk'',''haar'',4,''shannon'');';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_4');        
        end_call_str    = ',''freqbrk'',''haar'',3,''threshold'',0.2);';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_5');        
        end_call_str    = ',''vonkoch'',''haar'',3,''shannon'');';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_6');        
        end_call_str    = ',''sinper8'',''db1'',7,''shannon'');';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_7');        
        end_call_str    = ',''qdchirp'',''db1'',3,''shannon'');';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_8');        
        end_call_str    = ',''mishmash'',''db1'',3,''shannon'');';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_9');        
        end_call_str    = ',''noisbloc'',''haar'',3,''threshold'',0.2);';
        uimenu(m_loadtst,'Separator','on',...
            'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_10');        
        end_call_str    = ',''noisbump'',''haar'',2,''threshold'',0.2);';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_11');        
        end_call_str    = ',''heavysin'',''haar'',2,''threshold'',0.2);';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_12');        
        end_call_str    = ',''noisdopp'',''haar'',2,''threshold'',0.2);';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_13');        
        end_call_str    = ',''noischir'',''haar'',2,''threshold'',0.2);';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_14');        
        end_call_str    = ',''noismima'',''haar'',2,''threshold'',0.2);';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_15');        
        end_call_str    = ',''linchirp'',''db2'',4,''threshold'',4);';
        uimenu(m_loadtst,'Separator','on',...
            'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_16');        
        end_call_str    = ',''quachirp'',''db3'',4,''threshold'',4);';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        lab = getWavMSG('Wavelet:wp1d2dRF:WP1D_Ex_17');        
        end_call_str    = ',''sumlichr'',''sym3'',4,''threshold'',4);';
        uimenu(m_loadtst,'Label',lab,'Callback',[beg_call_str end_call_str]);
        
        uimenu(m_imp_wrks,...
            'Label',getWavMSG('Wavelet:commongui:Str_ImportSig'),...
            'Tag','Import_Sig', ...
            'Callback',['wp1dmngr(''import_sig'',' str_numwin ');'] ...
            );
        uimenu(m_imp_wrks,...
            'Label',getWavMSG('Wavelet:commongui:Str_ImportDec'), ...
            'Tag','Import_Dec', ...
            'Callback',['wp1dmngr(''import_dec'',' str_numwin ');'] ...
            );
        
        cb_beg = ['wp1dmngr(''exp_wrks'',' str_numwin];        
        uimenu(m_exp_wrks,...
            'Tag','Export_Sig', ...            
            'Label',getWavMSG('Wavelet:commongui:Str_ExportSig'), ...
            'Callback',[cb_beg ',''sig'');'] ...
            );
        uimenu(m_exp_wrks,...
            'Label',getWavMSG('Wavelet:commongui:Str_ExportDec'), ...
            'Tag','Export_Dec', ...            
            'Callback',[cb_beg ',''dec'');'] ...
            );        

        % Begin waiting.
        %---------------
        wwaiting('msg',win_wptool,getWavMSG('Wavelet:commongui:WaitInit'));

        % General graphical parameters initialization.
        %--------------------------------------------
        dx = X_Spacing;  dx2 = 2*dx;
        dy = Y_Spacing;  dy2 = 2*dy;
        d_txt = (Def_Btn_Height-Def_Txt_Height);
        x_frame0   = pos_frame0(1);
        cmd_width  = pos_frame0(3);
        push_width = (cmd_width-3*dx2)/2;

        % Position property of objects.
        %------------------------------
        btn_H_1    = Def_Btn_Height;
        btn_H_2    = 1.5*Def_Btn_Height;
        btn_H_3    = 1.25*Def_Btn_Height;
        ySpace_1   = dy2;
        ySpace_2   = 2*dy2;
        xlocINI    = [x_frame0 cmd_width];
        ybottomINI = pos_win(4)-3.5*btn_H_1-dy2;
        ybottomENT = ybottomINI-(btn_H_1+dy2)-dy;

        bdx      = (cmd_width-1.5*Def_Btn_Width)/2;
        x_left   = x_frame0+bdx;
        y_low      = ybottomENT - 2*(btn_H_1 + 1.5*dy2);
        pos_anal = [x_left, y_low, 1.5*Def_Btn_Width, btn_H_2];

        x_left   = x_frame0+dx2;
        y_low    = y_low - btn_H_2 - ySpace_1;
        pos_comp = [x_left, y_low, push_width , btn_H_2];

        pos_deno    = pos_comp;
        pos_deno(1) = pos_deno(1)+pos_deno(3)+dx2;

        y_low        = y_low-btn_H_3-ySpace_2;
        pos_inittree = [x_left, y_low, push_width, btn_H_3];
        pos_wavtree    = pos_inittree;
        pos_wavtree(1) = pos_inittree(1)+pos_inittree(3)+dx2;

        y_low       = y_low-btn_H_3-dy/4;
        pos_btree   = [x_left, y_low, push_width, btn_H_3];
        pos_blev    = pos_btree;
        pos_blev(1) = pos_btree(1)+pos_btree(3)+dx2;

        y_low         = y_low-btn_H_1-dy;
        wx            = cmd_width-2*dx2-dx;
        pos_t_curtree = [x_left, y_low+d_txt/2, (2*wx)/3, Def_Txt_Height];
        x_leftB       = pos_t_curtree(1)+pos_t_curtree(3)+dx;
        pos_curtree   = [x_leftB, y_low, wx/3, btn_H_1];

        y_low         = y_low-btn_H_1-ySpace_2;
        pos_t_nodlab  = [x_left, y_low+d_txt/2, wx/2, Def_Txt_Height];
        x_leftB       = pos_t_nodlab(1)+pos_t_nodlab(3)+dx;
        pos_nodlab    = [x_leftB, y_low, wx/2, btn_H_1];
 
        y_low         = y_low-btn_H_1-dy;
        pos_t_nodact  = [x_left, y_low+d_txt/2, wx/2, Def_Txt_Height];
        x_leftB       = pos_t_nodact(1)+pos_t_nodact(3)+dx;
        pos_nodact    = [x_leftB, y_low, wx/2, btn_H_1];

        y_low         = y_low-btn_H_1-dy;
        pos_t_nodsel  = [x_left, y_low+d_txt/2, wx/2+2*dx, Def_Txt_Height];
        x_leftB       = pos_t_nodsel(1)+pos_t_nodsel(3);
        pos_nodsel    = [x_leftB, y_low, wx/2-dx, btn_H_1];

        pos_t_nodlab(3) = pos_t_nodlab(3)-dx2;
        pos_nodlab(1)   = pos_nodlab(1)-dx2;
        pos_nodlab(3)   = pos_nodlab(3)+dx2;
        pos_t_nodact(3) = pos_t_nodact(3)-dx2;
        pos_nodact(1)   = pos_nodact(1)-dx2;
        pos_nodact(3)   = pos_nodact(3)+dx2;

        y_low           = pos_nodsel(2)-btn_H_1-ySpace_2;
        pos_txt_full    = [x_left, y_low-btn_H_1/2, wx/3, btn_H_1];

        pos_pus_full    = zeros(4,4);
        xl = pos_txt_full(1)+pos_txt_full(3)+dx;
        pos_pus_full(1,:) = [xl, y_low, wx/3, btn_H_1];
        pos_pus_full(2,:) = pos_pus_full(1,:);
        pos_pus_full(2,2) = pos_pus_full(2,2)-btn_H_1;
        pos_pus_full(3,:) = pos_pus_full(1,:);
        pos_pus_full(3,1) = pos_pus_full(3,1)+pos_pus_full(3,3);
        pos_pus_full(4,:) = pos_pus_full(3,:);
        pos_pus_full(4,2) = pos_pus_full(4,2)-pos_pus_full(4,4);

        y_low         = pos_pus_full(4,2)-btn_H_1-ySpace_1;
        wx            = (cmd_width-2*dx2)/24;
        pos_txt_colm  = [x_left, y_low+d_txt/2, 7*wx, Def_Txt_Height];

        xl            = pos_txt_colm(1)+pos_txt_colm(3);
        y_low         = pos_txt_colm(2);
        pos_pop_colm  = [xl, y_low, 17*wx, btn_H_1];

        % String property of objects.
        %----------------------------
        str_anal      = getWavMSG('Wavelet:commongui:Str_Anal');
        str_btree     = getWavMSG('Wavelet:wp1d2dRF:BestTree');
        str_comp      = getWavMSG('Wavelet:commongui:Str_COMP');
        str_blev      = getWavMSG('Wavelet:wp1d2dRF:BestLev');
        str_deno      = getWavMSG('Wavelet:commongui:Str_DENO');
        str_inittree  = getWavMSG('Wavelet:wp1d2dRF:InitTree');
        str_wavtree   = getWavMSG('Wavelet:wp1d2dRF:WavTree');
        str_t_curtree = getWavMSG('Wavelet:wp1d2dRF:CutTree');
        str_curtree   = '0';
        str_t_nodlab  = getWavMSG('Wavelet:wp1d2dRF:NodLab');
        str_nodlab    = {...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodLab_1'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodLab_2'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodLab_3'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodLab_4'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodLab_5'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodLab_6'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodLab_7')  ...
            };
        str_t_nodact  = getWavMSG('Wavelet:wp1d2dRF:NodAct');
        str_nodact    = {...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodAct_1'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodAct_2'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodAct_3'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodAct_4'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodAct_5'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodAct_6'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_NodAct_7')  ...
            };
        str_t_nodsel  = getWavMSG('Wavelet:wp1d2dRF:Str_SelNod');
        str_nodsel    = getWavMSG('Wavelet:wp1d2dRF:Str_Recons');
        str_txt_full  = getWavMSG('Wavelet:wp1d2dRF:Str_Big');
        str_txt_colm  = getWavMSG('Wavelet:wp1d2dRF:Str_CfsCol');
        str_pop_colm  = {...
            getWavMSG('Wavelet:wp1d2dRF:Str_ColMode_1'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_ColMode_2'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_ColMode_3'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_ColMode_4'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_ColMode_5'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_ColMode_6'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_ColMode_7'), ...
            getWavMSG('Wavelet:wp1d2dRF:Str_ColMode_8')  ...
            };

        % Callback property of objects.
        %------------------------------
        cba_WPOpt      = 'wptreeop';
        cba_anal       = ['wp1dmngr(''anal'',' str_numwin ');'];
        cba_comp       = ['wp1dmngr(''comp'',' str_numwin ');'];
        cba_deno       = ['wp1dmngr(''deno'',' str_numwin ');'];
        cba_btree      = [cba_WPOpt '(''best'',' str_numwin ');'];
        cba_blev       = [cba_WPOpt '(''blvl'',' str_numwin ');'];
        cba_inittree   = [cba_WPOpt '(''restore'',' str_numwin ');'];
        cba_wavtree    = [cba_WPOpt '(''wp2wtree'',' str_numwin ');'];
        cba_nodact     = [cba_WPOpt '(''nodact'',' str_numwin ');'];
        cba_nodlab     = [cba_WPOpt '(''nodlab'',' str_numwin ');'];
        cba_pus_nodsel = [cba_WPOpt '(''recons'',' str_numwin ');'];

        % Command part of the window.
        %============================

        % Data, Wavelet and Level parameters.
        %------------------------------------
        utanapar('create',win_wptool, ...
                 'xloc',xlocINI,'bottom',ybottomINI,...
                 'Enable','off', ...
                 'wtype','dwt'   ...
                 );

        % Entropy parameters.
        %--------------------
        utentpar('create',win_wptool, ...
                 'xloc',xlocINI,'bottom',ybottomENT,'Enable','off' ...
                 );
 
        comFigProp = {'Parent',win_wptool,'Units',win_units};
        comPusProp = [comFigProp,'Style','pushbutton','Enable','Off'];
        comPopProp = [comFigProp,'Style','Popupmenu','Enable','Off'];
        comTxtProp = [comFigProp,'Style','text', ...
           'HorizontalAlignment','left','BackgroundColor',Def_FraBkColor];
        pus_anal = uicontrol(...
            comPusProp{:},       ...
            'Position',pos_anal, ...
            'String',str_anal,   ...
            'Tag',tag_pus_anal,  ...
            'Callback',cba_anal, ...
            'Interruptible','On' ...
            );

        uicontrol(...
            comPusProp{:},       ...
            'Position',pos_comp, ...
            'String',str_comp,   ...
            'Tag',tag_pus_comp,  ...
            'Callback',cba_comp  ...
            );

        uicontrol(...
            comPusProp{:},       ...
            'Position',pos_deno, ...
            'String',str_deno,   ...
            'Tag',tag_pus_deno,  ...
            'Callback',cba_deno  ...
            );

        uicontrol(...
            comPusProp{:},          ...
            'Position',pos_inittree,...
            'String',str_inittree,  ...
            'Tag',tag_inittree,     ...
            'Callback',cba_inittree ...
            );

        uicontrol(...
            comPusProp{:},          ...
            'Position',pos_wavtree, ...
            'String',str_wavtree,   ...
            'Tag',tag_wavtree,      ...
            'Callback',cba_wavtree  ...
            );

        pus_btree = uicontrol(...
            comPusProp{:},        ...
            'Position',pos_btree, ...
            'String',str_btree,   ...
            'Tag',tag_pus_btree,  ...
            'Callback',cba_btree  ...
            );

        uicontrol(...
            comPusProp{:},       ...
            'Position',pos_blev, ...
            'String',str_blev,   ...
            'Tag',tag_pus_blev,  ...
            'Callback',cba_blev  ...
            );

        pop_curtree = uicontrol(...
            comPopProp{:},          ...
            'Position',pos_curtree, ...
            'String',str_curtree,   ...
            'Tag',tag_curtree       ...
            );

        uicontrol(...
            comTxtProp{:},            ...
            'Position',pos_t_curtree, ...
            'String',str_t_curtree    ...
            );

        txt_nodlab = uicontrol(...
            comTxtProp{:},           ...
            'Position',pos_t_nodlab, ...
            'String',str_t_nodlab    ...
            );

        pop_nodlab = uicontrol(...
            comPopProp{:},         ...
            'Position',pos_nodlab, ...
            'String',str_nodlab,   ...
            'CallBack',cba_nodlab, ...
            'Tag',tag_nodlab       ...
            );

        txt_nodact = uicontrol(...
            comTxtProp{:},           ...
            'Position',pos_t_nodact, ...
            'String',str_t_nodact    ...
            );

        pop_nodact = uicontrol(...
            comPopProp{:},         ...
            'Position',pos_nodact, ...
            'String',str_nodact,   ...
            'CallBack',cba_nodact, ...
            'Tag',tag_nodact       ...
            );

        txt_nodsel = uicontrol(...
            comTxtProp{:},           ...
            'Position',pos_t_nodsel, ...
            'String',str_t_nodsel    ...
            );

        pus_nodsel = uicontrol(...
            comPusProp{:},          ...
            'Position',pos_nodsel,  ...
            'String',str_nodsel,    ...
            'Tag',tag_nodsel,       ...
            'Callback',cba_pus_nodsel...
            );

        uicontrol(...
            comTxtProp{:},           ...
            'Position',pos_txt_full, ...
            'String',str_txt_full,   ...
            'Tag',tag_txt_full       ...
            );
        
        tooltip = {...
            getWavMSG('Wavelet:wp1d2dRF:View_DecTree'), ...
            getWavMSG('Wavelet:wp1d2dRF:View_NodAct'), ...
            getWavMSG('Wavelet:wp1d2dRF:View_AnaSig'), ...
            getWavMSG('Wavelet:wp1d2dRF:View_ColCfs')  ...
            };
        pus_full = zeros(1,4);
        for k=1:4
            pus_full(k) = uicontrol(...
                comPusProp{:},        ...
                'Position',pos_pus_full(k,:), ...
                'String',sprintf('%.0f',k),   ...
                'UserData',0,                 ...
                'TooltipString',deblank(tooltip{k}), ...
                'Tag',tag_pus_full{k}       ...
                );
        end

        txt_colm = uicontrol(...
            comTxtProp{:},           ...
            'Position',pos_txt_colm, ...
            'String',str_txt_colm,   ...
            'Tag',tag_txt_colm       ...
            );

        pop_colm = uicontrol(...
            comPopProp{:},          ...
            'Position',pos_pop_colm,...
            'String',str_pop_colm,  ...
            'UserData',1,           ...
            'Tag',tag_pop_colm      ...
            );
        drawnow;

        % Adding colormap GUI.
        %---------------------
        utcolmap('create',win_wptool, ...
                 'xloc',xlocINI, ...
                 'briflag',0, ...
                 'bkcolor',Def_FraBkColor);

        %  Normalisation.
        %----------------
        Pos_Graphic_Area = wfigmngr('normalize',win_wptool, ...
            Pos_Graphic_Area,'On');
        drawnow

        %  Axes Construction.
        %---------------------
        [pos_axe_pack,   pos_axe_tree,   pos_axe_cfs,    ...
         pos_axe_sig,    pos_sli_size,   pos_sli_pos,    ...
         pos_axe_col] =  wpposaxe(win_wptool,1,Pos_Graphic_Area);

        comFigProp = {'Parent',win_wptool,'Units','normalized','Visible','off'};
        WP_Sli_Siz = uicontrol(...
            comFigProp{:},          ...
            'Style','slider',       ...
            'Position',pos_sli_size,...
            'Min',0.5,              ...
            'Max',10,               ...
            'Value',1,              ...
            'UserData',1,           ...
            'Tag',tag_sli_size      ...
            );

        WP_Sli_Pos = uicontrol(...
            comFigProp{:},          ...
            'Style','slider',       ...
            'Position',pos_sli_pos, ...
            'Min',0,                ...
            'Max',1,                ...
            'Value',0,              ...
            'Tag',tag_sli_pos       ...
            );
        drawnow;
        commonProp = {...
           comFigProp{:},                  ...
           'XTickLabelMode','manual',      ...
           'YTickLabelMode','manual',      ...
           'XTicklabel',[],'YTickLabel',[],...
           'XTick',[],'YTick',[],          ...
           'Box','On'                      ...
           }; %#ok<*CCAT>

        axes(commonProp{:}, ...
            'XLim',[-0.5,0.5],       ...
            'YDir','reverse',        ...
            'YLim',[0 1],            ...
            'Position',pos_axe_tree, ...
            'Tag',tag_axe_t_lin      ...
            );

        axes(commonProp{:},'Position',pos_axe_pack,'Tag',tag_axe_pack);
        axes(commonProp{:},'Position',pos_axe_cfs,'Tag',tag_axe_cfs);
        axes(commonProp{:},'Position',pos_axe_sig,'Tag',tag_axe_sig);
        axes(commonProp{:},'Position',pos_axe_col,'Tag',tag_axe_col);

        % Callbacks update.
        %------------------
        utanapar('set_cba_num',win_wptool,[m_files;pus_anal]);
        
        cba_curtree  = [cba_WPOpt '(''cuttree'',' str_numwin ',' ...
                        num2mstr(pop_curtree) ');'];

        cba_colm     = [cba_WPOpt '(''col_mode'',' str_numwin ',' ...
                        num2mstr(pop_colm) ');'];

        cba_sli_siz  = [cba_WPOpt '(''slide_size'',' str_numwin ',' ...
                        num2mstr(WP_Sli_Siz) ','    ...
                        num2mstr(WP_Sli_Pos) ');'];

        cba_sli_pos  = [cba_WPOpt '(''slide_pos'',' str_numwin  ',' ...
                        num2mstr(WP_Sli_Pos) ');'];

        set(pop_curtree,'Callback',cba_curtree);
        set(pop_colm,'Callback',cba_colm);
        set(WP_Sli_Siz,'Callback',cba_sli_siz);
        set(WP_Sli_Pos,'Callback',cba_sli_pos);
        beg_cba = ['wpfullsi(''full'',' str_numwin ','];
        for k=1:4
            cba_pus_full = [beg_cba  sprintf('%.0f',k) ');'];
            set(pus_full(k),'Callback',cba_pus_full);
        end
        drawnow;

		% Add Context Sensitive Help (CSHelp).
		%-------------------------------------
		hdl_WP_TOOLS = [...
				txt_nodlab,pop_nodlab, ...
				txt_nodact,pop_nodact, ...
				txt_nodsel,pus_nodsel, ...
				txt_colm,pop_colm      ...
				];
		wfighelp('add_ContextMenu',win_wptool,pus_btree,'WP_BESTTREE');
		wfighelp('add_ContextMenu',win_wptool,hdl_WP_TOOLS,'WP_TOOLS');		
		%-------------------------------------
		
        % Memory for stored values.
        %--------------------------
        wmemtool('ini',win_wptool,n_InfoInit,nb0_stored);
        wmemtool('ini',win_wptool,n_param_anal,nb1_stored);
        wmemtool('ini',win_wptool,n_wp_utils,nb2_stored);
        wtbxappdata('set',win_wptool,'WP_Tree',[]);
        wtbxappdata('set',win_wptool,'WP_Tree_Saved',[]);
        wmemtool('wmb',win_wptool,n_wp_utils,ind_gra_area,Pos_Graphic_Area);

        % Setting Initial Colormap.
        %--------------------------
        cbcolmap('set',win_wptool,'pal',{'cool',default_nbcolors});

        % End waiting.
        %---------------
        wwaiting('off',win_wptool);

    case 'close'
        fig = varargin{1};
        called_win = wfindobj('figure','UserData',fig);
        delete(called_win);
        ssig_file = ['ssig_rec.' sprintf('%.0f',fig)];
        if exist(ssig_file,'file')==2
            try delete(ssig_file); end %#ok<*TRYNC>
        end

    case 'read'
        %****************************************************%
        %** OPTION = 'read' - read tree (and data struct). **%
        %****************************************************%
        % in2 = hdl fig
        %--------------
        % out1 = tree struct
        % (out2 = data struct - optional)
        %--------------------------------
        fig = varargin{1};
        err = 1-ishandle(fig);
        if err==0
            if ~strcmp(get(fig,'Tag'),mfilename) , err = 1; end
        end
        if err
            errargt(mfilename,getWavMSG('Wavelet:wp1d2dRF:InvalidFig'),'msg');
            return;
        end
        varargout{1} = wtbxappdata('get',fig,'WP_Tree');

    case 'show'
        %**************************************************%
        %** OPTION = 'show' - show tree and data struct. **%
        %**************************************************%
        % in2 = hdl fig
        % in3 = tree struct
        % (in4 = data struct)
        %---------------------
        fig = varargin{1};      
        err = 1-ishandle(fig);
        if err
            wp1dtool; err = 0;
        elseif ~strcmp(get(fig,'Tag'),mfilename)
            err = 1;
        end
        if err
            errargt(mfilename,getWavMSG('Wavelet:wp1d2dRF:InvalidFig'),'msg');
            return;
        end
        wp1dmngr('load_dec',varargin{:});

    otherwise
        errargt(mfilename,getWavMSG('Wavelet:moreMSGRF:Unknown_Opt'),'msg');
        error(message('Wavelet:FunctionArgVal:Invalid_ArgVal'));
end
