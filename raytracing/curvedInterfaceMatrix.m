function [abcdMatrix] = curvedInterfaceMatrix(R, n1,n2)
%CURVEDINTERFACEMATRIX Create an ABCD matrix (2x2) of a curved interface
abcdMatrix = [1 -(n2-n1)/(n2 * R); 0 n1/n2];
end
