function x = wdtrec(t,node)
%WDTREC Wavelet decomposition tree reconstruction.
%   X = WDTREC(T) returns the reconstructed vector
%   corresponding to a wavelet tree T.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 13-Mar-2003.
%   Last Revision: 06-Feb-2011.
%   Copyright 1995-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $  $Date: 2011/02/26 17:43:39 $ 

% Check arguments.
error(nargoutchk(0,1,nargout,'struct'))
error(nargchk(1,2,nargin,'struct'))
if nargin==1, node = 0; end

% Get node coefficients.
[t,x] = nodejoin(t,node); %#ok<ASGLU>
% if ndims(x)>2 && node==0
%     x(x<0) = 0;
%     x = uint8(x);    
% end
