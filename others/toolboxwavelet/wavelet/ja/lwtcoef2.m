%LWTCOEF2  2 次元 LWT のウェーブレット係数の抽出または再構成
%
%   Y = LWTCOEF2(TYPE,XDEC,LS,LEVEL,LEVEXT) は、リフティングスキーム LS で
%   得られるレベル LEVEL における LWT 分解の XDEC から抽出される係数、または、
%   レベル LEVEXT の再構成された係数を返します。
%   TYPE で設定できる内容は以下のとおりです。
%      - 'a'  Approximation
%      - 'h', 'v', 'd'  水平、垂直、対角のそれぞれの Detail
%      - 'ca' Approximation の係数
%      - 'ch', 'cv', 'cd'  水平、垂直、対角のそれぞれの Detail 係数
%
%   Y = LWTCOEF2(TYPE,XDEC,W,LEVEL,LEVEXT) は、"リフティングされたウェーブレット" 
%   の名前である W を使用して同じ出力を返します。
%
%   注意: XDEC がインデックス付きイメージの解析から得られた場合、m×n の
%   行列になります  (トゥルーカラーイメージの解析の場合は、m×n×3 の配列に
%   なります)。1 番目の場合、出力配列 Y は m×n の行列で、2 番目の場合、
%   Y は m×n×3 の配列になります。
%   イメージ形式の詳細は、IMAGE と IMFINFO 関数のリファレンスページを参照して
%   ください。
%
%   参考 ILWT2, LWT2.


%   Copyright 1995-2008 The MathWorks, Inc.
