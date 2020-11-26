function out=blk_fd_corr(Op1,Op2)
    if ((size(Op1,3)~=size(Op2,3))||...
            (size(Op1,1)~=size(Op2,1))||...
            (size(Op1,2)~=size(Op2,2)))
        error('Dimensions do not agree');
    end
    out=zeros(size(Op1,1),size(Op1,2), size(Op1,4),size(Op2,4));
    for i=1:size(out,3)
        for j=1:size(out,4)
            for k=1:size(Op1,3)
                out(:,:,i,j)=out(:,:,i,j)+conj(Op1(:,:,k,i)).*Op2(:,:,k,j);
            end
        end
    end