function Ht = Tcent_nucleus2fft(spkernel, nr, nc)
%% ajustar tamaño
    if(( size(spkernel,1)> nr) || ( size(spkernel,2)> nc))
            if( size(spkernel,1)> nr)
                centroR = round((size(spkernel,1)-nr)/2);
                inter=zeros(nr,size(spkernel,2));
                inter(1:nr,:)=spkernel(centroR+1:(centroR + nr),:);
            end
            
             if( size(inter,2)> nc)
                centroC = round((size(spkernel,2)-nc)/2);
                interinter=zeros(size(inter,1),nc);
                interinter(:,1:nc)=inter(:,centroC+1:(centroC + nc));
             end
             fac=sum(spkernel(:))/sum(interinter(:));
             spkernel=interinter*fac;  
             clear inter interinter
    end
    
%% Poner el núcleo centrado en el origen y calcular la fft2

            centroR = round((nr-size(spkernel,1))/2);
            centroC = round((nc-size(spkernel,2))/2);
            h = zeros(nr, nc);
            h(centroR+1:(centroR + size(spkernel,1)),centroC+1:(centroC + size(spkernel,2))) = spkernel;
            h = fftshift(h);
            ht=flipdim(h,1);
            ht=flipdim(ht,2);
            ht=circshift(ht,[1,1]);
            Ht = fft2(ht);    
end
