% WMULDEN  1 次元ウェーブレット多変量ノイズ除去
%
%   [X_DEN,NPC,NESTCOV,DEC_DEN,PCA_Params,DEN_Params] = ...
%               WMULDEN(X,LEVEL,WNAME,NPC_APP,NPC_FIN,TPTR,SORH) または
%   [...] = WMULDEN(X,LEVEL,WNAME,'mode',EXTMODE,NPC_APP,...) は、
%   入力行列 X に対してノイズ除去後の行列 X_DEN を返します。
%   これは、推定ノイズ共分散行列が、対角行列となる一変数ノイズ除去法と
%   Approximation 成分、または再構成後の信号に対して主成分分析による
%   ノイズ除去を組み合わせたものです。
%
%   入力行列 X は、列方向に格納された N の長さの信号 P を含みます。
%   ここで N > P です。
%
%   ウェーブレット分解パラメータ
%   ----------------------------
%   ウェーブレット分解は、分解レベル LEVEL とウェーブレット WNAME を使って
%   行なわれます。EXTMODE は、DWT に対する拡張モードです (デフォルトは 
%   DWTMODE で返されるモードです)。
%
%   MDWTDEC を使って得られる分解 DEC が利用可能な場合、
%   [...] = WMULDEN(X,LEVEL,WNAME,'mode',EXTMODE,NPC_APP)
%   の代わりに  [...] = WMULDEN(DEC,NPC_APP) を使用することが可能です。
%
%   主成分パラメータ NPC_APP と NPC_FIN
%   -----------------------------------
%   入力の選択手法 NPC_APP と NPC_FIN は、それぞれ、ウェーブレット領域の
%   レベル LEVEL における Approximation とウェーブレット再構成後の PCA に
%   対する主成分を選択する方法を定義します。
%
%   NPC_APP (resp. NPC_FIN) が整数の場合、レベル LEVEL における approximation 
%   (またはウェーブレット再構成後の PCA) に対する残りの主成分数を含みます。
%   NPC_XXX は、0 <= NPC_XXX <= P でなければなりません。
%
%   NPC_APP または NPC_FIN = 'kais' (または 'heur') は、Kaiser のルール
%   (または経験則) を使って 残りの主成分数を自動的に選択します。
%      - Kaiser のルールは、すべての固有値の平均を超える固有値に対する
%        成分を保持します。
%      - 経験則は、すべての固有値の和の 0.05 倍を超える固有値に対する
%        成分を保持します。
%   NPC_APP または NPC_FIN = 'none' は、NPC_APP または NPC_FIN = P と等価です。
%
%   ノイズ除去パラメータ TPTR, SORH (WDEN と WBMPEN を参照)
%   -------------------------------------------------------
%   デフォルト値: TPTR = 'sqtwolog' と SORH = 's'。
%   TPTR に対する有効な値はつぎの通りです。
%       'rigrsure','heursure','sqtwolog','minimaxi'
%       'penalhi','penalme','penallo'
%   SORH に対する有効な値は、's' (ソフト) または 'h' (ハード) です。
%
%   出力
%   ----
%   X_DEN は、入力行列 X に対するノイズ除去後の行列です。
%   NPC は、選択した残りの主成分数のベクトルです。
%   NESTCOV 最小の共分散の行列式 (MCD) の推定器を使って得られる推定された
%   ノイズの共分散行列です。
%   DEC_DEN は、X_DEN のウェーブレット分解です。分解の構造体のより詳しい
%   情報については MDWTDEC を参照してください。
%   PCA_Params は、つぎのような構造体です。
%       PCA_Params.NEST = {pc_NEST,var_NEST,NESTCOV}
%       PCA_Params.APP  = {pc_APP,var_APP,npc_APP}
%       PCA_Params.FIN  = {pc_FIN,var_FIN,npc_FIN}
%   ここで: 
%       - pc_XXX は、主成分の P×P の行列です。
%         列は、分散が降順に従って格納されたものです。
%       - var_XXX は、主成分の分散ベクトルです。
%       - NESTCOV は、レベル 1 における detail に対する共分散行列の推定です。
%   DEN_Params は、つぎのような構造体です。
%       DEN_Params.thrVAL は、各レベルに対するスレッシュホールド値を
%       含む長さ LEVEL のベクトルです。
%       DEN_Params.thrMETH は、ノイズ除去手法 (TPTR) の名前を含む文字列です。
%       DEN_Params.thrTYPE は、スレッシュホールド (SORH) のタイプを含む
%       文字です。
%
%   特別な場合
%   ----------
%   [DEC,PCA_Params] = WMULDEN('estimate',DEC,NPC_APP,NPC_FIN) は、
%   ウェーブレット分解 DEC と主成分推定 PCA_Params を返します。
%
%   [X_DEN,NPC,DEC_DEN,PCA_Params] = WMULDEN('execute',DEC,PCA_Params) または
%   [...] = WMULDEN('execute',DEC,PCA_Params,TPTR,SORH) は、以前に計算された
%   主成分推定 PCA_Params を使用します。
%   
%   入力の値 DEC は、X, LEVEL, WNAME で置き換えることが可能です。


%   Copyright 1995-2007 The MathWorks, Inc.
