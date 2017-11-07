function [ range ] = marginalRayRange( r, matrixToAperture, N)
%MARGINALRAYRANGE Returns a range that covers from -marginal to +marginal
%   Detailed explanation goes here

if nargin == 2
    N = 10;
end

[thetaUp, thetaDown] = marginalRay(r, matrixToAperture);

range=[thetaDown:(thetaUp-thetaDown)/N:thetaUp];

end

