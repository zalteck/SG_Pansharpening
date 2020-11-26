%LWT  2 次元リフティングウェーブレット分解
%
%   LWT2 は、ユーザが指定する特定のリフトされたウェーブレットに関して、
%   リフティングを使って 2 次元ウェーブレット分解を行います。
%
%   [CA,CH,CV,CD] = LWT2(X,W) は、行列 X のリフティングウェーブレット分解で
%   得られた Approximation 係数行列 CA と Detail 係数行列 CH, CV, CD を計算
%   します。W は、リフティングされるウェーブレット名です (LIFTWAVE を参照)。
%
%   X_InPlace = LWT2(X,LS) は、Approximation 係数と Detail 係数を計算します。
%   これらの係数は以下のように格納されます。
%       CA = X_InPlace(1:2:end,1:2:end)
%       CH = X_InPlace(2:2:end,1:2:end)
%       CV = X_InPlace(1:2:end,2:2:end)
%       CD = X_InPlace(2:2:end,2:2:end)
%
%   LWT2(X,W,LEVEL) は、LEVEL のレベルでリフティングウェーブレット分解を
%   計算します。
%
%   X_InPlace = LWT2(X,W,LEVEL,'typeDEC',typeDEC) または 
%   [CA,CH,CV,CD] = LWT2(X,W,LEVEL,'typeDEC',typeDEC) は、typeDEC = 'w' 
%   または 'wp' として、LEVEL のレベルでリフティングを使ってウェーブレット、
%   または、ウェーブレットパケット分解を計算します。
%
%   リフティングされたウェーブレット名の代わりに、関連するリフティング
%   スキーム LS を使用することができます。すなわち、
%     LWT2(X,W,...) の代わりに LWT2(X,LS,...) を使用します。
%
%   リフティングスキームの詳細は lsinfo と入力してください。
%
%   注意: X がインデックス付きイメージを表す場合、X も同様に出力配列 CA, CH, 
%   CV, CD または X_InPlace も m×n の行列になります。X がトゥルーカラーイメージ
%   を表す場合、これらの変数は m×n×3 の配列になります。これらの配列は、3 番目の
%   次元に沿って連結された (赤、緑、青の色平面を表す) 3 つの m×n の行列からなり
%   ます。イメージ形式の詳細は、IMAGE と IMFINFO 関数のリファレンスページを参照
%   してください。
%
%   参考 ILWT2.


%   Copyright 1995-2008 The MathWorks, Inc.
