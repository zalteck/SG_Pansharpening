% WNOISEST   1次元ウェーブレット係数の雑音の推定
%
% STDC = WNOISEST(C,L,S) は、入力ベクトル S に含まれるレベルに対して、
% Detail 係数の標準偏差の推定を出力します。[C,L] は、入力ウェーブレット
% 分解構造です(WAVEDEC を参照)。
%
% 用いられる推定子は、偏差の中央値の絶対値/ 0.6745で、雑音除去1次元モデルに
% おけるゼロ平均のガウス白色雑音に対して効率的です(THSELECT を参照)。
%
%   参考 THSELECT, WAVEDEC, WDEN.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
