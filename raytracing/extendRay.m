function [ extendedRay ] = extendRay( ray, position )
%EXTENDRAY Returns an extended ray from a standard ABCD ray [ r, theta, position, 1/apertureSize, 1/apertureAngle, 1, type, elementIndex] 
%   
extendedRay = [ ray(1); ray(2); position; 0; 0; 0; 0; 1];
    
end

