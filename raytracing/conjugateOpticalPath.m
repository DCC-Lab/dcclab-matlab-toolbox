function [ forwardConjugateOpticalPath, backwardConjugateOpticalPath ] = conjugateOpticalPath( opticalPath )
%CONJUGATEOPTICALPATH With a given opticalPath, returns the two conjugate opticalPaths assuming an object at the front (forwardConjugate) or assuming an image at the back (backward conjugate)
%matrix that transfers from the first left reference to the newly found image conjugate (front) or to the
%object conjugate (back)
%   Detailed explanation goes here

matrix = transferMatrix(opticalPath);

backwardConjugate = -matrix(1,2)/matrix(1,1);
forwardConjugate = -matrix(1,2)/matrix(2,2);

if forwardConjugate < 0 %% Try to remove matrices.
    for i=size(opticalPath,3):1
        theElement = opticalPath(:,:,i);

        if theElement(6,5) == 1 % freespace
            elementLength = theElement(1,2)
            if elementLength <  -forwardConjugate
                opticalPath(:,:,i) = [];
                forwardConjugate = forwardConjugate - elementLength;
            end
        end

    end
end

forwardConjugateOpticalPath = cat(3,opticalPath, freespaceExtendedMatrices(forwardConjugate, inf, 100) );
backwardConjugateOpticalPath = cat(3,opticalPath, freespaceExtendedMatrices(backwardConjugate, inf,100) );

end

