function [ x, y] = beamWidthThresholdedCentroid( image, thresholdFraction )
%beamWidthThresholdedCentroid Returns the image centroid, as defined by first
%order moments along X and Y calculated with any values with 10% of the
%maximum.

if ( nargin == 1 ) 
    thresholdFraction = 0.9;
end

[ xc, yc ] = beamMomentCentroid( thresholdBeam( image, thresholdFraction ) );

if nargout == 0
    x = [ xc yc ];
else
    x = xc;
    y = yc;
end


end

