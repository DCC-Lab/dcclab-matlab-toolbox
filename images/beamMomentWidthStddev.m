function [ x, y] = beamStddev( image)
%beamStddev Returns the image standard deviation, as defined by second order moments order along X and Y

energy = beamMoment(image, 0, 0 );

cx = beamMoment(image, 1, 0 ) ./ energy;
cy = beamMoment(image, 0, 1 ) ./ energy;

x2 = beamMoment(image, 2, 0 ) ./ energy;
y2 = beamMoment(image, 0, 2 ) ./ energy;

x = sqrt(x2-cx.*cx);
y = sqrt(y2-cy.*cy);

end

