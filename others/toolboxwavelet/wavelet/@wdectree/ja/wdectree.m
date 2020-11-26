% WDECTREE   クラス WDECTREE に対するコンストラクタ
%
% T = WDECTREE(X,ORDER,DEPTH,WNAME) は、ウェーブレットツリー T を出力します。
% X がベクトルの場合、ツリーは次数 2 です。
% X が行列の場合、ツリーは、次数 4 です。
% DWT の拡張モードは、カレントのモードになります。
%
% T = WDECTREE(X,ORDER,DEPTH,WNAME,DWTMODE) は、DWT の拡張モードとして、
% DTWMODE を使って組み込まれたウェーブレットツリー T を出力します。
%
% T = WDECTREE(X,DEPTH,WNAME,DWTMODE,USERDATA) を使うときは、
% userdata フィールドに設定します。
%
% T は、指定のウェーブレット WNAME を使った、レベル DEPTH の行列 (イメージ) 
% X のウェーブレット分解に対応する WDECTREE オブジェクトです。


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi  12-Feb-2003.
%   Last Revision: 14-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
