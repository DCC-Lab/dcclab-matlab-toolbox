%%
% Demo single lens, single object
space    = freespaceExtendedMatrices(20, inf, 10);
lens     = lensExtendedMatrix(4,40);
space2    = freespaceExtendedMatrices(10, inf, 10);

opticalSystem = cat(3, space, lens,space, space);
rayTraceOpticalSystem(opticalSystem);

%% 
%Demo 4f system, object at focus 
space    = freespaceExtendedMatrices(20, inf, 10);
lens     = lensExtendedMatrix(10,40);
space2    = freespaceExtendedMatrices(10, inf, 10);
aperture = apertureExtendedMatrix(10);

opticalSystem = cat(3, space2, lens,space2, space2, lens, space2, space2,space2);
rayTraceOpticalSystem(opticalSystem);


