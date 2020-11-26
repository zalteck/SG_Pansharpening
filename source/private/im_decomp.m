function out = im_decomp(in,bknr,bknc)
    nr=size(in,1);
    nc=size(in,2);
    
    low_nr=ceil(nr/bknr); 
    low_nc=ceil(nc/bknc);
    padsize=[bknr*low_nr - size(in,1),bknc*low_nc - size(in,2)];
    auxin=padarray(in,padsize,0,'post');
    out = zeros(low_nr, low_nc,bknr*bknc,1);
    
    pos=1; 
    for spr=1:bknr              
        for spc=1:bknc  
            out(:,:,pos,1)= auxin(spr:bknr:end,spc:bknc:end);
            pos=pos+1;
        end
    end
   
end