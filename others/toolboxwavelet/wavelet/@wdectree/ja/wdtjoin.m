% WDTJOIN   ウェーブレットパケットの再構成
%
% WDTJOIN は、ノードの再構成の後にウェーブレットパケットツリーを更新します。
%
% T = WDTJOIN(T,N) は、ノード N の再構成に対応する修正したツリー T を
% 出力します。
%
% T = WDTJOIN(T) は、T = WDTJOIN(T,0) と等価です。
%
% [T,X] = WDTJOIN(T,N) は、ノードの係数も出力します。
%
% [T,X] = WDTJOIN(T) は、[T,X] = WDTJOIN(T,0) と等価です。


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 13-Mar-2003.
%   Last Revision: 13-Mar-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
