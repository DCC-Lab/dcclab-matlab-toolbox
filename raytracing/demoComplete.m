%DEMOCOMPLETE Complete demo with ray tracing example
loadConstants;

space    = freespaceExtendedMatrices(45, inf, 10);
space2   = freespaceExtendedMatrices(40, inf, 10);
lens     = lensExtendedMatrix(50,inf);
lens2    = lensExtendedMatrix(10,120);
aperture = apertureExtendedMatrix(10);
grin     = grinExtendedMatrices(300, 1.4, 0.0062, 50, 30);

opticalPath = cat(3,space, space2,space2,grin,space2,space2,aperture,space2);

% Where is the aperture stop
[size, position, matrixToApertureStop] = apertureStop(opticalPath);

% Where are the conjugate planes for object at front or image at back
[forwardMatrix, backwardMatrix] = conjugateMatrices(transferMatrix(opticalPath ));
% Where is the field of view with object at the front
[fieldStopSize, fieldStopPosition, matrixToFieldStop, fieldOfViewSize] = fieldStop(opticalPath);

h=figure;
%axis equal;
% Trace apertures

% Trace rays
objectSize = fieldOfViewSize;
radiusRange = [0:objectSize/5:objectSize];
for r = radiusRange
    for angle = marginalRayRange(r, matrixToApertureStop)
        rayCollection = rayCalc([r;angle], opticalPath);

        hue = (r-min(radiusRange))/(max(radiusRange)-min(radiusRange));
        color = hsv2rgb(hue,1,1);
        rayTrace(rayCollection, color);
        
    end
end

% Trace object and image
drawApertures(opticalPath);
drawOpticalElements(opticalPath, 120);
% BUG/FEATURE: Must be done at the end if we want it to show.
[transverseMagnification, dummy, dummy]=conjugateMatrixProperties( forwardMatrix);
drawObject(0,objectSize);
drawObject(forwardMatrix(kZPositionRayIndex,k1RayIndex),objectSize * transverseMagnification);


% [thetaMarginalUp, thetaMarginalDown] = marginalRay(0, matrixToApertureStop);
% rayTrace(rayCalc([0;thetaMarginalUp], opticalPath), [0.5,0.5, 0.5]);
% rayTrace(rayCalc([0;thetaMarginalDown], opticalPath), [0.5,0.5, 0.5]);
% thetaChief = chiefRay(50, matrixToApertureStop);
% rayTrace(rayCalc([50;thetaChief], opticalPath), [0.5,0.5, 0.5]);

figure(h);
