function [ imgData ] = frameFromFileRepresentation( fileRepresentation, indices )
%frameFromFileRepresentation Reads a single frame from a multidimensional
%stack
%   It is possible that the file format supports an additional dimension
%   (e.g., multi-page tiffs, or mov).  Hence, we need to figure out two
%   indices: the fileIndex (in the fileRepresentation array) and the
%   pageIndex (intra-file array)

theProperties = stackProperties(fileRepresentation);

switch ( theProperties.stackArrayDimension ) 
    case 0
        pageIndex = indices(1); % single file, could be .raw, .tif, .mov
        stackArrayDimensions = 1;
    case 1
        if strcmp(theProperties.type, 'multipage files')
            pageIndex = indices(1);
            fileIndex = 1;
        else
            pageIndex = 0;
            fileIndex = indices(1);
        end
    case 2
        if strcmp(theProperties.type, 'multipage files')
            if size(indices,2) == 2
                fileIndex = indices(1);
                pageIndex = indices(2);
            else
                [fileIndex, pageIndex ] = ind2sub(theProperties.stackArraySizes, indices(1));
            end
                        
        else
            if size(indices,2) == 2
                fileIndex = sub2ind( theProperties.stackArraySizes, indices(1), indices(2));
                pageIndex = 0;
            else
                fileIndex = indices(1);
                pageIndex = 0;
            end            
        end
    case 3
        if strcmp(theProperties.type, 'multipage files')
            if size(indices,2) == 3
                fileIndex = sub2ind( theProperties.stackArraySizes(1:2), indices(1), indices(2));
                pageIndex = indices(3);
            else
                [fileIndex(1), fileIndex(2), pageIndex ] = ind2sub(theProperties.stackArraySizes, indices(1));
            end
        else
            if size(indices,2) == 3
                fileIndex = sub2ind( theProperties.stackArraySizes, indices(1), indices(2), indices(3));
                pageIndex = 0;
            else
                fileIndex = indices(1);
                pageIndex = 0;
            end
        end
        
    case 4
        if size(indices,2) == 4
            fileIndex = sub2ind( theProperties.stackArraySizes, indices(1), indices(2), indices(3), indices(4));
        else
            fileIndex = indices(1);
        end

end

imgData=[];

filename = fileRepresentation{fileIndex};
[root, name, ext] = fileparts(filename);
if strcmp(ext,'.raw')
    pageSize = theProperties.height * theProperties.width * theProperties.samplesPerPixel;

    fileID = fopen(filename);
    fseek( fileID, pageIndex * pageSize, 'bof'); % drop first frame

    pageData = fread( fileID, pageSize,'uint8=>uint8' );
    pageData = reshape(pageData, [theProperties.samplesPerPixel theProperties.width,  theProperties.height] );
    pageData = permute(pageData, [3 2 1]);
    pageData = pageData(:,:,[1:3]); % always strip alpha
    imgData = pageData;

    fclose(fileID);
elseif strcmp(ext,'.stack') 
    pageSizeInElements = theProperties.height * theProperties.width * theProperties.samplesPerPixel; %% are always 16-bits
    pageSizeInBytes = pageSizeInElements*2; % always 16-bits

    fileID = fopen(filename);
    fseek( fileID, (pageIndex - 1)* pageSizeInBytes, 'bof'); % drop first frame

    pageData = fread( fileID, pageSizeInElements,'uint16=>uint16' );
    pageData = reshape(pageData, [theProperties.samplesPerPixel theProperties.width,  theProperties.height] );
    pageData = permute(pageData, [3 2 1]);
    imgData = pageData;

    fclose(fileID);
else
    try % any MATLAB readable image file
        fileInfo = imfinfo(filename);
        numberOfPages = length(fileInfo);
        if pageIndex ~= 0
            imgData = imread( filename, pageIndex );
        else
            imgData = imread( filename );
        end
    catch
        try % any MATLAB readable movie file
            movieObject = VideoReader(filename);
            if pageIndex ~= 0
                imgData = read(movieObject, pageIndex);
            else
                ME = MException('dcclab:MissingPageIndex', 'There should be an additional index for movies');
                throw(ME);                            
            end
        catch err
            throw (err);
            ME = MException('dcclab:UnsupportedFileFormat', 'The file is not readable by MATLAB imread() or VideoReader()');
            throw(ME);                            
        end
   end
end

theProperties = imageProperties(imgData);

if theProperties.imageArrayDimension == 2
   imgData = reshape(imgData, size(imgData,1), size(imgData,2), 1);
end
end

