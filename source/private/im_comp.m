function out = im_comp(in,bknr,bknc)
    nr=size(in,1)*bknr;
    nc=size(in,2)*bknc;
    
    interout = zeros(nr,nc);
    
    pos=1; 
    for spr=1:bknr              
        for spc=1:bknc 
            interout(spr:bknr:end,spc:bknc:end) =in(:,:,pos,1);
            pos=pos+1;
        end
    end
    out(1:nr,1:nc)=interout(1:nr,1:nc);
    
end    