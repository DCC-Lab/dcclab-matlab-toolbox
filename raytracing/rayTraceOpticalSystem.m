function [ output_args ] = rayTraceOpticalSystem( opticalPath )
%RAYTRACEOPTICALSYSTEM Given an optical path, assumes an object at the entrance trace the rays, and draws the object, image, aperture stop, field stop.

loadConstants;

% Where is the aperture stop
[size, position, matrixToApertureStop] = apertureStop(opticalPath);

% Where are the conjugate planes for object at front or image at back
[forwardMatrix, backwardMatrix] = conjugateMatrices(transferMatrix(opticalPath ));
% Where is the field of view with object at the front
[fieldStopSize, fieldStopPosition, matrixToFieldStop, fieldOfViewSize] = fieldStop(opticalPath);

h=figure;

% Trace rays
objectSize = fieldOfViewSize-0.01;
radiusRange = [0:objectSize/5:objectSize];
for r = radiusRange
    for angle = marginalRayRange(r, matrixToApertureStop,6)
        rayCollection = rayCalc([r;angle], opticalPath);

        hue = (r-min(radiusRange))/(max(radiusRange)-min(radiusRange));
        color = hsv2rgb(hue,1,1);
        rayTrace(rayCollection, color);
        
    end
end

% Trace object and image
drawApertures(opticalPath);
drawOpticalElements(opticalPath);
% BUG/FEATURE: Must be done at the end if we want it to show.
[transverseMagnification, dummy, dummy]=conjugateMatrixProperties( forwardMatrix);
drawObject(0,objectSize);
drawObject(forwardMatrix(kZPositionRayIndex,k1RayIndex),objectSize * transverseMagnification);

figure(h);


end

