function [ diameter ] = beamCircularDiameter( image )
%Returns the diameter of the beam using the parameter 1/e^2
image=image(:,:,1);
area=find(image>=(max(image(:))/(1*exp(1)^2)));
diameter=2*sqrt(size(area,1)/pi);
end

