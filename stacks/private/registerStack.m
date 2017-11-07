function [ stack ] = registerStack( stack )
%registerStack 

properties = stackProperties(stack);
roiX = [1:properties.width];
roiY = [1:properties.height];
channel = 2;%[1:properties.samplesPerPixel];

if (properties.stackArrayDimension == 1) 
    for i=1:properties.stackArraySizes(1) - 1 
        imgRef = stack(roiY, roiX, channel,i);
        img = stack(roiY, roiX, channel,i+1);

        imgCorr = calculateFrequencyCrossCorrelation(imgRef, img);
        normCor = normalizeImage(imgCorr);
        [xPeak, yPeak] = findImagePeak(imgCorr);

        xTranslation = xPeak - properties.width
        yTranslation = yPeak - properties.height
        
        translationMatrix= affine2d([1 0 0; 0 1 0; xTranslation yTranslation 1]);
        RA = imref2d([properties.height properties.width 1]);
        img = imwarp(img, RA, translationMatrix, 'OutputView', RA, 'FillValues', 0);
        
        stack(roiY, roiX, channel,i+1) = img;
    end
end


end

