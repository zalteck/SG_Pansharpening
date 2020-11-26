% MSWCMP  1 次元複数信号のウェーブレットを使った圧縮
%
%   MSWCMP は、スレッシュホールド値を計算し、選択したオプションに従って
%   ウェーブレットを使って 1-D 信号の圧縮を行ないます。
%   OUTPUTS = MSWCMP(OPTION,INPUTS) は、一般的なシンタックスで、OPTION 
%   に対する有効な値はつぎの通りです。
%           'cmp' , 'cmpsig' , 'cmpdec' , 'thr'
%
%   [XC,DECCMP,THRESH] = MSWCMP('cmp',DEC,METH) または  
%   [XC,DECCMP,THRESH] = MSWCMP('cmp',DEC,METH,PARAM) は、オリジナルの
%   複数信号行列 X の圧縮バージョン XC を返します。ここで、ウェーブレット
%   分解の構造体は DEC です。XC は、ウェーブレット係数をスレッシュホールド化
%   することで得られます。DECCMP は、XC に関するウェーブレット分解で
%   (MDWTDEC を参照)、THRESH はスレッシュホールド値のベクトルです。
%
%   METH は圧縮手法の名前で、必要な場合、PARAM は関連するパラメータです
%   (以下を参照)。出力引数を選択するために 'cmpsig', 'cmpdec', 'thr' を
%   使用することが可能です。
%       [XC,THRESH] = MSWCMP('cmpsig', ...) または
%       [DECCMP,THRESH] = MSWCMP('cmpdec',...)
%       THRESH = MSWCMP('thr',...) は、計算したスレッシュホールドを
%       返しますが、圧縮は行なわれません。
%   
%   分解の構造体の入力引数 DEC は、4 つの引数で置き換えられます。
%   DIRDEC, X, WNAME, LEV.
%       [...] = MSWCMP(OPTION,DIRDEC,X,WNAME,LEV,METH) または
%       [...] = MSWCMP(OPTION,DIRDEC,X,WNAME,LEV,METH,PARAM)
%   圧縮を実行する、またはスレッシュホールドを計算する前に、複数信号行列 
%   X は、DIRDEC 方向にウェーブレット WNAME を使ってレベル LEV で分解
%   されます。
%
%   さらに 3 つのオプション入力を使用できます。
%       [...] = MSWCMP(...,S_OR_H) or
%       [...] = MSWCMP(...,S_OR_H,KEEPAPP) or
%       [...] = MSWCMP(...,S_OR_H,KEEPAPP,IDXSIG)
%       - S_OR_H  ('s' または 'h') は、ソフト、またはハードスレッシュ
%         ホールド化という意味です (詳細については MSWTHRESH を参照)。
%       - KEEPAPP (true または false)。KEEPAPP が true に等しい場合、
%         approximation 係数は保持されます。
%       - IDXSIG は、初期信号のインデックスを含むベクトル、または
%         文字列 'all' です。
%   デフォルトは、それぞれつぎのようになります: 'h', false, 'all'
%
%   有効な圧縮手法 METH と関連するパラメータ PARAM はつぎの通りです。
%       'rem_n0'     (0 近傍を削除)        
%       'bal_sn'     (バランススパース性ノルム)
%       'sqrtbal_sn' (バランススパース性ノルム (二乗))
%   
%       'scarce'     (圧縮)       
%       'scarcehi'   (高圧縮) ,  2.5 <= PARAM <= 10
%       'scarceme'   (中圧縮) ,  1.5 <= PARAM <= 2.5
%       'scarcelo'   (低圧縮) ,    1 <= PARAM <= 2
%       PARAM はスパース性パラメータで、1 <= PARAM <= 10 である必要があります。
%       圧縮の方法に対して、制御は行なわれません。
%    
%       'L2_perf'    (エネルギー比)
%       'N0_perf'    (0 係数比)
%       パラメータ PARAM は必要な性能を表す実数です (0 <= PARAM <= 100)。
%    
%       'glb_thr'    (グローバルなスレッシュホールド)
%       パラメータ PARAM は正の実数です。
%   
%       'man_thr'     (手動の手法)
%       パラメータ PARAM は、つぎのような NbSIG 行 NbLEV 列の行列、または 
%       NbSIG 行 (NbLEV+1) 列の行列です。
%        - PARAM(i,j) は、i 番目の信号に対するレベル j の detail 係数の
%          スレッシュホールド (1 <= j <= NbLEV)。
%        - PARAM(i,NbLEV+1) は、i 番目の信号に対する approximation 係数の
%          スレッシュホールド (KEEPAPP が 0 の場合)。
%       ここで、NbSIG は信号の数で、NbLEV は分解のレベル数です。
%
%   参考 mdwtdec, mdwtrec, mswthresh, wthresh


%   Copyright 1995-2007 The MathWorks, Inc.
