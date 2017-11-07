function [abcdMatrix] = lensMatrix(f)
%LENSMATRIX Create an ABCD matrix (2x2) of a lens
abcdMatrix = [1 0; -1/f 1];
end
