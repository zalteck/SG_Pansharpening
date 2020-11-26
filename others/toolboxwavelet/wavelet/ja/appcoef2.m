%APPCOEF2  2 次元 Approximation 係数の抽出
%
%   APPCOEF2 は、2 次元信号の Approximation 係数を計算します。
%
%   A = APPCOEF2(C,S,'wname',N) は、ウェーブレット分解構造 [C,S] 
%   (wavedec2 参照) を使って、レベル N の Approximation 係数を計算します。
%   'wname' は、ウェーブレット名を含む文字列です。
%   レベル N は、0 < = N < = size(S,1)-2 を満たす整数です。
%
%   A = APPCOEF2(C,S,'wname') は、最後のレベル size(S,1)-2 の Approximation 
%   係数を抽出します。
%
%   ウェーブレット名を与える代わりに、フィルタを設定することもできます。
%   A = APPCOEF2(C,S,Lo_R,Hi_R) または
%   A = APPCOEF2(C,S,Lo_R,Hi_R,N) の場合、
%   Lo_R は、再構成ローパスフィルタで、
%   Hi_R は、再構成ハイパスフィルタです。
%
%   注意: C と S がインデックス付きイメージの解析から得られた場合、A は 
%   m×n の行列になります (トゥルーカラーイメージの解析の場合は m×n×3 の
%   配列になります)。イメージ形式の詳細は、IMAGE と IMFINFO 関数の
%   リファレンスページを参照してください。
%
%   参考 DETCOEF2, WAVEDEC2.


%   Copyright 1995-2008 The MathWorks, Inc.
