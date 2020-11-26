% WTHRMNGR   スレッシュホールド設定と取り扱い
%
% THR = WTHRMNGR(OPTION,METHOD,VARARGIN) は、グローバルスレッシュホールド、
% または、OPTION に依存したレベルのスレッシュホールドのいずれかを出力します。
% 入力 VARARGIN は、OPTION と METHOD 値に依存します。
%
% この関数は、雑音除去や圧縮ツール (コマンドラインM-ファイルやGUIツール) に
% 対するMATLABのWavelet Toolboxを通して、使用するスレッシュホールドを出力します 
%
% METHOD パラメータに対するオプションはつぎになります:
%
%   - 'scarcehi'            (パラメータ M の前もって設定した値 
%                            high をもつ WDCBM または WDCBM2 を参照)
%   - 'scarceme'            (パラメータ M の前もって設定した値
%                            medium をもつ WDCBM または WDCBM2 を参照)
%   - 'scarcelo'            (パラメータ M の前もって設定した値
%                            low をもつ WDCBM または WDCBM2 を参照)
%
%   - 'sqtwolog'            (THSELECT のオプション 'sqtwolog' を参照。
%                            WDEN も参照)
%   - 'sqtwologuwn'         (THSELECT のオプション 'sqtwolog' を参照。
%                            WDEN オプションの 'sln' も参照)
%   - 'sqtwologswn'         (THSELECT のオプション 'sqtwolog' を参照。
%                            WDEN オプションの 'mln' も参照)
%   - 'rigrsure'            (THSELECT のオプション 'rigrsure' を参照。
%                            WDEN も参照)
%   - 'heursure'            (THSELECT のオプション 'heursure' を参照。
%                            WDEN も参照)
%   - 'minimaxi'            (THSELECT のオプション 'minimaxi' を参照。
%                            WDEN も参照)
%
%   - 'penalhi'             (パラメータ ALPHA の hith をもつ
%                            WBMPEN または WPBMPEN を参照)
%   - 'penalme'             (パラメータ ALPHA の medium をもつ
%                            WBMPEN または WPBMPEN を参照 )
%   - 'penallo'             (パラメータ ALPHA の swith low をもつ 
%                            WBMPEN または WPBMPEN を参照).
%
%   - 'rem_n0'              このオプションは、0に近いスレッシュホールドを
%                           出力します。よく使用する THR 値は、
%                           median(abs(coefficients) です)
%
%   - 'bal_sn'              このオプションは、残ったエネルギーとゼロにした
%                           エネルギーの割合が同じくなるようなスレッシュ
%                           ホールドを出力します。
%
%   - 'sqrtbal_sn'          このオプションは、残ったエネルギーの割合と
%                           ゼロの数が同じになるような値の平方根に等しくなる
%                           スレッシュホールドを出力します。
%
%   ################################
%   離散ウェーブレット1-Dオプション:
%   ################################
%
%    グローバルスレッシュホールドを使った圧縮:
%    -----------------------------------------
%    X は圧縮される信号で、[C,L] は圧縮された信号のウェーブレット分解構造です。
%     THR = WTHRMNGR('dw1dcompGBL','rem_n0',X) 
%     THR = WTHRMNGR('dw1dcompGBL','bal_sn',C,L)
%
%    レベル依存のスレッシュホールドを使った圧縮:
%    --------------------------------------------
%    X は圧縮される信号で、[C,L] は圧縮された信号のウェーブレット分解構造です。
%    ALFA はスパース性パラメータです(WDCBM を参照)。
%
%     THR = WTHRMNGR('dw1dcompLVL','scarcehi',C,L,ALFA)
%            ALFA は、2.5 < ALFA < 10 でなければなりません。
%     THR = WTHRMNGR('dw1dcompLVL','scarceme',C,L,ALFA)
%            ALFA は、1.5 < ALFA < 2.5 でなければなりません。
%     THR = WTHRMNGR('dw1dcompLVL','scarcelo',C,L,ALFA)
%            ALFA は、1 < ALFA < 2 でなければなりません。
%
%    レベル依存のスレッシュホールドを使った雑音除去
%    ----------------------------------------------
%    [C,L] は雑音除去される信号のウェーブレット分解構造で、SCAL は乗算型の
%    スレッシュホールドの再スケーリング (WDEN を参照) を定義します。
%    ALFA はスパース性パラメータです (WBMPEN を参照)。
%
%     THR = WTHRMNGR('dw1ddenoLVL','sqtwolog',C,L,SCAL)
%     THR = WTHRMNGR('dw1ddenoLVL','rigrsure',C,L,SCAL)
%     THR = WTHRMNGR('dw1ddenoLVL','heursure',C,L,SCAL)
%     THR = WTHRMNGR('dw1ddenoLVL','minimaxi',C,L,SCAL)
%
%     THR = WTHRMNGR('dw1ddenoLVL','penalhi',C,L,ALFA)
%            ALFA は、2.5 < ALFA < 10 でなければなりません。
%     THR = WTHRMNGR('dw1ddenoLVL','penalme',C,L,ALFA)
%            ALFA は、1.5 < ALFA < 2.5 でなければなりません。
%     THR = WTHRMNGR('dw1ddenoLVL','penallo',C,L,ALFA)
%            ALFA は、1 < ALFA < 2 でなければなりません。
%
%   ##########################################    
%   離散Stationaryウェーブレット1-Dオプション:
%   ##########################################    
%
%    レベル依存スレッシュホールドを使った雑音除去:
%    ---------------------------------------------
%    SWTDEC は、雑音を除去する信号のStationaryウェーブレット分解構造です。
%    SCAL は、乗算型のスレッシュホールドの再スケーリング (WDEN を参照) を
%    定義し、ALFA はスパース性パラメータです (WBMPEN を参照)。
%     THR = WTHRMNGR('sw1ddenoLVL',METHOD,SWTDEC,SCAL)
%     THR = WTHRMNGR('sw1ddenoLVL',METHOD,SWTDEC,ALFA)
%     METHOD 用のオプションは、'dw1ddenoLVL' の場合と同じです。
%
%   ################################# 
%   離散ウェーブレット2-D オプション:
%   #################################  
%
%    グローバルスレッシュホールドを使った圧縮:
%    -----------------------------------------
%    X は圧縮されるイメージで、[C,S] は圧縮されたイメージのウェーブレット
%    分解構造です。
%     THR = WTHRMNGR('dw2dcompGBL','rem_n0',X)
%     THR = WTHRMNGR('dw2dcompGBL','bal_sn',C,S)
%     THR = WTHRMNGR('dw2dcompGBL','sqrtbal_sn',C,S)
%
%    レベル依存のスレッシュホールドを使った圧縮:
%    -------------------------------------------
%    X は圧縮されるイメージで、[C,S] は圧縮されたイメージのウェーブレット
%    分解構造です。
%    ALFA はスパース性パラメータです (WDCBM2 を参照)。
%
%     THR = WTHRMNGR('dw2dcompLVL','scarcehi',C,S,ALFA)
%            ALFA must be such that 2.5 < ALFA < 10
%     THR = WTHRMNGR('dw2dcompLVL','scarceme',C,S,ALFA)
%            ALFA must be such that 1.5 < ALFA < 2.5
%     THR = WTHRMNGR('dw2dcompLVL','scarcelo',C,S,ALFA)
%            ALFA must be such that 1 < ALFA < 2
%
%    レベル依存のスレッシュホールドを使った雑音除去:
%    -----------------------------------------------
%    [C,S] は雑音除去されるイメージのウェーブレット分解構造です。
%    SCAL は乗算型のスレッシュホールドの再スケーリング (WDEN を参照) を定義し、
%    ALFA はスパース性パラメータです (WBMPEN を参照)。
%
%     THR = WTHRMNGR('dw2ddenoLVL','penalhi',C,S,ALFA)
%            ALFA は 2.5 < ALFA < 10 でなければなりません。
%     THR = WTHRMNGR('dw2ddenoLVL','penalme',C,S,ALFA)
%            ALFA は 1.5 < ALFA < 2.5 でなければなりません。
%     THR = WTHRMNGR('dw2ddenoLVL','penallo',C,S,ALFA)
%            ALFA は 1 < ALFA < 2 でなければなりません。
%
%     THR = WTHRMNGR('dw2ddenoLVL','sqtwolog',C,S,SCAL)
%     THR = WTHRMNGR('dw2ddenoLVL','sqrtbal_sn',C,S)
%
%   ##########################################  
%   離散Stationaryウェーブレット2-Dオプション:
%   ##########################################  
%
%    レベル依存のスレッシュホールドを使った雑音除去:
%    -----------------------------------------------
%    SWTDEC は雑音を除去される信号のStationaryウェーブレット分解構造です。
%    SCAL は乗算型のスレッシュホールドの再スケーリングです (WDEN を参照)。
%    ALFA はスパース性パラメータです (WBMPEN を参照)。
%     THR = WTHRMNGR('sw2ddenoLVL',METHOD,SWTDEC,SCAL)
%     THR = WTHRMNGR('sw2ddenoLVL',METHOD,SWTDEC,ALFA)
%     METHOD 用のオプションは、'dw2ddenoLVL' の場合と同じです。
%
%   ########################################  
%   離散ウェーブレットパケット1-Dオプション:
%   ######################################## 
% 
%    グローバルスレッシュホールドを使った圧縮:
%    -----------------------------------------
%    X は圧縮される信号で、WPT は圧縮される信号のウェーブレットパケット
%    分解構造です。
%     THR = WTHRMNGR('wp1dcompGBL','bal_sn',WPT)
%     THR = WTHRMNGR('wp1dcompGBL','rem_n0',X)
%
%    グローバルスレッシュホールドを使った雑音除去:
%    ---------------------------------------------
%    WPT は雑音除去される信号のウェーブレットパケット分解構造です。
%     THR = WTHRMNGR('wp1ddenoGBL','sqtwologuwn',WPT)
%     THR = WTHRMNGR('wp1ddenoGBL','sqtwologswn',WPT)
%     THR = WTHRMNGR('wp1ddenoGBL','bal_sn',WPT)
%
%     THR = WTHRMNGR('wp1ddenoGBL','penalhi',WPT)
%            ALFA = 6.25 を使って WPBMPEN を参照してください。
%     THR = WTHRMNGR('wp1ddenoGBL','penalme',WPT)
%            ALFA = 2 を使って WPBMPEN を参照してください。
%     THR = WTHRMNGR('wp1ddenoGBL','penallo',WPT)
%            ALFA = 1.5 を使って WPBMPEN を参照してください。
%
%   ########################################  
%   離散ウェーブレットパケット2-Dオプション:
%   ######################################## 
% 
%    グローバルスレッシュホールドを使った圧縮:
%    -----------------------------------------
%    X は圧縮されるイメージで、WPT は圧縮されるイメージのウェーブレット
%    パケット分解構造です。
%     THR = WTHRMNGR('wp2dcompGBL','bal_sn',WPT)
%     THR = WTHRMNGR('wp2dcompGBL','rem_n0',X)
%     THR = WTHRMNGR('wp2dcompGBL','sqrtbal_sn',WPT)
%
%    グローバルスレッシュホールドを使った雑音除去:
%    ---------------------------------------------
%    WPT は雑音除去されるイメージのウェーブレットパケット分解構造です。
%     THR = WTHRMNGR('wp2ddenoGBL','sqtwologuwn',WPT)
%     THR = WTHRMNGR('wp2ddenoGBL','sqtwologswn',WPT)
%     THR = WTHRMNGR('wp2ddenoGBL','sqrtbal_sn',WPT)
%
%     THR = WTHRMNGR('wp2ddenoGBL','penalhi',WPT)
%            ALFA = 6.25 を使ってWPBMPEN を参照してください。
%     THR = WTHRMNGR('wp2ddenoGBL','penalme',WPT)
%            ALFA = 2 を使って WPBMPEN を参照してください。
%     THR = WTHRMNGR('wp2ddenoGBL','penallo',WPT)
%            ALFA = 1.5 を使って WPBMPEN を参照してください。
%
%   参考 THSELECT, WBMPEN, WDCBM, WDCBM2, WDEN, WDENCMP,  
%            WNOISEST, WPBMPEN, WPDENCMP.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 21-Oct-98.
%   Last Revision: 26-Oct-1999.
%   Copyright 1995-2004 The MathWorks, Inc.
