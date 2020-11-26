% DETCOEF   1次元 Detail 係数の抽出
%
% D = DETCOEF(C,L,N) は、ウェーブレット分解構造 [C,L](WAVEDEC を参照)から
% レベル N での Detail 係数を抽出します。
% レベル N は、1 < =  N < =  length(L)-2 の範囲に入る整数でなくてはなりません。
%
% D = DETCOEF(C,L) は、最終レベル値 n = length(L)-2 での Detail 係数を抽出します。
% 
%   参考 APPCOEF, WAVEDEC.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 22-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
