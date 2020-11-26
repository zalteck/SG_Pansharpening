%DYADDOWN  2 進ダウンサンプリング
%
%   Y = DYADDOWN(X,EVENODD) は、X がベクトルで、X を 1 つ飛びにダウンサンプル
%   したものを返します。
%   Y は、正の整数 EVENODD の値に依存する X の偶数または奇数のインデックスに
%   なります。
%   EVENODD が偶数の場合、Y(k) = X(2k) です。
%   EVENODD が奇数の場合、Y(k) = X(2k-1) です。
%
%   Y = DYADDOWN(X) は、Y = DYADDOWN(X,0) と等価です。
%
%   Y = DYADDOWN(X,EVENODD,'type') または Y = DYADDOWN(X,'type',EVENODD) 
%   (X は行列) は、'type' = 'c'  （またはそれぞれが 'r' または 'm') の場合、
%   列 (または行、または行と列の双方) を上述のパラメータ EVENODD に沿って
%   削除することで得られる X のバージョンを返します。
%
%   Y = DYADDOWN(X) は、Y = DYADDOWN(X,0,'c') と等価です。
%   Y = DYADDOWN(X,'type') は、Y = DYADDOWN(X,0,'type') と等価です。
%   Y = DYADDOWN(X,EVENODD) は、Y = DYADDOWN(X,EVENODD,'c') と等価です。
%
%             |1 2 3 4|                                |2 4|
%         X = |2 4 6 8| の場合、     DYADDOWN(X,'c') = |4 8| が得られます。
%             |3 6 9 0|                                |6 0|
%
%                       |1 2 3 4|                        |1 3|
%   DYADDOWN(X,'r',1) = |3 6 9 0|  , DYADDOWN(X,'m',1) = |3 9|
%
%   参考 DYADUP.


%   Copyright 1995-2009 The MathWorks, Inc.
