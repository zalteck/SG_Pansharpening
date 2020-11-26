%DETCOEF2  2 次元 Detail 係数の抽出
%
%   D = DETCOEF2(O,C,S,N) は、ウェーブレット分解構造 [C,S] (WAVEDEC2 を参照) 
%   からレベル N の Detail 係数を抽出します。抽出方向は O で設定し、使用できる
%   値は、'h' (水平)、'v' (垂直)、'd' (対角) のいずれかです。
%   N は、1 < = N < = size(S,1)-2 の範囲に入る整数でなければなりません。
%   C と S の詳細は WAVEDEC2 を参照してください。
%
%   [H,V,D] = DETCOEF2('all',C,S,N) は、レベル N の水平 H、垂直 V、対角 D の 
%   Detail 係数を返します。
%
%   D = DETCOEF2('compact',C,S,N) は、レベル N の Detail 係数を行方向に
%   格納して返します。
%
%   DETCOEF2('a',C,S,N) は、DETCOEF2('all',C,S,N) と等価です。
%   DETCOEF2('c',C,S,N) は、DETCOEF2('compact',C,S,N) と等価です。
%
%   注意: C と S がインデックス付きイメージの解析から得られた場合、D は 
%   m×n の行列になります (トゥルーカラーイメージの解析の場合は、m×n×3 の
%   配列になります)。イメージ形式の詳細は、IMAGE と IMFINFO 関数のリファレンス
%   ページを参照してください。
%
%   参考 APPCOEF2, WAVEDEC2.


%   Copyright 1995-2008 The MathWorks, Inc.
