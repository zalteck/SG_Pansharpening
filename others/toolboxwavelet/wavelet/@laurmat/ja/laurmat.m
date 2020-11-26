% LAURMAT   クラス LAURMAT に対するコンストラクタ (Laurent 行列)
%
%   M = LAURMAT(V) は、V に関連する Laurent 行列オブジェクト M を出力します。
%   V は、Laurent 多項式 (LAURPOLY を参照) の (多くても 2 次元の) セル配列、
%   または、通常の行列のセル配列になります。
%
%   例:
%      M1 = laurmat(eye(2,2))
%      Z  = laurpoly(1,1);
%      M2 = laurmat({1 Z;0 1})
%
%   参考 LAURPOLY.


%   Copyright 1995-2007 The MathWorks, Inc.
