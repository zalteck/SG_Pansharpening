% WDECENERGY  1 次元複数信号の分解のエネルギーの分布
%
%   [E,PEC,PECFS] = WDECENERGY(DEC) は、各分解信号のエネルギー (L2-ノルム) 
%   を含むベクトル E、各信号の各ウェーブレット成分 (approximation と 
%   detail) に対するエネルギーの割合を含む行列 PEC、各係数に対するエネルギー
%   の割合を含む行列 PECFS を計算します。つぎのようになります。
%       - E(i) は、i 番目の信号のエネルギー (L2-ノルム) です。
%       - PEC(i,1) は、i 番目の信号のレベル DEC.level (MAXLEV) の
%         approximation に対するエネルギーの割合です。
%       - PEC(i,j) は、i 番目の信号のレベル (MAXLEV+1-j) の detail に
%         対するエネルギーの割合です。ここで、j = 2,...,MAXLEV+1 です。
%       - PECFS(i,j) は、i 番目の信号の j 番目の係数に対するエネルギーの
%         割合です。
%
%   [E,PEC,PECFS,IDXSORT,LONGS] = WDECENERGY(DEC,'sort') は、昇順に 
%   (行で) 格納された PECFS とインデックスベクトル IDXSORT を返します。
%   'sort' を 'ascend' で置き換えると、同じ結果が得られます。
%   'sort' を 'descend' で置き換えると、降順に並べられた PECFS が得られます。
%   LONGS は、係数の各ファミリーの長さを含むベクトルです。
%
%   [...] = WDECENERGY(DEC,OPTSORT,IDXSIG) は、IDXSIG ベクトルで与えられた
%   インデックスである信号に対する値を返します。OPTSORT に対して有効な
%   値はつぎの通りです。
%        'none' , 'sort', 'ascend' , 'descend'.
%
%   参考 MDWTDEC, MDWTREC.


%   Copyright 1995-2007 The MathWorks, Inc.
