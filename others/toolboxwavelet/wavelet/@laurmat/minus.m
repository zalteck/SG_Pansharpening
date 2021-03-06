function M = minus(A,B)
%MINUS Laurent matrices subtraction.
%   M = MINUS(A,B) returns a Laurent matrix which is
%   the difference of the two Laurent matrices A and B.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 29-Mar-2001.
%   Last Revision 06-May-2008.
%   Copyright 1995-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $ $Date: 2008/05/31 23:32:06 $ 

M = plus(A,-B);