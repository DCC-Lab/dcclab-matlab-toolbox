function [ newImage] = thresholdBeam( image, thresholdFraction )
%thresholdBeam Summary of this function goes here
%   Detailed explanation goes here

if ( nargin == 1 )
    thresholdFraction = 0.9;
end

image = mean(image, 3 );

maximumValues = max(max( image ));
minimumValues = min(min( image ));
threshold = minimumValues + thresholdFraction * ( maximumValues - minimumValues);

newImage = image .* (image > threshold);

end

