function [ xPeak, yPeak ] = findImagePeak( image )
%findImagePeak 

% max of the input array, 2D or 3D
[maxValues, xPeak] = max(max(image, [], 1), [], 2);
[maxValues, yPeak] = max(max(image, [], 2), [], 1);
% indices of the max of the input array, 2D or 3D
xPeak = xPeak(:);
yPeak = yPeak(:);

end

