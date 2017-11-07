function [ fourierMask ] = circularMaskAtOffset( image, normalizedDiameter, xo, yo )
%circularMaskAtOffset Creates a circular mask centered at offset (x0, y0)
%   An image is stored with its X in the first dimension. imshow()
%   transposes the images.

[nX,nY,iz] = size(image); 

[x, y] = meshgrid(0:nX-1,0:nY-1);

distanceMap = sqrt( ((x - yo) / nX).^2 + ((y - xo)/nY).^2);

fourierMask = double( distanceMap <= abs(normalizedDiameter)/2);

end

