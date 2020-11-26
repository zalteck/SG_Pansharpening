function out = blk_fft2(in)
    out = complex(zeros(size(in)));
    %    aux = zeros(size(in,1), size(in,2));
    for i=1:size(in,3)
        for j=1:size(in,4)
            out(:,:,i,j)=fft2(in(:,:,i,j));
        end
    end
    
end