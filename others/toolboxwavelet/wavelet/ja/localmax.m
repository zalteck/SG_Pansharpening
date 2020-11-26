%LOCALMAX  極大値の位置の計算
%
%   行列 X に対して、LOCALMAX は、行に沿って極大値を計算してつなぎます。
%       [Y,I] = LOCALMAX(X,ROWINIT,REGFLAG);
%       [Y,I] = LOCALMAX(X,ROWINIT);
%       [Y,I] = LOCALMAX(X);
%   デフォルト値は、ROWINIT = size(X,1) で REGFLAG = true です。
%
%   初めに、LOCALMAX は、X の行ごとに極大値の位置を計算します。
%   次に、行 (ROWINIT-1) から開始して、LOCALMAX は列に沿って極大値の位置を
%   つなぎます。p0 が行 R0 の極大値の場合、p0 は行 R0+1 の最も近い極大値の
%   位置をつなぎます。
%       Y は以下のような X と同じサイズの行列です。
%       R = ROWINIT の場合、X(ROWINIT,j) が極大値であれば Y(ROWINIT,j) = j 
%       で、それ以外は 0 です。
%       R < ROWINIT の場合、X(R,j) が極大値でなければ Y(R,j) = 0 になります。
%       それ以外の場合、X(R,j) が極大値であれば Y(R,j) = k です。ここで、k 
%       は、X(R+1,k) が極大値の場合、k は j の最も近い位置になるような値です。
%       I は Y の非零のインデックスを含みます。
%
%   REGFLAG = true の場合、S = X(ROWINIT,:) はウェーブレット 'sym4' を使って
%   最初に正則化されます。S の代わりに、レベル 5 の Approximation がアルゴリズム
%   を開始するために使われます。


%   Copyright 1995-2008 The MathWorks, Inc.
