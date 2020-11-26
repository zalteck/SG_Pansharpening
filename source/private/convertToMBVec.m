function y = convertToMBVec(x)

[N M nb] = size(x);
v=zeros(M,N);
y=[];
for i=1:nb
    v=x(:,:,i);
    z = reshape(v', N*M,1);
    y=[y;z];
end

end
