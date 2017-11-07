function [ theExtendedProperties ] = imageExtendedProperties( theObject )
%imageExtendedProperties Returns a structure with  properties of the image
%based on its appearance
% If a stack (i.e. more than 3D) is passed, the first image is used.
if length(size(theObject)) > 3
    theImage = theObject(:,:,:,1);
else
    theImage = theObject;
end

theExtendedProperties = imageProperties( theObject);

saltAndPepperReference = imnoise(zeros(theExtendedProperties.width,theExtendedProperties.height),'salt & pepper',1);
photonNoise = sum(sum(abs(saltAndPepperReference-medfilt2(saltAndPepperReference))));

for i=1:theExtendedProperties.sampelsPerPixel
    theExtendedProperties.photonNoise(i) = sum(sum(abs(theImage(:,:,i)-medfilt2(theImage(:,:,i))))) / photonNoise;
    if theExtendedProperties.photonNoise(i) > 1
        theExtendedProperties.photonNoise(i) = 1
    end
end
theExtendedProperties.hasPhotonNoise = theExtendedProperties.photonNoise>0.001;

end

