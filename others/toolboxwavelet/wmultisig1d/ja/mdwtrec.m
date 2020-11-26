% MDWTREC  1 次元複数信号のウェーブレット再構成
%
%   X = MDWTREC(DEC) は、ウェーブレット分解の構造体 DEC から信号の
%   オリジナル行列を返します (MDWTDEC を参照)。
%
%   X = MDWTREC(DEC,IDXSIG) は、ベクトル IDXSIG で与えられたインデックスに
%   対応する信号を再構成します。
%
%   Y = MDWTREC(DEC,TYPE,LEV) は、レベル LEV における detail または 
%   approximation 係数を抽出、または再構成します (TYPE の値に依存)。
%       - TYPE が 'cd' または 'ca' の場合、レベル LEV の係数が抽出されます。
%       - TYPE が 'd' または 'a' の場合、レベル LEV の係数が再構成された
%         信号が出力されます。
%   LEV に対する最大値は LEVDEC = DEC.level です。
%
%   TYPE が 'a' または 'ca' の場合、LEV は 0 <= LEV <= LEVDEC となる
%   ような整数でなければなりません。
%
%   A  = MDWTREC(DEC,'a') は、A  = MDWTREC(DEC,'a',LEVDEC) と等価です。
%
%   D  = MDWTREC(DEC,'d') は、X = A + D となるように、すべての detail 
%   の和を含む行列を返します。
%
%   CA = MDWTREC(DEC,'ca') は、CA = MDWTREC(DEC,'ca',LEVDEC) と等価です。
%
%   CD = MDWTREC(DEC,'cd',MODE) は、detail 係数のすべてを含む行列を
%   返します。
%   CFS = MDWTREC(DEC,'cfs',MODE) は、係数のすべてを含む行列を返します。
%
%   DEC.dirDec が 'r' (または 'c') の場合、連結は行方向 (または列方向) 
%   に行なわれます。
%   MODE = 'descend' (または 'ascend') の場合、係数はレベル LEVDEC から
%   1 (またはレベル 1 からレベル LEVDEC) まで "連結" されます。
%   入力の MODE が省略された場合、デフォルトは MODE = 'descend' です。
%
%   Y = MDWTREC(...,IDXSIG) は、ベクトル IDXSIG で与えられたインデックスの
%   信号に対する detail または approximation 係数を抽出、または再構成
%   します。
%
%   参考 MDWTDEC.


%   Copyright 1995-2007 The MathWorks, Inc.
