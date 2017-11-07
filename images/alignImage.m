function imageRegistered = alignImage(image, reference, varargin)
% ALIGNIMAGE Aligns the first image onto the second (reference) one and
% returns the aligned image

bestRegistration = false;

if nargin > 2
    if strcmpi(varagin{1},'best')
        bestRegistration = true;
    end
end    

transformEstimate = affineTransformToRegisterImage(image, reference);

coordinateView = imref2d(size(image));
imageRegistered = imwarp(image,transformEstimate,'OutputView',coordinateView);

end