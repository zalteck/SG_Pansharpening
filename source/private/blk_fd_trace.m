function traza = blk_fd_trace(m)
    traza = 0;
    for i=1:size(m,1)
        for j=1:size(m,2)
            aux(:,:) = m(i,j,:,:);
            traza = traza + trace(aux);
        end
    end
    
    if (abs(imag(traza)) > 1.0e-3)
        error('Error (blk_fd_trace): La parte imaginaria de la traza deberia ser 0\nParte imaginaria: %f\n', imag(traza));
    end

    traza = real(traza);
    
end