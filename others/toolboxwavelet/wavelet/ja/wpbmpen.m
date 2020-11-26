% WPBMPEN   ウェーブレットパケット雑音除去用ペナルティ付きスレッシュホールド
%
% THR = WPBMPEN(T,SIGMA,ALPHA) は、雑音除去用のグローバルスレッシュホールド
% THR を出力します。THR は、Birge-Massartにより提唱されたペナルティ法を使って
% ウェーブレットパケット係数選択則から得られます。
%
% T は、雑音除去する信号、またはイメージのウェーブレットパケット分解に
% 対応する wptree オブジェクトです。
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
% ここで、c(k) は、絶対値を大きい順に並べたウェーブレットパケット係数で、
% n は係数の個数です。そして、THR = |c(t*)| です。
%
% WPBMPEN(T,SIGMA,ALPHA,ARG) は、グローバルスレッシュホールドを計算し、
% さらに、3つの曲線をプロットします:  
%   2*SIGMA^2*t*(ALPHA + log(n/t)), sum(c(k)^2,k<=t) and crit(t).
%   
%   参考 WBMPEN, WDEN, WDENCMP, WPDENCMP.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 02-Jul-99.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
