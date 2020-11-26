% ADDLIFT   primal または dual リフティングステップの追加
%
% LSN = ADDLIFT(LS,ELS) rは、リフティングスキーム LS に基本的なリフティング
% ステップ ELS を追加することにより、新しいリフティングスキーム LSN を
% 出力します。
%   
% LSN = ADDLIFT(LS,ELS,'begin') は、指定した基本的なリフティングステップを
% 先頭に追加します。
% 
% ELS は、つぎのセル配列 (LSINFO を参照) か、
%        {TYPEVAL, COEFS, MAX_DEG}  
% または、つぎの構造体 (LIFTFILT を参照) 
%         struct('type',TYPEVAL,'value',LPVAL) 
% です。ここで、LPVAL = laurpoly(COEFS, MAX_DEG) です。
%
% ADDLIFT(LS,ELS,'end') は、ADDLIFT(LS,ELS) と同じです。
%
% ELS がセル配列、または構造体の配列に格納されている基本的なリフティング
% ステップの列である場合、それぞれの基本的なリフティングステップ列は、
% LS に追加されます。
%
% リフティングスキームのタイプについての詳細は lsinfo をタイプしてください。
%   
% 例題:
%      LS = liftwave('db1')
%      els = { 'p', [-1 2 -1]/4 , [1] };
%      LSend = addlift(LS,els)
%      LSbeg = addlift(LS,els,'begin')
%      displs(LSend)
%      displs(LSbeg)
%      twoels(1) = struct('type','p','value',lp([1 -1]/8,0));
%      twoels(2) = struct('type','p','value',lp([1 -1]/8,1));
%      LStwo = addlift(LS,twoels)
%      displs(LStwo)
%
%   参考 LIFTFILT.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 28-May-2001.
%   Last Revision: 14-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
