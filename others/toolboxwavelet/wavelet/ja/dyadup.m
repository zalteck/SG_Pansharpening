%DYADUP  2 進アップサンプリング
%
%   DYADUP は、ウェーブレット再構成アルゴリズムの中で、非常に有効な 0 を
%   パディングする単純な方法を実行します。
%
%   Y = DYADUP(X,EVENODD) (X はベクトル) は、0 を挿入することで得られる
%   ベクトル X の拡張されたコピーを返します。正の整数 EVENODD の値に依存して、
%   0 が Y の偶数または奇数のどちらかのインデックス要素として 挿入されるかが
%   決まります。
%   EVENODD が偶数の場合、Y(2k-1) = X(k), Y(2k) = 0 です。EVENODD が奇数の場合、
%   Y(2k-1) = 0   , Y(2k) = X(k) です。
%
%   Y = DYADUP(X) は、Y = DYADUP(X,1) と等価です。
%
%   Y = DYADUP(X,EVENODD,'type') または Y = DYADUP(X,'type',EVENODD) 
%   (X は行列) は、'type' = 'c' (または、それぞれ 'r' または 'm') の場合、
%   0 の列 (または行、または行と列の双方) を上述のパラメータ EVENODD に
%   沿って挿入することで得られる X のバージョンを返します。
%
%   Y = DYADUP(X) は、Y = DYADUP(X,1,'c') と等価です。
%   Y = DYADUP(X,'type') は、Y = DYADUP(X,1,'type') と等価です。
%   Y = DYADUP(X,EVENODD) は、Y = DYADUP(X,EVENODD,'c') と等価です。
%
%            |1 2|                              |0 1 0 2 0|
%        X = |3 4| の場合、     DYADUP(X,'c') = |0 3 0 4 0| が得られます。
%
%                     |1 2|                      |1 0 2|
%   DYADUP(X,'r',0) = |0 0|  , DYADUP(X,'m',0) = |0 0 0|
%                     |3 4|                      |3 0 4|
%
%   参考 DYADDOWN.


%   Copyright 1995-2009 The MathWorks, Inc.
