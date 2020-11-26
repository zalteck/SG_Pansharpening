% IMGXTOOL   イメージ拡張ツール
%
%   VARARGOUT = IMGXTOOL(OPTION,VARARGIN)
%
% ツール指向のGUIは、打ち切り、または拡張によってオリジナルのイメージから
% 新規イメージを作成します。拡張は、異なる可能なモードを選択することで
% 行われます:
% 対称、周期的、ゼロパディング、連続または平滑
% 特別なモードは、SWT分解で認識するためにイメージの拡張を行います。
%------------------------------------------------------------
% 内部的なオプション:
%
%   OPTION = 'create'          'load'             'demo'
%            'update_deslen'   'extend_truncate'
%            'draw'            'save'
%            'clear_graphics'  'mode'
%            'close'
%
%   参考 WEXTEND.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 30-Nov-98.
%   Last Revision: 14-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
