function lamb=calclam(hires,pan);
% calclam estimates lambda parameters for an observed MS + pan images
% 
% input arguments:
%       hires          Observed MS image
%       pan            Observed panchromatic image of the same resolution
%                      as hires
% output arguments:
%       lambda          lambda parameters
%
% Pérez-Bueno, F., Vega, M., Mateos, J., Molina, R., & Katsaggelos, A. K. (2020). 
% Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors. Sensors, 20(18), 5308.  

    [lr_size(1), lr_size(2), ~]=size(hires);
    hr_size=size(pan);
    nlamb=size(hires,3);

    m=zeros(nlamb);
    lr=zeros(nlamb,1);


    for ib=1:nlamb
        for jb=1:nlamb
            m(ib,jb)=sum(sum(hires(:,:,ib).*hires(:,:,jb)));
        end
        lr(ib)=sum(sum(hires(:,:,ib).*pan(:,:)));  % both at the same resolution
    end

    lamb= m\lr;

    indexes = find(lamb > eps);

    lamb(lamb <= eps) = 0.0;

    lamb(indexes)= lamb(indexes)/(sum(lamb(indexes)));
end
