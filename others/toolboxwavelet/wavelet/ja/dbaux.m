% DBAUX   Daubechies ウェーブレットフィルタの計算
%
% W = DBAUX(N,SUMW) は、SUM(W) = SUMW を満たす次数 N の 
% Daubechies スケーリングフィルタです。
% N の取り得る値は、N = 1、2、3、..です。
% 
% 注意:
% N をあまり大きくすると不安定になります。
%
% W = DBAUX(N) は、W = DBAUX(N,1) と等価です。
% W = DBAUX(N,0) は、W = DBAUX(N,1) と等価です。
%
%   参考 DBWAVF, WFILTERS.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 13-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
