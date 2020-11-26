% SYMAUX   Symletウェーブレットフィルタの計算
%
% Symlet は、"最小で非対称な"Daubechies ウェーブレットです。 
% W = WYMAUX(N,SUMW) は、SUM(W) = SUMW となるような、次数 N の Symlet の
% スケーリングフィルタです。
% N の取り得る値は、
%        N = 1、2、3、...
% です。
%
% 注意 : 
% N をあまり大きくすると不安定になります。
%
% W = SYMAUX(N) は、W = SYMAUX(N,1) と等価です。W = SYMAUX(N,0) は、
% W = SYMAUX(N,1) と等価です。
%
%   参考 SYMWAVF, WFILTERS.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 06-Feb-98.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
