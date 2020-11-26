function ScrSIZE = getMonitorSize(num)
%GETMONITORSIZE Monitor Positions for the root object.
%   P = getMonitorSize or P = getMonitorSize(1) returns 
%   the primary monitor position.
%   P = getMonitorSize(2) returns the position of the 
%   secondary monitor (if it exists).
%   P = getMonitorSize('all') returns the primary and 
%   secondary monitors positions. (See Root object properties
%   for more information).

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 15-Dec-2010.
%   Last Revision: 20-Dec-2010.
%   Copyright 1995-2010 The MathWorks, Inc.
%   $Revision: 1.1.8.2 $

if nargin<1 , num = 1; end
v = ScreenUtilities.getMonitorPositions;
if isequal(num,'all') , ScrSIZE = v; return; end
if ~isequal(num,2)
    num = 1;
else
    if size(v,1)<2 , num = 1; end
end
ScrSIZE = v(num,:);
