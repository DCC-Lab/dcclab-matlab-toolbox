function [ dx,dy ] = beamWidthE2( image )
%beamWidthE2 returns the diameter in x and y of the gaussian beam using
%parameter 1\e^2 as the delimitation parameter
[xc yc]=beamMaximum(image);

image=image(:,:,1);
%Diameter in x
limit=round((max(image(xc,:))/exp(1)^2));
cg=find(image(xc,:)>=limit);
dx=size(cg,2);

%Diameter in y
limity=round((max(image(:,yc))/exp(1)^2));
cgy=find(image(:,yc)>=limit);
dy=size(cgy,1);
end
