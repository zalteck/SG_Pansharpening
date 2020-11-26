% MSWTHRESH  1 次元複数信号のスレッシュホールドの実行
%
%   Y = MSWTHRESH(X,SORH,T) は、入力行列 X の、(SORH = 's' の場合) ソフト、
%   または (SORH = 'h' の場合) ハードの T-スレッシュホールドを返します。
%
%   T は、単一の値、X と同じサイズの行列、ベクトルのいずれかになります。
%   ベクトルの場合、スレッシュホールドは、行方向に行なわれ、LT = length(T) 
%   は、LT => size(X,1) でなければなりません。
%
%   Y = MSWTHRESH(X,SORH,T,'c') は、LT => size(X,2) となる列方向の
%   スレッシュホールドを行ないます。
%
%   Y = MSWTHRESH(X,'s',T) は、Y = sign(X).*(abs(X)-T+abs(abs(X)-T))/2 を
%   返します。ソフトスレッシュホールドでは 0 方向に縮小されます。
%
%   Y = MSWTHRESH(X,'h',T) は、Y = X.*(abs(X)>T) を返します。
%   ハードスレッシュホールドでは不連続が生じます。
%
%   参考 mswden, mswcmp, wthresh, wdencmp, wpdencmp


%   Copyright 1995-2007 The MathWorks, Inc.
