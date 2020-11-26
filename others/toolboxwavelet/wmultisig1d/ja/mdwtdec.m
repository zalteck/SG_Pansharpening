% MDWTDEC  1 次元複数信号のウェーブレット分解
%
%   DEC = MDWTDEC(DIRDEC,X,LEV,WNAME) は、行列 X に対して、WNAME という
%   名前のウェーブレットを使って (DIRDEC = 'r' の場合) X の各行、または
%   (DIRDEC = 'c' の場合) 各列のレベル LEV におけるウェーブレット分解を
%   返します。
%
%   出力 DEC は、つぎのフィールドをもつ構造体です。
%     'dirDec'     : 'r' (行) または 'c' (列)
%     'level'      : DWT 分解のレベル
%     'wname'      : ウェーブレット名
%     'dwtFilters' : 4 つのフィールド LoD, HiD, LoR, HiR をもつ構造体
%     'dwtEXTM'    : DWT 拡張モード (DWTMODE を参照)
%     'dwtShift'   : DWT シフトパラメータ (0 または 1)
%     'dataSize'   : X のサイズ
%     'ca'         : レベル LEV における approximation 係数
%     'cd'         : レベル 1 からレベル LEV までの detail 係数のセル配列
%      係数 cA と cD{k} (k = 1 から LEV) は行列で、DIRDEC = 'r' (または 
%      DIRDEC = 'c') の場合、行方向 (または列方向) に格納されます。
%
%   ウェーブレット名の代わりに、4 つのフィルタを使用します。
%   DEC = MDWTDEC(DIR,X,LEV,LoD,HiD,LoR,HiR)
%
%   MDWTDEC(...,'mode',EXTMODE) は、指定した EXTMODE の拡張モードで
%   ウェーブレット分解を計算します (有効な拡張モードについては DWTMODE 
%   を参照)。
%
%   参考 MDWTREC.


%   Copyright 1995-2007 The MathWorks, Inc.
