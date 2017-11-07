function isImaging = isImagingMatrix( matrix )
%ISIMAGINGMATRIX Returns true if the matrix is an imaging matrix (i.e., B=0)
%   Detailed explanation goes here
isImaging = false;

if abs(matrix(1,2)) < 1e-6
    isImaging = true;
end

end

