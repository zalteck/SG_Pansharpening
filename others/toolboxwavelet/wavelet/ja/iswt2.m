%ISWT2  2 次元逆離散定常ウェーブレット変換
%
%   ISWT2 は、特定の双直交ウェーブレット ('wname'、詳細は WFILTERS を参照)、
%   または、特定の再構成フィルタ (Lo_R と Hi_R) のいずれかを使って多重レベルの 
%   2 次元定常ウェーブレットの再構成を実行します。
%
%   X = ISWT2(SWC,'wname')、X = ISWT2(A,H,V,D,'wname')、または 
%   X = ISWT2(A(:,:,end),H,V,D,'wname') は、多重レベルの定常ウェーブレット
%   分解の構造体 SWC または A,H,V,D] (SWT2 を参照) に基づき行列 X を再構成します。
%
%   X = ISWT2(SWC,Lo_R,Hi_R)、X = ISWT2(A,H,V,D,Lo_R,Hi_R)、または 
%   X = ISWT2(A(:,:,end),H,V,D,Lo_R,Hi_R) に対して、
%   Lo_R は、再構成ローパスフィルタです。
%   Hi_R は、再構成ハイパスフィルタです。
%
%   注意: SWC と (CA, CH, CV, CD) がインデックス付きイメージの解析から
%   得られた場合、X は m×n の行列になります (トゥルーカラーイメージの
%   解析の場合は、m×n×3 配列になります)。
%   イメージ形式の詳細は、IMAGE と IMFINFO 関数のリファレンスページを参照して
%   ください。
%
%   参考 IDWT2, SWT2, WAVEREC2.


%   Copyright 1995-2008 The MathWorks, Inc.
