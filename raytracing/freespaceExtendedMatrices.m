function [abcdMatrices] = freespaceExtendedMatrices(d, apertureSize, N)
%FREESPACEEXTENDEDMATRICES Create an array of N extended ABCD matrices (6x6xN) of freespace
abcdMatrices = extendMatrix([1 0; 0 1], 0, apertureSize);
for i=1:N
    abcdMatrices = cat(3,abcdMatrices, extendMatrix([1 d/N ; 0 1], d/N, apertureSize));
end
end
