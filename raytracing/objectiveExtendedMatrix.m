function [ abcdMatrixExtended ] = objectiveExtendedMatrix( focalLength, physicalLength, apertureSize )
%OBJECTIVEEXTENDEDMATRIX (Untested) Create an ABCD matrix (2x2) of an objective from focus-to-focus with a given length.
%   Detailed explanation goes here

abcdMatrixExtended = extendMatrix([0 focalLength; -1/focalLength 0 ], physicalLength, apertureSize); 
end

