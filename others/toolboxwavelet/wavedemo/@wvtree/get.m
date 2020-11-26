function varargout = get(t,varargin)
%GET Get WVTREE object field contents.
%   [FieldValue1,FieldValue2, ...] = ...
%       GET(T,'FieldName1','FieldName2', ...) returns
%   the contents of the specified fields for the WVTREE
%   object T.
%   For the fields, which are objects or structures, you
%   may get subfield contents (see DTREE/GET).
%
%   [...] = GET(T) returns all the field contents of T.
%
%   The valid choices for 'FieldName' are:
%     'dummy'   : Not Used
%     'wtree'   : wtree parent object
%
%   Or fields in WTREE parent object:
%     'dwtMode' : DWT extension mode
%     'wavInfo' : Structure (wavelet infos)
%        'wavName' - Wavelet Name
%        'Lo_D'    - Low Decomposition filter
%        'Hi_D'    - High Decomposition filter
%        'Lo_R'    - Low Reconstruction filter
%        'Hi_R'    - High Reconstruction filter
%
%   Type help dtree/get for more information on other
%   valid choices for 'FieldName'.
%
%   See also DTREE/READ, DTREE/SET, DTREE/WRITE.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 09-Oct-1998.
%   Last Revision: 15-Mar-2008.
%   Copyright 1995-2008 The MathWorks, Inc.
%   $Revision: 1.5.4.3 $  $Date: 2008/04/21 16:32:23 $ 


nbin = length(varargin);
if nbin==0 , varargout = struct2cell(struct(t))'; return; end
varargout = cell(nbin,1);
okArg = ones(1,nbin);
for k=1:nbin
    field = varargin{k};
    try
      varargout{k} = t.(field);
    catch ME
      varargout{k} = get(t.wtree,field);
      if isequal(varargout{k},'errorWTBX') , okArg(k) = 0; end
    end    
end
notOk = find(okArg==0);
if ~isempty(notOk)
    [varargout{notOk}] = getwtbo(t,varargin{notOk});
end
