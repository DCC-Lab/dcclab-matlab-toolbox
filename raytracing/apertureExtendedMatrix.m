function [abcdExtendedMatrix] = apertureExtendedMatrix(apertureSize, varargin)
% APERTUREEXTENDEDMATRIX Create an extended aperture matrix of a given size

loadConstants;

apertureAngle = pi/2;
if nargin == 2
    apertureAngle = varargin{1};
end

abcdExtendedMatrix = extendMatrix([1 0;0 1],0,apertureSize, apertureAngle);
abcdExtendedMatrix(kTypeMatrixIndex) = kApertureType;

end

