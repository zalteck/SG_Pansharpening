% CHGWDECCFS 1 次元複数信号の分解係数の変更
%
%   DEC = CHGWDECCFS(DEC,'ca',COEFS) は、レベル DEC.level における 
%   approximation 係数を行列 COEFS 内に含まれる係数と置き換えます。
%   COEFS が単一の値 V の場合、係数のすべてが V に置き換えられます。
%    
%   DEC = CHGWDECCFS(DEC,'cd',COEFS,LEV) は、レベル LEV における 
%   detail 係数を行列 COEFS 内に含まれる係数と置き換えます。
%   COEFS が単一の値 V の場合、LEV はレベルのベクトルで、これらの
%   レベルに属している係数のすべてが V に置き換えられます。
%   LEV は 1 <= LEV <= DEC.level でなければなりません。
%
%   DEC = CHGWDECCFS(DEC,'all',CA,CD) は、approximation 係数のすべてと
%   detaiil 係数のすべてを置き換えます。CA は行列で、CD は DEC.level の
%   長さのセル配列でなければなりません。
%
%   DEC = CHGWDECCFS(...,IDXSIG) は、ベクトル IDXSIG で与えられた
%   インデックスの信号に対して係数を置き換えます。初期データが行列 
%   X の行方向 (または列方向) に格納された場合、IDXSIG は関連データの
%   行 (または列) インデックスを含みます。
%
%   COEFS (or CA, or CD) が 1 つの数値 (スカラ) の場合、関連係数のすべてを
%   置き換えます。そうでなければ、COEFS (or CA, or CD) は適切なサイズの
%   行列でなければなりません。
%
%   実際の値 V に対して、DEC = CHGWDECCFS(DEC,'all',V) は、係数のすべてを
%   V に置き換えます。
%
%   参考 MDWTDEC, MDWTREC.


%   Copyright 1995-2007 The MathWorks, Inc.
