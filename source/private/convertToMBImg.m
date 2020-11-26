function y = convertToMBImg(x,Ng,Mg,nb)

c=class(x);
y=zeros( Ng, Mg,nb);
x=reshape(x,Ng*Mg,nb);
for i=1:nb
   z=x(:,i);
   z=reshape(z, Mg, Ng);
    y(:,:,i) = z';
end

y=cast(y,c);

end
