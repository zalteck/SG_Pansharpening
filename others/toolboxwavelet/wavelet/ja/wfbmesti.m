% WFBMESTI   非整数ブラウン運動のパラメータ推定
%
% HEST = WFBMESTI(X) は、パラメータ H の非整数ブラウン運動からなる
% 信号 X の非整数インデックス H の3つの推定を含むベクトル HEST を
% 出力します。
%
% 最初の2つの推定は、2次離散導関数に基づき、2番目の推定は、ウェーブレットに
% 基づきます。
% 3番目の推定は、レベルに対するdetailの分散のloglogプロットで、線形回帰に
% 基づきます。


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 22-May-2003.
%   Last Revision: 11-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
