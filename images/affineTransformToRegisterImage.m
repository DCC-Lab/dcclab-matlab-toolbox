function theTransform = affineTransformToRegisterImage(image, reference)
% affineTransformToRegisterImage Returns the transform that aligns the two
% images

imageFiltered = mean(image,3);
referenceFiltered = mean(reference,3);
theTransform = imregcorr(imageFiltered,referenceFiltered,'translation');

end