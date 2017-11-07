function [abcdMatrices] = grinMatrices(l, n0, g, N)
%GRINMATRICES Create an array of N ABCD matrix (2x2xN) of a GRIN
abcdMatrices = [];
for i=1:N
    abcdMatrices = cat(3,abcdMatrices,[ cos(g * l/N) sin(g*l/N)/(g * n0); -sin(g*l/N)*(g * n0) cos(g * l/N) ]);
end
end
