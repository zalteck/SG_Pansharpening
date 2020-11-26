function H = cent_nucleus2blk_fft2(spkernel, nr, nc,bknr,bknc)

    low_nr=ceil(nr/bknr); 
    low_nc=ceil(nc/bknc);
    H = zeros(low_nr,low_nc,bknr*bknc,bknr*bknc);
    
    cent_nuc=ifft2(cent_nucleus2fft(spkernel, nr, nc));
    
    i=1;
    inter_cent_nuc=cent_nuc;
    for jr=1:bknr
        for jc=1:bknc
            col=im_decomp(inter_cent_nuc,bknr,bknc);
            H(:,:,:,i)=col(:,:,:,1);
            i=i+1;
            inter_cent_nuc=circshift(inter_cent_nuc,[0 1]);
        end
        cent_nuc=circshift(cent_nuc,[1 0]);
         inter_cent_nuc=cent_nuc;
    end
    
    H=blk_fft2(H);
    
                  
end
