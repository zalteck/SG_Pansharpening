% WRCOEF   1次元のウェーブレット係数から単一ブランチを再構成
%
% WRCOEF は、ウェーブレット分解構造(C と L)と設定されたウェーブレット
% ('wname' WFILTERS を参照)、または、指定された再構成フィルタ(Lo_R と Hi_R)の
% いずれかを与えて、1次元信号の係数を再構成します。
%
% X = WRCOEF('type',C,L,'wname',N) は、レベル N でウェーブレット分解構造 [C,L] 
% (WAVEDEC を参照)をベースにして再構成される係数ベクトルを計算します。
% 'wname' は、ウェーブレット名を示す文字列です。引数'type'は、再構成される係数が、
% Approximation か('type' = 'a') 、Detail ('type' = 'd')かを設定するものです。
% 'type' = 'a' の場合、N は 0 を設定することもできます。その他の場合、
% N は必ず正でなければなりません。
% レベル N は、N < =  length(L)-2 の範囲の整数です。
%
% X = WRCOEF('type',C,L,Lo_R,Hi_R,N) は、ユーザが設定した再構成フィルタを
% 与えて、上述の計算を行います。
%
% X = WRCOEF('type',C,L,'wname')、または、X = WRCOEF('type',C,L,Lo_R,Hi_R) は、
% 最大レベル N = length(L)-2 の係数を再構成します。
%
%   参考 APPCOEF, DETCOEF, WAVEDEC.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
