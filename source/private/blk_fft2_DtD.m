function out= blk_fft2_DtD(iy,ix, nr, nc,bknr,bknc)

    low_nr=ceil(nr/bknr); 
    low_nc=ceil(nc/bknc);
    
block=zeros([bknr*bknc*bknr*bknc 1]);

block(bknr*bknc*(bknc*(iy-1)+ix -1)+bknc*(iy-1)+ix) = 1;
aux=kron(block,ones([low_nr*low_nc 1]));

out = reshape(aux,[low_nr low_nc bknr*bknc bknr*bknc]);

end