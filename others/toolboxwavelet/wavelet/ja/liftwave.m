% LIFTWAVE   通常のウェーブレットに対するリフティングスキーム
%
% LS = LIFTWAVE(WNAME) は、WNAME で指定されたウェーブレットに関連する
% リフティングスキームを出力します。
%
% LS = LIFTWAVE(WNAME,'Int2Int') は、整数から整数へのウェーブレット変換を
% 実行します。
%
% WNAME に対する有効な値はつぎのようになります:
%      'lazy'
%      'haar', 
%      'db1', 'db2', 'db3', 'db4', 'db5', 'db6', 'db7', 'db8'
%      'sym2', 'sym3', 'sym4', 'sym5', 'sym6', 'sym7', 'sym8'
%      Cohen-Daubechies-Feauveau wavelets:
%         'cdf1.1','cdf1.3','cdf1.5' - 'cdf2.2','cdf2.4','cdf2.6'
%         'cdf3.1','cdf3.3','cdf3.5' - 'cdf4.2','cdf4.4','cdf4.6'
%         'cdf5.1','cdf5.3','cdf5.5' - 'cdf6.2','cdf6.4','cdf6.6'
%      'biorX.Y' , WAVEINFO を参照
%      'rbioX.Y' , WAVEINFO を参照
%      'bs3'  : 'cdf4.2' と同じ
%      'rbs3' : 'bs3' の逆
%      '9.7'  : 'bior4.4' と同じ
%      'r9.7' : '9.7' の逆
%
%      注意:
%        'cdfX.Y' == は、bior4.4 と bior5.5 を除いて 'biorX.Y' と同じです。
%        'rbioX.Y' は、'biorX.Y' の逆です。
%        'haar' == 'db1' == 'bior1.1' == 'cdf1.1'
%        'db2'  == 'sym2'  と  'db3' == 'sym4'  
%
% リフティングスキームについての詳細は lsinfo をタイプしてください。

%      -------------------------------------------------------
%      'db1INT' : 正規化されない整数のHaar変換です。
%      -------------------------------------------------------


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 09-Feb-2000.
%   Last Revision: 11-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
