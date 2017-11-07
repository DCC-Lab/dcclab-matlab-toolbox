function [abcdMatrices] = grinExtendedMatrices(l, n0, g, apertureSize, N)
%GRINEXTENDEDMATRICES Create an array of extended ABCD matrices (6x6xN) of GRIN
loadConstants;
abcdMatrices = extendMatrix([1 0; 0 1], 0, apertureSize);

for i=1:N
    abcdMatrices = cat(3, abcdMatrices, extendMatrix([ cos(g * l/N) sin(g*l/N)/(g * n0); -sin(g*l/N)*(g * n0) cos(g * l/N)],l/N, apertureSize));
end
abcdMatrices(kTypeRayIndex,k1RayIndex,:)=kGRINType;

end
