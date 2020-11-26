function out = blk_ifft2(in)
    out = zeros(size(in));
    
    for i=1:size(in,3)
        for j=1:size(in,4)
            out(:,:,i,j)=real(ifft2(in(:,:,i,j)));
        end
    end
    
end