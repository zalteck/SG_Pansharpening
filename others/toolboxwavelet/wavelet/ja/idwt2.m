%IDWT2  単一レベルの 2 次元逆離散ウェーブレット変換
%
%   IDWT2 は、特定のウェーブレット ('wname', WFILTERS を参照)、または、
%   指定した特定のウェーブレット再構成フィルタ (Lo_R と Hi_R) のいずれかに
%   対して単一レベルの 2 次元ウェーブレット再構成を行います。
%
%   X = IDWT2(CA,CH,CV,CD,'wname') は、ウェーブレット 'wname' を使って、
%   Approximation 係数ベクトル CA と Detail 行列 CH, CV, CD (水平、垂直、対角) 
%   に基づき、単一レベルの再構成 Approximation 係数行列 X を計算します。
%
%   X = IDWT2(CA,CH,CV,CD,Lo_R,Hi_R) は、指定したフィルタを使って上述の
%   再構成を行います。
%   Lo_R は、再構成ローパスフィルタです。
%   Hi_R は、再構成ハイパスフィルタです。
%   Lo_R と Hi_R は、同じ長さでなければなりません。
%
%   SA = size(CA) = size(CH) = size(CV) = size(CD) で、LF がフィルタ長の
%   場合、size(X) = SX が成立します。ここで、DWT 拡張モードが周期的なモードで
%   ある場合、SX = 2*SA です。その他の拡張モードの場合、SX = 2*SA-LF+2 です。
%
%   X = IDWT2(CA,CH,CV,CD,'wname',S) および X = IDWT2(CA,CH,CV,CD,Lo_R,Hi_R,S) 
%   は、IDWT2(CA,CH,CV,CD,'wname') を使って得られる結果の中心部のサイズ S を
%   返します。S は、SX よりも小さくなければなりません。
%
%   X = IDWT2(...,'mode',MODE) は、指定可能な拡張モードで、ウェーブレット
%   再構成の係数を計算します。
%
%   X = IDWT2(CA,[],[],[], ... ) は、Approximation 係数行列 CA をベースに、
%   単一レベルで再構成された Approximation 係数行列 X を返します。
%
%   X = IDWT2([],CH,[],[]、... ) は、水平の Detail 係数行列 CH に基づき、
%   単一レベルで再構成された Detail 係数行列 X を返します。
%
%   X = IDWT2([],[],CV,[], ... ) と X = IDWT2([],[],[],CD, ... ) は同じ結果に
%   なります。
%
%   より一般的に、X = IDWT2(AA,HH,VV,DD, ... ) は、単一のレベルで再構成された
%   行列 X を返します。ここで、AA は CA または [],... となります。
%
%   注意: CA,CH,CV,CD がインデックス付きイメージの解析から得られた場合、それらは 
%   m×n の行列になります (トゥルーカラーイメージの解析の場合は、m×n×3 の配列に
%   なります)。1 番目の場合、出力配列 X は m×n の行列で、2 番目の場合、X は 
%   m×n×3 の配列になります。イメージ形式の詳細は、IMAGE と IMFINFO 関数の
%   リファレンスページを参照して
%   ください。
%
%   参考 DWT2, DWTMODE, UPWLEV2.


%   Copyright 1995-2008 The MathWorks, Inc.
