function theta = chiefRay( radius, transferMatrixToApertureStop )
%CHIEFRAY Returns the angle of the chief ray for a given position (i.e. the ray that goes through the center of the aperture stop)
%   Detailed explanation goes here

A = transferMatrixToApertureStop(1,1);
B = transferMatrixToApertureStop(1,2);

theta = -A * radius / B;
end

