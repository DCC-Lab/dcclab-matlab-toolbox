function outImage = highPassFilterImage(image, normalizedCutoff) 
% normalizedCutoff is the circular cutoff frequency which is normalized to [0 1], that is, 
% the highest radian frequency \pi of digital signals is mapped to 1.

fourierMask = 1 - circularMaskAtCenter(image, normalizedCutoff );

outImage = fourierFilterImage(image, fourierMask);

