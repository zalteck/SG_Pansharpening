function callback = cwtselect(ax)

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 01-Jul-2010.
%   Last Revision: 31-Jan-2011.
%   Copyright 1995-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2011/02/26 17:42:48 $ 

if feature('HGUsingMATLABClasses')
    callback = @(o,e)changeMOUSE_HG2(o,e,ax);
else
    callback = @(o,e)changeMOUSE_HG1(o,e,ax);
end

function changeMOUSE_HG2(~,e,ax) 

fig = e.HitObject;
% fig = get(ax,'Parent');
changeMOUSE(fig,ax)

function changeMOUSE_HG1(src,~,ax) 

fig = src;
% fig = get(ax,'Parent');
changeMOUSE(fig,ax)


function changeMOUSE(fig,ax)

handles = guihandles(fig);
cwtftbtn('down',fig,ax,handles.Pus_MAN_DEL)

