function [ x, y] = beamCentroid( image)
%beamCentroid Returns the image centroid, as defined by first order moments along X and Y

energy = beamMoment(image, 0, 0 );

x = beamMoment(image, 1, 0 ) ./ energy;
y = beamMoment(image, 0, 1 ) ./ energy;

end

