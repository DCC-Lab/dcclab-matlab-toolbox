function [ energy ] = beamEnergy( image)
%beamEnergy Returns the beam energy, as defined by moments of zeroth order along X and Y
%   Detailed explanation goes here

energy = beamMoment(image, 0, 0 );

end

