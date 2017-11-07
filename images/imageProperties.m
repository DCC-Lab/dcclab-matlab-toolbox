function [ theProperties ] = imageProperties( theObject )
%imageProperties Returns a structure with general properties of the image
% If a stack (i.e. more than 3D) is passed, the first image is used.
if length(size(theObject)) > 3
    theImage = theObject(:,:,:,1);
else
    theImage = theObject;
end

theProperties.width = size(theImage,1);
theProperties.height = size(theImage,2);
theProperties.sampelsPerPixel = size(theImage,3);
theProperties.imageArrayDimension = length(size(theImage));

if ( theProperties.sampelsPerPixel == 4 ) 
    theProperties.hasAlpha = true;
else
    theProperties.hasAlpha = false;
end

typeInfo = whos('theImage');

if strcmp(typeInfo.class, 'uint8') || strcmp(typeInfo.class, 'int8') 
    bitsPerSample = 8;
elseif strcmp(typeInfo.class, 'uint16') || strcmp(typeInfo.class, 'int16') 
    bitsPerSample = 16;
elseif strcmp(typeInfo.class, 'single')
    bitsPerSample = 32;
elseif strcmp(typeInfo.class, 'double')
    bitsPerSample = 64;
else
    ME = MException('dcclab:UnrecognizedBitsPerSample', ['The image type ' typeInfo.class ' is not recognized']);
    throw(ME);                            
end

theProperties.bitsPerSample = bitsPerSample;
theProperties.class = typeInfo.class;

end

