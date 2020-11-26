% BIORFILT　双直交ウェーブレットフィルタセット
%
% BIORFILT コマンドは、双直交ウェーブレットに関連する4つまたは8つのフィルタを
% 出力します。
%
% [LO_D,HI_D,LO_R,HI_R] = BIORFILT(DF,RF) は、分解フィルタ DF と再構成フィルタ 
% RF により設定される双直交ウェーブレットに関連した4つのフィルタを計算します。
% これらのフィルタは、
%    LO_D　 分解ローパスフィルタ
%    HI_D　 分解ハイパスフィルタ
%    LO_R　 再構成ローパスフィルタ
%    HI_R　 再構成ハイパスフィルタ
% です。
%
% [LO_D1,HI_D1,LO_R1,HI_R1,LO_D2,HI_D2,LO_R2,HI_R2] = BIORFILT(DF,RF,'8') は、
% 分解ウェーブレットに関連した最初の4つのフィルタと、再構成ウェーブレットに
% 関連した4つのフィルタを合わせて8つのフィルタを出力します。
%
%   参考 BIORWAVF, ORTHFILT.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
