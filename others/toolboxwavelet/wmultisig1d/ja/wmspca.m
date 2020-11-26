% WMSPCA  マルチスケール主成分分析
%
%   [X_SIM,QUAL,NPC,DEC_SIM,PCA_Params] = WMSPCA(X,LEVEL,WNAME,NPC) または
%   [...] = WMSPCA(X,LEVEL,WNAME,'mode',EXTMODE,NPC) は、
%   ウェーブレットベースのマルチスケール PCA から得られる入力行列 X の
%   簡略化された行列 X_SIM を返します。
%
%   入力行列 X は、列方向に格納された長さ N の信号 P を含んでいます。
%   ここで N > P です。
%
%   ウェーブレット分解パラメータ
%   ----------------------------
%   ウェーブレット分解は、分解レベル LEVEL とウェーブレット WNAME を使って
%   行なわれます。EXTMODE は、DWT に対する拡張モードです (デフォルトは 
%   DWTMODE で返されるモードです)。
%
%   MDWTDEC を使って得られる分解 DEC が利用可能な場合、
%   [...] = WMSPCA(X,LEVEL,WNAME,'mode',EXTMODE,NPC)
%   の代わりに [...] = WMSPCA(DEC,NPC) を使用することが可能です。
%
%   主成分パラメータ NPC
%   --------------------
%   NPC がベクトルの場合、LEVEL+2 の長さでなければなりません。実行される
%   各 PCA に対する残りの主成分の数を含みます。
%      - NPC(d) は、1 <= d <= LEVEL に対してレベル d における detail の
%        残りの非中心化の主成分数です。
%      - NPC(LEVEL+1) は、レベル LEVEL における approximations に対する
%        残りの非中心化の主成分数です。
%      - NPC(LEVEL+2) は、ウェーブレット再構成後の PCA に対する残りの
%        主成分数です。
%      NPC は、1 <= d <= LEVEL+2 に対して 0 <= NPC(d) <= P でなければ
%      なりません。
%
%   NPC = 'kais' (または 'heur') の場合、残りの主成分数は、Kaiser の
%   ルール (または経験則) を使って自動的に選択されます。
%      - Kaiser のルールは、すべての固有値の平均を超える固有値に対する
%        成分を保持します。
%      - 経験則は、すべての固有値の和の 0.05 倍を超える固有値に対する
%        成分を保持します。
%   NPC = 'nodet' の場合、detail は "削除" され、approximation が残ります。
%
%   出力
%   ----
%   X_SIM は、行列 X の簡略化された行列です。
%   QUAL は、パーセントで表記で相対平均二乗誤差で与えられる再構成信号の
%   品質を含む長さ P のベクトルです。
%   NPC は、選択した残りの主成分数のベクトルです。
%   DEC_SIM は、X_SIM のウェーブレット分解です。分解の構造体のより詳しい
%   情報については MDWTDEC を参照してください。
%   PCA_Params は、つぎのような LEVEL+2 の長さの構造体配列です。
%     PCA_Params(d).pc = PC。ここで、
%        PC は、主成分の P×P の行列です。
%        列は、分散の降順に従って格納されたものです。
%     PCA_Params(d).variances = VAR。ここで、
%        VAR は、主成分分析の分散ベクトルです。
%     PCA_Params(d).npc = NPC.


%   Copyright 1995-2007 The MathWorks, Inc.
