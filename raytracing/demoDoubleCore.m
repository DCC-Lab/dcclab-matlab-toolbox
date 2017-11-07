function doublecoreDemo

%DEMODOUBLECORE 
%Fiber seperation = 32um
%First spacer L =300
%Grin L = 100
%Second Space is free space L = any length


%Double core fiber
Seperation = 32;
ymax = (Seperation/2) +2;
ymin = (Seperation/2) - 2;
core1 = [-ymax:1:-ymin];
core2 = [ymax:-1:ymin];
fiber1 = freespaceExtendedMatrices(0, 100, 10);
fiber2 = freespaceExtendedMatrices(0, 100, 10);

%Micro Optical components
space = freespaceExtendedMatrices(10000, 100, 100);
grin = grinExtendedMatrices(90, 1.4, 0.0062, 32.5, 100);
space2 = freespaceExtendedMatrices(800, 100, 10);


opticalPath = cat(3,fiber1,fiber2,space,grin, space2);

angleRange = [-0.1:0.0001:0.1];
radiusRange = [core1 core2];

demoExtended(opticalPath,angleRange,radiusRange)
