function [abcdMatrix] = freespaceMatrix(l)
%FREESPACEMATRIX Create an ABCD matrix (2x2) of freespace 
abcdMatrix = [1 l; 0 1];
end
