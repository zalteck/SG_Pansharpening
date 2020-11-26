function varargout = wguiutils(option,varargin)
%WGUIUTILS Utilities for various wavelet GUIs.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 26-Apr-2005.
%   Last Revision: 20-Nov-2011.
%   Copyright 1995-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.7 $ $Date: 2012/03/01 03:09:53 $

switch option
    %=====================================================================%
    % --- Executes during object creation, after setting all properties.  %
    %=====================================================================%
    case 'EdiPop_CreateFcn'
        hObject = varargin{1};
        def_UIBkCOL = get(0,'DefaultUicontrolBackgroundColor');
        if ispc
            BKCOL = get(hObject,'BackgroundColor');
            if isequal(BKCOL,def_UIBkCOL)
                set(hObject,'BackgroundColor','white');
            end
        elseif strcmpi(get(hObject,'Style'),'listbox')
            set(hObject,'BackgroundColor','white')
        else
            set(hObject,'BackgroundColor',def_UIBkCOL);
        end

    case 'Edi_Inact_CreateFcn'
        hObject = varargin{1};
        ediInActBkColor = mextglob('get','Def_Edi_InActBkColor');
        set(hObject,'BackgroundColor',ediInActBkColor);

    case 'Sli_CreateFcn'
        hObject = varargin{1};
        def_UIBkCOL = get(0,'DefaultUicontrolBackgroundColor');
        if isequal(get(hObject,'BackgroundColor'),def_UIBkCOL)
            sliBkCol = [.9 .9 .9];
        else
            sliBkCol = [.9 .9 .9];
        end
        set(hObject,'BackgroundColor',sliBkCol);
    %=====================================================================%
    %                END Create Functions                                 %
    %=====================================================================%
    
    case 'setAxesTitle'
        axe   = varargin{1};
        label = varargin{2};
        fontSize = mextglob('get','Def_AxeFontSize');
        varargout{1} = title(label,'Parent',axe,...
            'Color','k','FontWeight','normal','Fontsize',fontSize);
        if length(varargin)>2 , set(varargin{3},'Visible','Off'); end
        
    case 'setAxesXlabel'
        axe   = varargin{1};
        label = varargin{2};
        fontSize = mextglob('get','Def_AxeFontSize');
        varargout{1} = xlabel(label,'Parent',axe, ...
            'Color','k','FontWeight','normal','Fontsize',fontSize);
        if length(varargin)>2 , set(varargin{3},'Visible','Off'); end
end
