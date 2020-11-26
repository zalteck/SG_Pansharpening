function P = minus(A,B)
%MINUS Laurent polynomial subtraction.
%   P = MINUS(A,B) returns a Laurent polynomial which is
%   the difference of the two Laurent polynomials A and B.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 19-Mar-2001.
%   Last Revision: 06-May-2008.
%   Copyright 1995-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.3 $  $Date: 2008/05/31 23:32:08 $

P = plus(A,-B);