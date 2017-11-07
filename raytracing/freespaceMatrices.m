function [abcdMatrices] = freespaceMatrices(d, N)
%FREESPACEMATRICES Create an array of N ABCD matrices (2x2xN) of freespace
abcdMatrices = [];
for i=1:N
    abcdMatrices = cat(3,abcdMatrices,[1 d/N; 0 1]);
end
end
