function out= blk_DY(Y,rbk,cbk,bknr,bknc)
   out=zeros( size(Y,1), size(Y,2));
   out(:,:)=Y(:,:,cbk+(rbk-1)*bknc,1);