% RAYTRACING
%
% This library performs simple raytracing (within the paraxial
% approximation) using ABCD matrices and an extension to the formalism.
%
% Key strategy: Matrices operate on a ray, matrices are put into an array
% (list) that represents the optical path. The preferred matrices used are
% "extended matrices" that include information about apertures, positions,
% etc...  They include ABCD matrices, but are 8x8 matrices.
% 
%
%
% Matrices
%   loadConstants             - A set of constants for readability. Add to scripts with 'loadConstants'.
%   apertureExtendedMatrix    - Create an extended aperture matrix of a given size
%   freespaceMatrix           - Create an ABCD matrix (2x2) of freespace 
%   freespaceMatrices         - Create an array of N ABCD matrices (2x2xN) of freespace
%   freespaceExtendedMatrix   - Create an extended ABCD matrix (6x6xN) of freespace
%   freespaceExtendedMatrices - Create an array of N extended ABCD matrices (6x6xN) of freespace
%   lensMatrix                - Create an ABCD matrix (2x2) of a lens
%   lensExtendedMatrix        - Create an extended ABCD matrix (6x6) of a lens
%   grinMatrix                - Create an ABCD matrix (2x2) of a GRIN 
%   grinMatrices              - Create an array of N ABCD matrix (2x2xN) of a GRIN
%   grinExtendedMatrices      - Create an array of extended ABCD matrices (6x6xN) of GRIN
%   interfaceMatrix           - Create an ABCD matrix (2x2) of a flat interface
%   curvedInterfaceMatrix     - Create an ABCD matrix (2x2) of a curved interface
%   objectiveExtendedMatrix   - (Untested) Create an ABCD matrix (2x2) of an objective from focus-to-focus with a given length.
%
% Manipulation
%   extendMatrix              - Returns an extended version of the provided ABCD matrix that includes physical length, aperture size and optional apertureAngle (defaults to pi/2).
%   extendRay                 - Returns an extended ray from a standard ABCD ray [ r, theta, position, 1/apertureSize, 1/apertureAngle, 1, type, elementIndex] 
%   isExtended                - Returns whether or not the ray or matrix is extended
%   isFreespace               - Returns true if the matrix is a freespace matrix
%   isImagingMatrix           - Returns true if the matrix is an imaging matrix (i.e., B=0)
%   isOpticalPath             - Returns true if the object is an array of matrices (optical path)
%   transferMatrix            - Calculates the product of all matrices in a path, and returns the trandfer matrix
%   conjugateMatrices         - With a given transferMatrix, returns the two conjugate matrices assuming an object at the front (forwardConjugate) or assuming an image at the back (backward conjugate)
%   conjugateMatrixProperties - Return the imaging properties of this imaging matrix (magnification, etc...)
%   conjugateOpticalPath      - With a given opticalPath, returns the two conjugate opticalPaths assuming an object at the front (forwardConjugate) or assuming an image at the back (backward conjugate)
%   opticalPathProperties     - Returns the properties of the opticalPath object
%
% Instrumentation
%   apertureStop              - Returns the half-diameter, the position and the transfer matrix of the aperture stop in an optical path  
%   fieldStop                 - Returns the position size and transfer matrix to the field stop
%   chiefRay                  - Returns the angle of the chief ray for a given position (i.e. the ray that goes through the center of the aperture stop)
%   marginalRay               - Returns the angles of the marginal rays (up and down, i.e. the last angles that are blocked by the aperture stop)
%   marginalRayRange          - Returns a range that covers from -marginal to +marginal
%
% Ray tracing and visualization
%   rayCalc                   - Returns the ray as transformed by each matrix of the opticalPath
%   rayTrace                  - Trace the collection of rays onto the current figure
%   rayTraceOpticalSystem     - Given an optical path, assumes an object at the entrance trace the rays, and draws the object, image, aperture stop, field stop.
%   drawApertures             - Draw the apertures of an optical path
%   drawObject                - Draw an arrow at a given position with a given size
%   drawOpticalElements       - Draw the optical element
%   drawingProperties         - Returns the drawing properties: physical length and reasonable minimum width for "thin" elements.
% 
% Demos
%   demoSimple                - Simple demo with a few elements
%   demoExtended              - More complete demo with apertures
%   demoComplete              - Complete demo with ray tracing example
%   demoDoubleCore            - 
%   doublecoreDemo            - Double core fiber
