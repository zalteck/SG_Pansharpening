function out= blk_DtY(Y,rbk,cbk,bknr,bknc)
   out=zeros( size(Y,1), size(Y,2), bknr*bknc,1);
   out(:,:,cbk+(rbk-1)*bknc,1) = Y;