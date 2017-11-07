function [ theProperties ] = stackProperties ( someObject , varargin)
%STACKPROPERTIES Returns the properties of a stack in the form of a structure (number of images, dimensions, number of channels, etc...)
%
% A stack can be 1) a numeric array of dimension 4D or more
%                2) a path with regexp (will match from files)
%                3) a path with printf-indices (i.e. %03d) and Nx, Ny, Nz... for each
%                dimension, in a single array
%                4) a cell array of dimension 1D, 2D, 3D with paths
% 
% We then return the following properties:
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

typeInfo = whos('someObject');

if ( isnumeric(someObject) )
    theProperties = stackPropertiesFromArray( someObject );
elseif ( ischar( someObject) )
    if ( hasRegexpFormattedIndices(someObject) )
        theProperties = stackPropertiesFromTemplate( someObject );
    elseif ( hasPrintfFormattedIndices(someObject) )
        fileRepresentation = generatePathsArrayForStack( someObject, varargin{1});
        theProperties = stackPropertiesFromFileRepresentation( fileRepresentation );
        theProperties.printf = someObject;
    else
        theProperties = stackPropertiesFromFileRepresentation( {someObject} );    
    end
elseif ( isequal(typeInfo.class, 'cell')  )
    theProperties = stackPropertiesFromFileRepresentation( someObject);    
end

