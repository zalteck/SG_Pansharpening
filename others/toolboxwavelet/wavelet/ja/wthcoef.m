% WTHCOEF   1次元でウェーブレット係数のスレッシュホールド処理
%
% NC = WTHCOEF('d',C,L,N,P) は、ベクトル N と P で定義された圧縮率を使って
% ウェーブレット分解構造 [C,L] (WAVEDEC を参照)を出力します。N は、圧縮される 
% Detail レベルで、P は、ゼロに置き換えられる係数の割合です。N 及び P は、
% 同じ長さでなければなりません。ベクトル N は、1 < = N(i) < = length(L)-2 を
% 満たさなければなりません。
%
% NC = WTHCOEF('d',C,L,N) は、N の中で設定された Detail レベルのすべての係数を
% ゼロに設定することにより、[C,L] から得られる係数を出力します。
%
% NC = WTHCOEF('a',C,L) は、Approximation 係数をゼロに設定することにより
% 得られる係数を出力します。
%
% NC = WTHCOEF('t',C,L,N,T,SORH) は、ソフトスレッシュホールド(SORH = 's')、
% または、ハードスレッシュホールド(SORH = 'h')のいずれかを使って(WTHRESH 参照)、
% ベクトル N と T で定義されたものに対して、ウェーブレット分解構造 [C,L] から
% 得られた係数を出力します。N はスレッシュホールドされるDetailレベルで、
% T は対応するスレッシュホールドです。N と T は、同じ長さでなければなりません。
%
% [NC,L] は、計算の結果出力されるウェーブレット分解構造です。
%
%   参考 WAVEDEC, WTHRESH.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
