function [ normalizedImage ] = normalizeImage( image )

if ~isfloat(image)
    image=single(image);
end

[height, width, samplesPerPixel] = size(image);
normalizedImage = zeros(height, width, 'single');

theMax = max(max(image,[],1),[],2);
theMax(find(theMax==0)) = 1;

theMaxMatrix = repmat(theMax, height, width);

% A matrix expression is faster than an explicit loop
normalizedImage = image ./ theMaxMatrix;

end

