function drawOpticalElements( opticalPath, varargin )
%DRAWOPTICALELEMENTS Draw the optical element
%   Detailed explanation goes here

    if nargin == 2
       highestPoint = varargin{1};
    else
       highestPoint = 100;
    end
    
    loadConstants;

	[~, widthQuantum] = drawingProperties(opticalPath);
    width = widthQuantum/2;
    height = widthQuantum * 4;

    ray = extendRay([0;0], 0);
    for i=1:size(opticalPath,3);
        element = opticalPath(:,:,i);
        ray = element * ray;
        
        zf= ray(kZPositionRayIndex); % After element
        physicalLength = opticalPath(kZPositionRayIndex, k1RayIndex, i);
        zo= zf - physicalLength; % Before element
        if element(kTypeMatrixIndex) == kLensType 
            aperture = 1/opticalPath(kInverseApertureRayIndex, k1RayIndex, i);
            if isinf(aperture)
                aperture = highestPoint;
            end
            t = (0:0.001:1)'*2*pi;
            z = zo + 2*width*cos(t);
            y = aperture * sin(t);
            patch(z,y,'cyan','FaceAlpha',0.5)
        elseif element(kTypeMatrixIndex) == kGRINType 
            aperture = 1/opticalPath(kInverseApertureRayIndex, k1RayIndex, i);
            
            if isinf(aperture)
                aperture = highestPoint;
            end
            patch([ zo, zf, zf, zo], [-aperture,-aperture,aperture,aperture], 'blue','FaceAlpha',0.1,'LineStyle','none');
        
        end
        
    end

end
