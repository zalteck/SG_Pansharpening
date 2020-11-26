% LWT   1次元リフティングウェーブレット分解
%
% LWT は、ユーザが指定する特定のリフトされたウェーブレットに関して、
% 1次元のリフティングウェーブレット分解を実行します。
%
% [CA,CD] = LWT(X,W) は、ベクトル X のリフティングウェーブレット分解より
% 得られるapproximation係数ベクトル CA とdetail係数ベクトル CD を計算します。
% W は、リフティングされるウェーブレット名です (LIFTWAVE を参照)。
%
% X_InPlace = LWT(X,W) は、approximatio係数とdetail係数を計算します。
% これらの係数は:
%     CA = X_InPlace(1:2:end) と CD = X_InPlace(2:2:end)
% にストアされます。
%
% LWT(X,W,LEVEL) は、LEVEL のレベルでリフティングウェーブレット分解を
% 計算します。
%
% X_InPlace = LWT(X,W,LEVEL,'typeDEC',typeDEC) または、
% [CA,CD] = LWT(X,W,LEVEL,'typeDEC',typeDEC) は、
% typeDEC = 'w' または 'wp' として、LEVEL のレベルでウェーブレット、
% またはウェーブレットパケット分解を計算します。
%
% リフティングされるウェーブレット名ではなく、LWT(X,W,...) の代わりに
% LWT(X,LS,...) として、関連するリフティングスキーム LS を使用することも
% できます。
%
% リフティングスキームについての詳細は lsinfo をタイプしてください。
%
%   参考 ILWT.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 02-Feb-2000.
%   Last Revision: 10-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
