%ILWT2  2 次元リフティングウェーブレット逆変換
%
%   ILWT2 は、ユーザが指定する特定のリフトされたウェーブレットに関して、
%   リフティングを使って 2 次元ウェーブレットの再構成を行います。
%
%   X = ILWT2(AD_In_Place,W) は、リフティングウェーブレットの分解で得られた 
%   Approximation 係数と Detail 係数 AD_In_Place を使用して、再構成された
%   行列 X を計算します。
%   W は、リフティングされるウェーブレット名です (LIFTWAVE を参照)。
%
%   X = ILWT2(CA,CH,CV,CD,W) は、リフティングウェーブレットの分解で得られた 
%   Approximation 係数ベクトル CA と Detail 係数ベクトル CH, CV, CD を使用して、
%   再構成された行列 X を計算します。
%
%   X = ILWT2(AD_In_Place,W,LEVEL) または X = ILWT2(CA,CH,CV,CD,W,LEVEL) は、
%   LEVEL のレベルでリフティングウェーブレットの再構成を計算します。
%
%   X = ILWT2(AD_In_Place,W,LEVEL,'typeDEC',typeDEC) または、
%   X = ILWT2(CA,CH,CV,CD,W,LEVEL'typeDEC',typeDEC) は、typeDEC = 'w' 
%   または 'wp' として、LEVEL のレベルでリフティングを使用して、ウェーブレット、
%   またはウェーブレットパケット分解を計算します。
%
%   リフティングされたウェーブレット名の代わりに、関連するリフティング
%   スキーム LS を使用することができます。すなわち、
%     X = ILWT2(...,W,...) の代わりに X = ILWT2(...,LS,...) にします。
%
%   リフティングスキームの詳細は lsinfo と入力してください。
%
%   注意: AD_In_Place または CA,CH,CV,CD がインデックス付きイメージの解析 
%   から得られた場合、それらは m×n の行列になります (トゥルーカラーイメージの
%   解析の場合は、m×n×3 の配列になります)。1 番目の場合、出力配列 X は 
%   m×n の行列で、2 番目の場合、X は m×n×3 の配列になります。
%   イメージ形式の詳細は、IMAGE と IMFINFO 関数のリファレンスページを参照して
%   ください。
%
%   参考 LWT2.


%   Copyright 1995-2008 The MathWorks, Inc.
