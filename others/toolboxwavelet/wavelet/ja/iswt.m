% ISWT   1 次元逆離散定常ウェーブレット変換
%
%   ISWT は、特定の双直交ウェーブレット ('wname'、詳しい情報については 
%   WFILTERS を参照) か、特定の再構成フィルタ  (Lo_R と Hi_R) のいずれかを
%   使って多重レベルの 1 次元定常ウェーブレットの再構成を実行します。
%
%   X = ISWT(SWC,'wname') または X = ISWT(SWA,SWD,'wname')、または、
%   X = ISWT(SWA(end,:),SWD,'wname') は、多重レベルの定常ウェーブレット分解の
%   構造体 SWC または [SWA,SWD] (SWT を参照) を基に、信号 X を再構成します。
%
%   X = ISWT(SWC,Lo_R,Hi_R) または X = ISWT(SWA,SWD,Lo_R,Hi_R)、または、
%   X = ISWT(SWA(end,:),SWD,Lo_R,Hi_R) に対して、
%   Lo_R は、再構成ローパスフィルタです。
%   Hi_R は、再構成ハイパスフィルタです。
%
%   参考 IDWT, SWT, WAVEREC.


%   Copyright 1995-2007 The MathWorks, Inc.
