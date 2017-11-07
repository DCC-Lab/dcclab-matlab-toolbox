function [ theSize, thePosition, matrixToFieldStop, theFieldOfViewSize ] = fieldStop( opticalPath)
%FIELDSTOP Returns the position size and transfer matrix to the field stop
%   Detailed explanation goes here


[forwardConjugatePath, ~] = conjugateOpticalPath( opticalPath );
matrix = transferMatrix( forwardConjugatePath );

loadConstants;

theSize = 300;  % Default value
thePosition = 0; % Default value
matrixToFieldStop = extendMatrix([1 0; 0 1], 0, inf);

if isImagingMatrix(matrix) 
    [ ~, ~, apertureTransferMatrix ] = apertureStop(forwardConjugatePath);
    for r=0:1:1000
       thetaChief = chiefRay(r, apertureTransferMatrix);
       rayCollection = rayCalc([r, thetaChief], forwardConjugatePath);
       lastRay = rayCollection(:, size(rayCollection,2));
       if lastRay(k1RayIndex) == 0
           theSize = 1/lastRay(kInverseApertureRayIndex);
           thePosition = lastRay(kZPositionRayIndex);
           matrixToFieldStop = transferMatrix(forwardConjugatePath(:,:,1:lastRay(kElementRayIndex)));
           break;
       else
           theFieldOfViewSize = r;  
       end
    end
else
    ME = MException('dcclab:NotImaging', 'The optical path provided must be from object to image plane');
    throw(ME);                            
end


end

