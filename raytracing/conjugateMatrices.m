function [ forwardConjugateMatrix, backwardConjugateMatrix ] = conjugateMatrices( transferMatrix )
%CONJUGATEMATRICES With a given transferMatrix, returns the two conjugate matrices assuming an object at the front (forwardConjugate) or assuming an image at the back (backward conjugate)
%matrix that transfers from the first left reference to the newly found image conjugate (front) or to the
%object conjugate (back)
%   Detailed explanation goes here

backwardConjugate = -transferMatrix(1,2)/transferMatrix(1,1);
forwardConjugate = -transferMatrix(1,2)/transferMatrix(2,2);

if isExtended(transferMatrix)
    forwardConjugateMatrix = freespaceExtendedMatrix(forwardConjugate, inf) * transferMatrix;
    backwardConjugateMatrix = transferMatrix * freespaceExtendedMatrix(backwardConjugate, inf);
else
    forwardConjugateMatrix = freespaceMatrix(forwardConjugate) * transferMatrix;
    backwardConjugateMatrix = transferMatrix * freespaceMatrix(backwardConjugate);
end

end

