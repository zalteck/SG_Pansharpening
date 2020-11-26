% WVARCHG   分散が変化する点を検出
%
% [PTS_OPT,KOPT,T_EST] = WVARCHG(Y,K,D) は、j = 0, 1, 2,..., K として、
% j の変化点に対する推定された信号 Y の分散の変化する点を計算します。
% 整数 D は、2つの変化点の最小の遅れです。
%
% 整数 KOPT は、変化点 (0 <= KOPT <= K) の修正数です。
% ベクトル PTS_OPT は、対応する変化点を含みます。
% 1 <= k <= K に対して、T_EST(k+1,1:k) は、分散の変化する点の k点の瞬間を
% 含みます。そのとき
% KOPT > 0 の場合、PTS_OPT = T_EST(KOPT+1,1:KOPT) で、それ以外の場合は、
%  PTS_OPT = [] です。
%
% K と D は、1 < K << length(Y) と 1 <= D << length(Y) になるような
% 整数でなければなりません。
% 信号 Y は、ゼロ平均になります。
%   
% WVARCHG(Y,K) は、WVARCHG(Y,K,10) と同じです。
% WVARCHG(Y) は WVARCHG(Y,6,10) と同じです。


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 09-Jun-1999.
%   Last Revision: 07-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
