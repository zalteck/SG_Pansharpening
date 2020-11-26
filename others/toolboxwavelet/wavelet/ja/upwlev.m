% UPWLEV   1次元のウェーブレット分解の単一レベルの再構成
%
% [NC,NL,CA] = UPWLEV(C,L,'wname') は、ウェーブレット分解構造 [C,L] の
% 単一レベル再構成を計算し、新しいウェーブレット分解構造 [NC,NL] を出力し、
% 最終的に Approximaion 係数ベクトル CA を抽出します。
%
% [C,L] は、レベルn = length(L)-2 での分解で、[NC,NL] は、レベル(n-1)での
% 同じ分解成分で、CA は、レベル n での Approximation 係数ベクトルです。
%
% 'wname' は、ウェーブレット名を含む文字引数です。C は、オリジナルの
% ウェーブレット分解ベクトルで、L は関連した長さの数を要素とするベクトルです
% (ストレージに関する詳細な情報については、WAVEDEC を参照してください)。
%
% ウェーブレット名の代わりに、フィルタを設定することもできます。
% [NC,NL,CA] = UPWLEV(C,L,Lo_R,Hi_R) に対して、Lo_R は、再構成ローパスフィルタで、
% Hi_R は、再構成ハイパスフィルタです。
%
%   参考 IDWT, UPCOEF, WAVEDEC.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
