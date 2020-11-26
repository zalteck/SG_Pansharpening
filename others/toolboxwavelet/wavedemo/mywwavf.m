function [out1,out2] = mywwavf(LB,UB,N,wname)
%MYWWAVF MyWAVE wavelet.
%   [PSI,X] = MYWWAVF(LB,UB,N,W) returns values of the wavelet
%   W in the family Myw, on an N point regular grid in 
%   the interval [LB,UB].
%   The valid values for W are: 'myw3', 'myw4', 'myw5', 'myw6'.
%
%   Output arguments are the wavelet function PSI
%   computed on the grid X.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 01-Oct-2008.
%   Last Revision: 13-Oct-2008.
%   Copyright 1995-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $ $Date: 2008/12/04 23:36:03 $

Num = str2double(wname(end));
load ptpssin1
[out1,out2] = pat2cwav(Y,'polynomial',Num,'continuous');

