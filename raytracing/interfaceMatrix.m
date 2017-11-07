function [abcdMatrix] = interfaceMatrix(n1,n2)
%INTERFACEMATRIX Create an ABCD matrix (2x2) of a flat interface
abcdMatrix = [1 0; 0 n1/n2];
end
