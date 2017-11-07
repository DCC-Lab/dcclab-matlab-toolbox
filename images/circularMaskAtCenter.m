function [ mask ] = circularMaskInCenter( image, normalizedDiameter)
%circularMaskInCenter Summary of this function goes here
%   Detailed explanation goes here

[nRow,nCol,iz] = size(image); 
mask = circularMaskAtOffset(image, normalizedDiameter, (nRow-1)/2, (nCol-1)/2);  

end

