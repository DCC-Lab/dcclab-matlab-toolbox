function [abcdExtendedMatrix] = lensExtendedMatrix(f, apertureSize)
%LENSEXTENDEDMATRIX Create an extended ABCD matrix (6x6) of a lens
abcdExtendedMatrix = extendMatrix([1 0 ; -1/f 1], 0, apertureSize);
end
