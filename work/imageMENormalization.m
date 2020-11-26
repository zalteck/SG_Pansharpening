function [Y, x, facY, facx] = imageMENormalization( Y, x )
%	imageMENormalization normalizes multi-spectral image
    Y = double(Y);
    nbandas = size(Y,3);
    lr_size = size(Y(:,:,1));
    hr_size= size(x);
    facY = zeros(nbandas,1);
    for i=1:nbandas
        facY(i)=sum(sum(Y(:,:,i)))/lr_size(1)/lr_size(2);
        Y(:,:,i) = Y(:,:,i)/facY(i);
    end
    facx=sum(x(:))/hr_size(1)/hr_size(2);;
    x=x/facx;

end

