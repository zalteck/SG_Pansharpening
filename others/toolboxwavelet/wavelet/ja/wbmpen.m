% WBMPEN   ウェーブレット1次元、または2次元の雑音除去用のペナルティ付き
%          スレッシュホールド
%
% THR = WBMPEN(C,L,SIGMA,ALPHA) は、雑音除去用のグローバルスレッシュホールド
% THR を出力します。THR は、Birge-Massartにより提唱されたペナルティ法を使って
% ウェーブレット係数選択則から得られます。
%
% [C,L] は、雑音除去された信号、またはイメージのウェーブレット分解の
% 構造体です。
%
% SIGMA は、雑音除去モデルの中の平均がゼロのガウス白色雑音の標準偏差です
% (詳細は WNOISEST を参照)。
%
% ALPHA は、ペナルティ項目のためにチューニングされるパラメータで、これは
% 1より大きい実数値でなければなりません。雑音除去された信号、または
% イメージはのウェーブレット表現のスパース性は、ALPHA と共に増加します。
% 通常は、ALPHA = 2 です。
%
% THR は、つぎのように与えられるペナルティ付き規範を t* で最小化します。
%   crit(t) = -sum(c(k)^2,k<=t) + 2*SIGMA^2*t*(ALPHA + log(n/t))
% ここで、c(k) は、絶対値を大きい順に並べたウェーブレット係数で、
% n は係数の個数です。そして、THR = |c(t*)| です。
%
% WBMPEN(C,L,SIGMA,ALPHA,ARG) は、グローバルスレッシュホールドを計算し、
% さらに、3つの曲線をプロットします:  
%   2*SIGMA^2*t*(ALPHA + log(n/t)), sum(c(k)^2,k<=t), crit(t)
%   
%   参考 WDEN, WDENCMP, WPBMPEN, WPDENCMP.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 26-Oct-98.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
