function out = blk_circshift(in,disp)
    out = zeros(size(in));
    %    aux = zeros(size(in,1), size(in,2));
    for i=1:size(in,3)
        for j=1:size(in,4)
            out(:,:,i,j)=circshift(in(:,:,i,j),disp);
        end
    end
    
end