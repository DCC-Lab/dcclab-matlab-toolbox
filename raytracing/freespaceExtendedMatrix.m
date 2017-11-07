function [abcdExtendedMatrix] = freespaceExtendedMatrix(d, apertureSize)
%FREESPACEEXTENDEDMATRIX Create an extended ABCD matrix (6x6xN) of freespace
abcdExtendedMatrix = extendMatrix([1 d; 0 1], d, apertureSize);
end
