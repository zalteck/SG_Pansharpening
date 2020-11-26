function y = convertToVec(x)

[N M] = size(x);
if M > 1, % If it's not a vector
    y = reshape(x', N*M,1);
else % if its a vector
    y = x;
end

