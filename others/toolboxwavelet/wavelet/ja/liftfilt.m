% LIFTFILT   フィルタに基本的なリフティングステップの適用
%
% [LoDN,HiDN,LoRN,HiRN] = LIFTFILT(LoD,HiD,LoR,HiR,ELS) は、
% 4つのフィルタ LoD, HiD, LoR and HiR から、
% "基本的なリフティングステップ (elementary lifting step)" (ELS) により
% 得られた LoDN, HiDN, LoRN, HiRN を出力します。
% 4つの入力フィルタは、完全再構成の条件を満たします。
%
% ELS は、つぎのような構造体です:
%     - TYPE = ELS.type は、基本的なリフティングステップの "タイプ" を
%       含みます。TYPE の有効な値はつぎの通りです: 
%          'p' (primal) または 'd' (dual).
%     - VALUE = ELS.value は、基本的なリフティングステップに関する
%       Laurent多項式 T を含みます (LP を参照)。VALUE がベクトルの場合、
%       関連するLaurent多項式 T は laurpoly(VALUE,0) と同じです。
%
% さらに、ELS は、"スケーリングステップ (scaling step)" になることがあります。
% この場合、TYPE は 's' (スケーリング) と同じであり、VALUE は0でないスカラです。
%
% LIFTFILT(...,TYPE,VALUE) は、同じ出力になります。
%
% 注意:
%     TYPE = 'p' の場合、HiD と LoR は変更されません。
%     TYPE = 'd' の場合、LoD と HiR は変更されません。
%     TYPE = 's' の場合、4つのフィルタは変更されます。
%
% ELS が基本的なリフティングステップの配列の場合、
% LIFTFILT(...,ELS) は、続けて各ステップを実行します。
%
% LIFTFILT(...,flagPLOT) は、続けて "双直交(biorthogonal)" の組 
% ("スケーリング関数" , "ウェーブレット") をプロットします 
%
%   参考 LP.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 27-May-2003.
%   Last Revision: 04-Sep-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
