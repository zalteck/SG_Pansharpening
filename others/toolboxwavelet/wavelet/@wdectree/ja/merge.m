% MERGE   各ノードのデータをマージします(組み替えます)
%
% X = MERGE(T,N,TNDATA) は、ノード N の子ノードで関連づけられたデータを
% 使って、データツリー T のノード N で関連づけられたデータ X を組み替えます。
%
% TNDATA は、TNDATA{k}が N の k 番目の子ノードとなるよう関連づけられた
%   データを含むような、(ORDER x 1) または (1 x ORDER) となるセル配列です。
%
% メソッドは、1次元 (2次元) データに対して IDWT (IDWT2) を使用します。
%
% このメソッドは、DTREE メソッドでオーバーロードされます。

 
%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi  12-Feb-2003.
%   Last Revision: 21-May-2003.
%   Copyright 1995-2011 The MathWorks, Inc.
