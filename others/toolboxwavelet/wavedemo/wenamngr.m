function wenamngr(option,fig)
%WENAMNGR Enable settings for GUI examples in the Wavelet Toolbox.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 01-Oct-96.
%   Last Revision: 12-Apr-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.11.4.2 $

if isequal(lower(option),'inactive')
	mode = 3;
	uim = wfindobj(fig,'Type','uimenu');
	uic = wfindobj(fig,'Type','uicontrol');
	switch mode
	    case 1
		enaVal	= 'Inactive';
		hdls	= uic;

	    case 2
		enaVal	= 'Off';
		hdls	= uic;

	    case 3
		enaVal = 'Off';
		% pop = findobj(uic,'Style','popupmenu');
		% pus = findobj(uic,'Style','pushbutton');
		% rad = findobj(uic,'Style','radioButton');
		% chk = findobj(uic,'Style','checkBox');
		% edi = findobj(uic,'Style','edit');
		% sli = findobj(uic,'Style','slider');
		% hdls = [pop ; pus; rad; chk; edi];
		txt	= findobj(uic,'Style','text');
		a = wcommon(uic,txt);
		hdls = uic(~a);
	end	

	set(uim,'Enable','Off');
	set(hdls,'Enable',enaVal);

	% Keeping Messages more visible.
	if mode==2
		txt_msg = wwaiting('handle',fig);
		set(txt_msg,'Enable','on');
	end
end
