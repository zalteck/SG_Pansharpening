function y = convertToImg(x,Ng,Mg)

[N M] = size(x);

if(M==1) % If it's a vector
    y = reshape(x, Mg, Ng);
    y = y';
else
    y = x;
end
