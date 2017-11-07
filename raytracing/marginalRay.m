function [thetaUp, thetaDown] = marginalRay(r, transferMatrixToApertureStop )
%MARGINALRAY Returns the angles of the marginal rays (up and down, i.e. the last angles that are blocked by the aperture stop)
%   Detailed explanation goes here

loadConstants;

if isOpticalPath(transferMatrixToApertureStop)
    ME = MException('dcclab:NotExtendedTransferMatrix', 'You must provide a transfer matrix, not an optical path');
    throw(ME);                            
elseif ~isExtended(transferMatrixToApertureStop)
    ME = MException('dcclab:NotExtendedTransferMatrix', 'You must provide an extended transfer matrix');
    throw(ME);                            
end

size = 1/transferMatrixToApertureStop(kInverseApertureMatrixIndex);
A = transferMatrixToApertureStop(1,1);
B = transferMatrixToApertureStop(1,2);

thetaUp = (size - A * r )/ B;
thetaDown = (-size - A * r )/ B;
end

