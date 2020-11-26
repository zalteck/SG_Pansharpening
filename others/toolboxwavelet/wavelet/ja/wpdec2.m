%WPDEC2  2 次元ウェーブレットパケット分解
%
%   T = WPDEC2(X,N,'wname',E,P) は、特定のウェーブレット ('wname' については 
%   WFILTERS を参照) でレベル N における行列のウェーブレットパケット分解に
%   対応する wptree オブジェクト T を返します。
%   E は、以下のエントロピーのタイプを含む文字列です (WENTROPY 参照)。 
%   E = 'shannon', 'threshold', 'norm', 'log energy', 'sure, 'user'
%   P は、オプションパラメータです。
%        'shannon' または 'log energy' : P は用いられません。
%        'threshold' または 'sure'     : P はスレッシュホールド値です (0 < = P)。
%        'norm' :P はべき数です (1 <= P)。
%        'user' :P はユーザ定義の関数名を含む文字列です。
%
%   [T,D] = WPDEC2(X,N,'wname') は、
%   [T,D] = WPDEC2(X,N,'wname','shannon') と等価です。
%
%   注意: X がインデックス付きイメージで表される場合、X は m×n の行列になります。
%   X がトゥルーカラーイメージで表される場合、3 番目の次元に沿って連結された 
%   3 番目の m×n 行列 (赤、緑、青の色平面を表す) からなる m×n×3 の配列になります。
%   イメージ形式の詳細は、IMAGE と IMFINFO 関数のリファレンスページを参照して
%   ください。
%
%   参考 WAVEINFO, WENTROPY, WPDEC, WPREC, WPREC2.


%   Copyright 1995-2008 The MathWorks, Inc.
