function [ theSize, thePosition, transferMatrix ] = apertureStop( opticalPath)
%APERTURESTOP Returns the half-diameter, the position and the transfer matrix of the aperture stop in an optical path  

if ~isOpticalPath(opticalPath)
    ME = MException('dcclab:NotOpticalPath', 'You must provide an optical path');
    throw(ME);
elseif ~isExtended(opticalPath)
    ME = MException('dcclab:NoAperture', 'Only extended matrices have apertures: there is no aperture stop in this path');
    throw(ME);
end

loadConstants;
rayCollection = [];

ray = extendRay([0;0.01], 0);
rayCollection = cat(3,rayCollection, ray);

for i=1:size(opticalPath,3);
    element = opticalPath(:,:,i);
    ray = element * ray;
    rayCollection = cat(3,rayCollection, ray);
end

theAperture = abs(squeeze(rayCollection(kInverseApertureRayIndex,1,:) .* rayCollection(kRadiusRayIndex,1,:)));
[~, index ] = max(theAperture);

theSize = 1/rayCollection(kInverseApertureRayIndex,1,index);
thePosition = rayCollection(kZPositionRayIndex,1,index);

index = index-1; % rayCollection has +1 more element because it is the input ray and final rays

transferMatrix = [];
for i=1:index
    if isempty(transferMatrix)
        transferMatrix = opticalPath(:,:,i);
    else
        transferMatrix = opticalPath(:,:,i) * transferMatrix;
    end
end


end
