% WTHCOEF2   2次元でウェーブレット係数のスレッシュホールド処理
%
% 'type' = 'h' ('v' または 'd') に対して、NC = WTHCOEF2('type',C,S,N,T,SORH) は、
% ソフトスレッシュホールド(SORH = 's')、または、ハードスレッシュホールド
% (SORH = 'h') のいずれかを使って、ベクトル N と T で定義されるものに対して、
% ウェーブレット分解構造 [C,S] (WAVEDEC2 参照)から得られる水平(垂直、対角)方向の
% 係数を出力します。N は圧縮される Detail レベルで、T は対応するスレッシュホールドです。 
% N と T は、同じ長さです。ベクトル N は、1 < = N(i) < = size(S,1)-2を満たす
% 整数です。 
%
% 'type' = 'h' ('v' または 'd' ) に対して、NC = WTHCOEF2('type',C,S,N) は、
% N の中で定義された Detail レベルの係数をすべてゼロに設定することによって、
% [C,S] から得られた 'type' に定められた方向の係数を出力します。
%
% NC = WTHCOEF2('a',C,S) は、Approximation 係数をゼロに設定することによって
% 得られる係数を出力します。
%
% NC = WTHCOEF2('t',C,S,N,T,SORH) は、ソフトスレッシュホールド(SORH = 's')、
% または、ハードスレッシュホールド(SORH = 'h')のいずれかを使って(WTHRESH 参照)、
% ベクトル T で定義されるものに対して、ウェーブレット分解構造 [C,S] から得られる 
% Detail 係数を出力します。N は、スレッシュホールドが適用される Detail レベルで、
% T は、3つの Detail 方向に適用される対応するスレッシュホールド値です。N と T は、
% 同じ長さです。
%
% [NC,S] は、計算の結果として求まるウェーブレット分解構造です。
%
%   参考 WAVEDEC2, WTHRESH.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
