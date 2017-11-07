function [ transverseMagnification, angularMagnification,equivalentFocalLength ] = conjugateMatrixProperties( conjugateTransferMatrix )
%CONJUGATEMATRIXPROPERTIES Return the imaging properties of this imaging matrix (magnification, etc...)
%matrix
%   Detailed explanation goes here
assert(isImagingMatrix(conjugateTransferMatrix), 'This is not an imaging matrix: B must be zero')
transverseMagnification = conjugateTransferMatrix(1,1);
angularMagnification = conjugateTransferMatrix(2,2);
equivalentFocalLength = -1/conjugateTransferMatrix(2,1);

end

