function [ xc yc sigmaX sigmaY] = beamWidthGaussianFit( image )
%beamWidthGaussianFit Determine the gaussian width of a beam with a gaussian fit 

% If image is RGB, we average all planes
if ( size(size(image),2) == 3 ) 
    image = mean (image, 3);
end

backgroundValue = max(min(image));
imageBackgroundFree = image - backgroundValue;

% Fit 1D gaussian in each dimension on averaged image over other dimension
% 'gauss1' is : Y = a1*exp(-((x-b1)/c1)^2) 
meanProfile = mean(imageBackgroundFree, 1);
axis = 1:size(imageBackgroundFree,2);
result = coeffvalues( fit(axis',meanProfile','gauss1') );
xc = result(1,2);
sigmaX = result(1,3);

meanProfile = mean(imageBackgroundFree, 2);
axis = 1:size(imageBackgroundFree,1);
result = coeffvalues( fit(axis',meanProfile,'gauss1') );
yc = result(1,2);
sigmaY = result(1,3);

end

