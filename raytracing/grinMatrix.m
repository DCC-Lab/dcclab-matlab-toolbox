function [abcdMatrix] = grinMatrix(l, n0, g)
%GRINMATRIX Create an ABCD matrix (2x2) of a GRIN 
abcdMatrix = [ cos(g * l) sin(g*l)/(g * n0); -sin(g*l)*(g * n0) cos(g * l) ]
end
