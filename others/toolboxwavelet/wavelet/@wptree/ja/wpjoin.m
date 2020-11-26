% WPJOIN   ウェーブレットパケットツリーの再構成
%
% WPJOIN は、ノードの再構成後にウェーブレットパケットツリーを更新します。
%
% T = WPJOIN(T,N) は、ノード N の再構成に対応する修正されたツリー T を出力します。
%
% T = WPJOIN(T) は、T = WPJOIN(T,0) と等価です。
%
% [T,X] = WPJOIN(T,N) は、ノードの係数も出力します。
%
% [T,X] = WPJOIN(T) は、[T,X] = WPJOIN(T,0) と等価です。
%
%   参考 WPDEC, WPDEC2, WPSPLT.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
