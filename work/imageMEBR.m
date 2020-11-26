function Y = imageMEBR( Y, facY )
%	imageMEBS recovers multi-spectral image range previous to imageMENormalization
    Y = double(Y);
    Y(Y < eps) = 0.0;
    nbandas = size(Y,3);
    for i=1:nbandas
        Y(:,:,i) = Y(:,:,i)*facY(i);
    end

end

