function [ theProperties ] = stackPropertiesFromFileRepresentation( fileRepresentation )
%stackRepresentationProperties 

theProperties=struct;
theSize = size(fileRepresentation);
theProperties.stackArraySizes = theSize(theSize>1);
theProperties.stackArrayDimension = length(theSize(theSize>1));
theProperties.type = 'files';

imgData=[];

filename = fileRepresentation{1};

if ( ~exist(filename) )
    ME = MException('dcclab:FileNotFound', 'The file %s cannot be found in directory %s', filename, pwd);
    throw(ME);                            
end


[root, name, ext] = fileparts(filename);
if strcmp(ext,'.raw') 
   theProperties = rawProperties(filename);
   if theProperties.bitsPerSample ~= 8
        ME = MException('dcclab:UnsupportedBitsPerSample', 'The raw file is not 8-bits per sample. This is not yet suported');
        throw(ME);            
   end
   pageSizeInBytes = theProperties.height * theProperties.width * theProperties.samplesPerPixel;
   fileProperties = dir(filename);
   numberOfPages = uint32(fileProperties.bytes / pageSizeInBytes - 1);
   if theProperties.samplesPerPixel == 4
       theProperties.hasAlpha = true;
   else
       theProperties.hasAlpha = false;
   end
   
   theProperties.type = 'multipage files';
   theProperties.class = 'uint8';
   theProperties.bitsPerSample = 8;
   theProperties.stackArrayDimension = 1;
   theProperties.stackArraySizes = [ numberOfPages ];
   theProperties.imageArrayDimension = 3;
elseif strcmp(ext,'.stack')
   theProperties = rawProperties(filename);
   if theProperties.bitsPerSample ~= 16
        ME = MException('dcclab:UnsupportedBitsPerSample', 'The stack file is not 16-bits per sample. This is not yet suported');
        throw(ME);            
   end
   pageSizeInBytes = theProperties.height * theProperties.width * theProperties.samplesPerPixel * theProperties.bitsPerSample / 8;
   fileProperties = dir(filename);
   numberOfPages = uint32(fileProperties.bytes / pageSizeInBytes - 1);
   if theProperties.samplesPerPixel == 4
       theProperties.hasAlpha = true;
   else
       theProperties.hasAlpha = false;
   end
   
   theProperties.type = 'multipage files';
   theProperties.class = 'uint8';
   theProperties.bitsPerSample = 8;
   theProperties.stackArrayDimension = 1;
   theProperties.stackArraySizes = [ numberOfPages ];
   theProperties.imageArrayDimension = 3;    
elseif ( strcmp(ext,'.h5') || strcmp(ext,'.hdf5') || strcmp(ext,'.hd5') )
    theProperties = hdf5Properties(filename);
else
    try % any MATLAB readable image file
        fileInfo = imfinfo(filename);
        numberOfPages = length(fileInfo);
        if ( numberOfPages > 1 )
            pageData = imread( filename, 1 );
            theProperties.stackArraySizes = [ theProperties.stackArraySizes, numberOfPages ];
            theProperties.stackArrayDimension = theProperties.stackArrayDimension+1;
            theProperties.type = 'multipage files';
        else
            pageData = imread( filename );
            theProperties.type = 'files';
        end
        typeInfo = whos('pageData');
           
        theProperties = setfield(theProperties, 'class', typeInfo.class);
        if strcmp(typeInfo.class, 'uint8') || strcmp(typeInfo.class, 'int8') 
            bitsPerSample = 8;
        elseif strcmp(typeInfo.class, 'uint16') || strcmp(typeInfo.class, 'int16') 
            bitsPerSample = 16;
        elseif strcmp(typeInfo.class, 'single')
            bitsPerSample = 32;
        elseif strcmp(typeInfo.class, 'double')
            bitsPerSample = 64;
        end
        theProperties = setfield(theProperties, 'bitsPerSample', bitsPerSample);

        pageSizeInBytes = size(pageData);
        if ( size(pageSizeInBytes,2) == 2 )
              pageSizeInBytes(3)=1; 
        end
        theProperties = setfield(theProperties, 'height', pageSizeInBytes(1));
        theProperties = setfield(theProperties, 'width', pageSizeInBytes(2) );
        theProperties = setfield(theProperties, 'samplesPerPixel', pageSizeInBytes(3) );
        theProperties = setfield(theProperties, 'imageArrayDimension', 3 );
        theProperties = setfield(theProperties, 'hasAlpha', pageSizeInBytes(3) == 4 );
    catch
        try % any MATLAB readable movie file
            movieObject = VideoReader(filename);
            numberOfPages = movieObject.NumberOfFrames;
            theProperties = setfield(theProperties, 'width', movieObject.Width);
            theProperties = setfield(theProperties, 'height', movieObject.Height );
            pageData = read(movieObject, 1);

            typeInfo = whos('pageData');
           
            theProperties = setfield(theProperties, 'class', typeInfo.class);
            if strcmp(typeInfo.class, 'uint8') || strcmp(typeInfo.class, 'int8') 
                bitsPerSample = 8;
            elseif strcmp(typeInfo.class, 'uint16') || strcmp(typeInfo.class, 'int16') 
                bitsPerSample = 16;
            elseif strcmp(typeInfo.class, 'single')
                bitsPerSample = 32;
            elseif strcmp(typeInfo.class, 'double')
                bitsPerSample = 64;
            end
            theProperties = setfield(theProperties, 'bitsPerSample', bitsPerSample);

            theProperties.type = 'multipage files';

            pageSizeInBytes = size(pageData);
            pageDims = size(pageSizeInBytes,2);       
            theProperties = setfield(theProperties, 'samplesPerPixel', pageDims );
            theProperties = setfield(theProperties, 'stackArrayDimension', 1);
            theProperties = setfield(theProperties, 'stackArraySizes', [ numberOfPages ]);
        catch err
            throw (err);

            ME = MException('dcclab:UnsupportedFileFormat', 'The file is not readable by MATLAB imread() or VideoReader()');
            throw(ME);                            
        end
   end
end

%properties = struct('height', height, 'width', width, 'samplesPerPixel', samplesPerPixel,'class', typeInfo.class, 'bitsPerSample', bitsPerSample, 'hasAlpha', hasAlpha, 'imageArrayDimension', imageArrayDimension, 'stackArrayDimension', stackArrayDimension, 'stackArraySizes', stackArraySizes );

end

