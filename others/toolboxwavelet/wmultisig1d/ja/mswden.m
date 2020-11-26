% MSWDEN  1 次元複数信号のウェーブレットを使ったノイズ除去
%
%   MSWDEN は、スレッシュホールドを計算し、選択したオプションに従って
%   ウェーブレットを使って 1-D 信号のノイズ除去を行ないます。
%   OUTPUTS = MSWDEN(OPTION,INPUTS) は、一般的なシンタックスで、OPTION に
%   対する有効な値はつぎの通りです。
%           'den' , 'densig' , 'dendec' , 'thr'
%
%   [XD,DECDEN,THRESH] = MSWDEN('den',DEC,METH) または 
%   [XD,DECDEN,THRESH] = MSWDEN('den',DEC,METH,PARAM) は、
%   オリジナルの複数信号行列 X のノイズ除去後の行列 XD を返します。
%   ここで、ウェーブレット分解の構造体は DEC です。
%   XD は、ウェーブレット係数をスレッシュホールド化することで得られます。
%   DECDEN は、XD に関連するウェーブレット分解で (MDWTDEC を参照)、
%   THRESH は、スレッシュホールド値のベクトルです。
%
%   METH は、ノイズ除去手法の名前で、PARAM は、必要な場合、関連する
%   パラメータです (以下を参照)。
%   出力引数を選択するために、'densig' または 'dendec' の OPTION を使用
%   することができます。
%       [XD,THRESH] = MSWDEN('densig', ...) または
%       [DECDEN,THRESH] = MSWDEN('dendec',...)
%
%   同じ方法で、スレッシュホールド値のみを取り出すために、'thr' の 
%   OPTION を使用することができます。
%   THRESH = MSWDEN('thr',DEC,METH) または
%   THRESH = MSWDEN('thr',DEC,METH,PARAM) は、計算したスレッシュホールドを
%   返しますが、ノイズ除去は行ないません。
%   
%   分解構造体の入力引数 DEC は、4 つの引数で置き換えられます。
%   DIRDEC, X, WNAME, LEV。
%       [...] = MSWDEN(OPTION,DIRDEC,X,WNAME,LEV,METH,PARAM).
%   ノイズ除去を実行する、またはスレッシュホールドを計算する前に、
%   複数信号 X は、DIRDEC 方向にウェーブレット WNAME を使ってレベル 
%   LEV で分解されます。
%
%   さらに 3 つのオプション入力を使用できます。
%       [...] = MSWDEN(...,S_OR_H) または
%       [...] = MSWDEN(...,S_OR_H,KEEPAPP) または
%       [...] = MSWDEN(...,S_OR_H,KEEPAPP,IDXSIG)
%       - S_or_H  ('s' または 'h') は、ソフト、またはハードスレッシュ
%         ホールドという意味です (詳細については MSWTHRESH を参照)。
%       - KEEPAPP (true または false)。KEEPAPP が true に等しい場合、
%         approximation 係数は保持されます。
%       - IDXSIG は、初期信号のインデックスを含むベクトル、または
%         文字列 'all' です。
%   デフォルトは、それぞれつぎのようになります: 'h', false, 'all'.
%
%   有効なノイズ除去手法 METH と関連するパラメータ PARAM はつぎの通りです。
%       'rigrsure' Stein Unbiased Risk の原則
%       'heursure' 'rigrsure' オプションの変形
%       'sqtwolog' 一般的なスレッシュホールド sqrt(2*log(.))
%       'minimaxi' ミニマックススレッシュホールド (THSELECT を参照)
%       PARAM は、再スケーリングを行うスレッシュホールドの倍数を定義します。
%          'one' 再スケーリングを行なわない
%          'sln' レベル 1 の係数に基づくレベルノイズの単一の推定を使用して
%                再スケーリングを行う
%          'mln' レベル依存のレベルノイズの推定を使用して再スケーリングを行う
%
%       'penal'     (ペナルティ)       
%       'penalhi'   (高いペナルティ)     ,  2.5 <= PARAM <= 10
%       'penalme'   (中程度のペナルティ) ,  1.5 <= PARAM <= 2.5
%       'penallo'   (低いペナルティ)     ,    1 <= PARAM <= 2
%       PARAM はスパース性のパラメータで、1 <= PARAM <= 10 である必要が
%       あります。ペナルティの手法に対して、制御は行なわれません。
%
%       'man_thr'   (手動の手法)
%       パラメータ PARAM は、つぎのような NbSIG 行 NbLEV 列の行列、
%       または NbSIG 行 (NbLEV+1) 列の行列です。
%         - PARAM(i,j) は、i 番目の信号に対するレベル j の detail 係数の
%          スレッシュホールド (1 <= j <= NbLEV)。
%         - PARAM(i,NbLEV+1) は、i 番目の信号に対する approximation 係数の
%          スレッシュホールド (KEEPAPP が 0 の場合)。
%
%   参考 mdwtdec, mdwtrec, mswthresh, wthresh


%   Copyright 1995-2007 The MathWorks, Inc.
