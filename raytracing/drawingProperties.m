function [ physicalLength, widthQuantum] = drawingProperties( opticalPath )
%DRAWINGPROPERTIES Returns the drawing properties: physical length and reasonable minimum width for "thin" elements.
%   Detailed explanation goes here
    loadConstants;

    rayCollection = rayCalc([0;0],opticalPath);
    
    maxZ = max(rayCollection(kZPositionRayIndex,:));
    minZ = min(rayCollection(kZPositionRayIndex,:));
    physicalLength = maxZ - minZ;

    widthQuantum = physicalLength/40;
    
    maxInvAperture = max(rayCollection(kInverseApertureRayIndex,:));
    
end
