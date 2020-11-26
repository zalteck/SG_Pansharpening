%WFUSIMG  2 つのイメージのフュージョン
%
%   XFUS = WFUSIMG(X1,X2,WNAME,LEVEL,AFUSMETH,DFUSMETH) は、2 つのオリジナル
%   イメージ X1 と X2 のフュージョンで得られる融合したイメージ XFUS を返します。
%   各フュージョンの方法は、AFUSMETH と DFUSMETH で定義され、ウェーブレット 
%   WNAME を使用して、レベル LEVEL において X1 と X2 を分解したものを後述する
%   特定の方法で融合します。
%
%   X1 と X2 は同じサイズ (イメージのリサイズは WEXTEND を参照) で、m×n の
%   行列のインデックス付きイメージででなければなりません (トゥルーカラー
%   イメージの場合は m×n×3 の配列になります)。イメージ形式の詳細は、
%   IMAGE と IMFINFO 関数のリファレンスページを参照してください。
%
%   AFUSMETH と DFUSMETH は、それぞれ Approximation と Detail に対する
%   フュージョンの方法を定義します。
%
%   [XFUS,TXFUS,TX1,TX2] = WFUSIMG(X1,X2,WNAME,LEVEL,AFUSMETH,DFUSMETH) は、
%   行列 XFUS に加えて、XFUS, X1, X2 のそれぞれに関連するクラス WDECTREE の 
%   3 つのオブジェクトを返します (@WDECTREE を参照)。
%
%   WFUSIMG(X1,X2,WNAME,LEVEL,AFUSMETH,DFUSMETH,FLAGPLOT) は、オブジェクト 
%   TXFUS,TX1,TX2 もプロットします。
%
%   Fusmeth は、AFUSMETH または DFUSMETH を示します。利用可能なフュージョンの
%   方法は以下のとおりです。
%
%    - シンプルな場合。Fusmeth は、'max', 'min', 'mean', 'img1', 'img2', 
%      'rand' のいずれかになります。これは、X1 と X2 の各要素から得られた 
%      2 つの Approximation、または Detail 構造を、最大、最小、平均、
%      最初の要素、2 番目の要素、あるいは、ランダムに選択した要素を取る
%      ことで融合します。
%
%    - パラメータ依存の場合。Fusmeth は、以下のいずれかの形式になります。
%      Fusmeth = struct('name',nameMETH,'param',paramMETH) ここで、nameMETH 
%      は以下のいずれかになります。
%         - 'linear'
%         - 'UD_fusion' : 上から下方向へのフュージョン
%         - 'DU_fusion' : 下から上方向へのフュージョン
%         - 'LR_fusion' : 左から右方向へのフュージョン
%         - 'RL_fusion' : 右から左方向へのフュージョン
%         - 'UserDEF'   : ユーザ定義のフュージョン
%   これらのオプションと対応するパラメータ paramMETH の詳細は、WFUSMAT を
%   参照してください。
%
%   例:
%    load mask; X1 = X;
%    load bust; X2 = X;
%    [XFUS,TXFUS,TX1,TX2] = wfusimg(X1,X2,'db2',5,'max','max','plot');


%   Copyright 1995-2008 The MathWorks, Inc.
