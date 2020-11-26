%WFUSMAT  2 つの行列または配列のフュージョン
%
%   C = WFUSMAT(A,B,METHOD) は、METHOD で定義されるフュージョンを使用して
%   行列 A と B から得られる融合した行列 C を返します。
%
%   行列 A と B は、同じサイズでなければなりません。
%   A と B がインデックス付きイメージで表される場合、それらは m×n の行列に
%   なります。
%   A と B がトゥルーカラーイメージで表される場合、それらは m×n×3 の
%   配列になります。
%
%   利用可能なフュージョンの方法は以下のとおりです。
%
%   - シンプルな場合。METHOD は以下のいずれかです。
%         - 'max'  : D = abs(A) >= abs(B) ; C = A(D) + B(~D)
%         - 'min'  : D = abs(A) <= abs(B) ; C = A(D) + B(~D)
%         - 'mean' : C = (A+B)/2 ; D = ones(size(A))
%         - 'rand' : C = A(D) + B(~D); D は boolean の乱数行列です。
%         - 'img1' : C = A
%         - 'img2' : C = B
%
%   - パラメータ依存の場合。METHOD は以下の形式になります。
%     METHOD = struct('name',nameMETH,'param',paramMETH) ここで、nameMETH は
%     以下のいずれかになります。
%         - 'linear'    : C = A*paramMETH + B*(1-paramMETH)
%                             ただし 0 <= paramMETH <= 1 です。
%         - 'UD_fusion' : 上から下方向へのフュージョン。paramMETH >= 0 とします。
%                         x = linspace(0,1,size(A,1));
%                         P = x.^paramMETH;
%                         C の各行は、以下のように計算されます。
%                         C(i,:) = A(i,:)*(1-P(i)) + B(i,:)*P(i);
%                         したがって、C(1,:)= A(1,:) で C(end,:)= A(end,:) です。
%         - 'DU_fusion' : 下から上方向へのフュージョン
%         - 'LR_fusion' : 左から右方向へのフュージョン (列方向のフュージョン)
%         - 'RL_fusion' : 右から左へのフュージョン (列方向のフュージョン)
%         - 'userDEF'   : paramMETH は、C = userFUNCTION(A,B) のような関数名を
%                         含む文字列 'userFUNCTION' です。
%
%   さらに [C,D] = WFUSMAT(A,B,METHOD) は、定義する場合は boolean 行列 D を
%   返し、定義しない場合は空の行列を返します。


%   Copyright 1995-2008 The MathWorks, Inc.
