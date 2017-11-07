% IMAGES
%
% Files
%   affineTransformToRegisterImage - affineTransformToRegisterImage Returns the transform that aligns the two
%   alignImage                     - Aligns the first image onto the second (reference) one and
%   beamCircularDiameter           - Returns the diameter of the beam using the parameter 1/e^2
%   beamMaximum                    - beamMaximum Returns the averaged coordinates of the image maximum
%   beamMoment                     - Unnormalized raw moments as calculated by http://en.wikipedia.org/wiki/Image_moment
%   beamMomentCentroid             - beamCentroid Returns the image centroid, as defined by first order moments along X and Y
%   beamMomentEnergy               - beamEnergy Returns the beam energy, as defined by moments of zeroth order along X and Y
%   beamMomentWidthStddev          - beamStddev Returns the image standard deviation, as defined by second order moments order along X and Y
%   beamParameters                 - gaussianBeamParameters returns the mean beam width, the divergence, 
%   beamWidthE2                    - beamWidthE2 returns the diameter in x and y of the gaussian beam using
%   beamWidthGaussianFit           - beamWidthGaussianFit Determine the gaussian width of a beam with a gaussian fit 
%   beamWidthThresholdedCentroid   - beamWidthThresholdedCentroid Returns the image centroid, as defined by first
%   circularMaskAtCenter           - circularMaskInCenter Summary of this function goes here
%   circularMaskAtOffset           - circularMaskAtOffset Creates a circular mask centered at offset (x0, y0)
%   findImagePeak                  - findImagePeak 
%   guiProfile                     - profile Trace le profile d'intensité à la position ayant été déterminée comme
%   highPassFilterImage            - normalizedCutoff is the circular cutoff frequency which is normalized to [0 1], that is, 
%   imageExtendedProperties        - imageExtendedProperties Returns a structure with  properties of the image
%   imageProperties                - imageProperties Returns a structure with general properties of the image
%   loadImage                      - loadImage Loads a microscopy image regardless of format
%   lowPassFilterImage             - normalizedCutoff is the circular cutoff frequency which is normalized to [0 1], that is, 
%   normalizeImage                 - 
%   thresholdBeam                  - thresholdBeam Summary of this function goes here
