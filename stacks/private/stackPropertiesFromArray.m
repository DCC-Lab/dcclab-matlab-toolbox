function [ theProperties ] = stackPropertiesFromArray( stack )
%stackProperties returns a structure with the properties of an image stack.
%
%                  height: image height (size of first dimension of matrix)
%                   width: image width (size of second dimension of matrix)
%         samplesPerPixel: (size of third dimension of matrix)
%                   class: pixel class 'uint8'
%           bitsPerSample: number of bits of a single pixel
%                hasAlpha: 1 if samples per pixel is 4
%     imageArrayDimension: actual dimension of image data. Could be 2 if grayscale
%                          but will be 3 otherwise (third dimension could
%                          be of size 1)
%     stackArrayDimension: dimension of the actual stack, that is : dimension
%                          of the array that contains images (1,2 3)
%         stackArraySizes: array of sizes for each stackArrayDimension

stackSizes = size(stack);
dimensions = size(stackSizes,2);
if dimensions == 2
    stackSizes = [stackSizes(1),stackSizes(2),1,1];
    dimensions = size(stackSizes,2);
end

height = stackSizes(1);
width = stackSizes(2);

thirdDimension = stackSizes(3);
if ( thirdDimension > 4 )
    samplesPerPixel = 1;
    imageArrayDimension = 2;
else
    samplesPerPixel = thirdDimension;
    imageArrayDimension = 3;
end

if ( samplesPerPixel == 4 ) 
    hasAlpha = true;
else
    hasAlpha = false;
end

typeInfo = whos('stack');

if strcmp(typeInfo.class, 'uint8') || strcmp(typeInfo.class, 'int8') 
    bitsPerSample = 8;
elseif strcmp(typeInfo.class, 'uint16') || strcmp(typeInfo.class, 'int16') 
    bitsPerSample = 16;
elseif strcmp(typeInfo.class, 'single')
    bitsPerSample = 32;
elseif strcmp(typeInfo.class, 'double')
    bitsPerSample = 64;
end

stackArrayDimension = dimensions - imageArrayDimension;

stackArraySizes = stackSizes(imageArrayDimension+1:dimensions);

theProperties = struct('type','memory', 'height', height, 'width', width, 'samplesPerPixel', samplesPerPixel,'class', typeInfo.class, 'bitsPerSample', bitsPerSample, 'hasAlpha', hasAlpha, 'imageArrayDimension', imageArrayDimension, 'stackArrayDimension', stackArrayDimension, 'stackArraySizes', stackArraySizes );

end

