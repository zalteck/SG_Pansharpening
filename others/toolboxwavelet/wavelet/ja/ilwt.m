% ILWT   1次元リフティングウェーブレット逆変換
%
% ILWT は、ユーザが指定する特定のリフトされたウェーブレットに関して、
% リフティングを使って1次元ウェーブレットの再構成を行います。
%
% X = ILWT(AD_In_Place,W) は、リフティングウェーブレットの分解により
% 得られたapproximation係数とdetail係数 AD_In_Place を使用して、
% 再構成されたベクトル X を計算します。
% W は、リフティングされるウェーブレット名です (LIFTWAVE を参照)。
%
% X = ILWT(CA,CD,W) は、リフティングウェーブレットの分解により得られた
% approximation係数ベクトル CA とdetail係数ベクトル CD を使用して、
% 再構成されたベクトル X を計算します。
%
% X = ILWT(AD_In_Place,W,LEVEL) または X = ILWT(CA,CD,W,LEVEL) は、
% LEVEL のレベルでリフティングウェーブレットの再構成を計算します。
%
% X = ILWT(AD_In_Place,W,LEVEL,'typeDEC',typeDEC) または、
% X = ILWT(CA,CD,W,LEVEL,'typeDEC',typeDEC) は、
% typeDEC = 'w' または 'wp' として、LEVEL のレベルでリフティングを使用して、
% ウェーブレット、またはウェーブレットパケット分解を計算します。
%
% リフティングされたウェーブレット名の代わりに、関連するリフティング
% スキーム LS を使用することができます。
% すなわち:
%     X = ILWT(...,W,...) ではなく、X = ILWT(...,LS,...) に
% することができます。
%
% リフティングスキームの詳細は、lsinfo とタイプしてください。
%
%   参考 LWT.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 02-Feb-2000.
%   Last Revision: 10-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
