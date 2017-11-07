function theStack = loadStack( varargin )
%LOADSTACK Load a stack, which may be a collection of files, a movie, a multipage TIFF. There are many ways to indicate what stack to load.
% multi-dimensional matrix filled with images. The loaded files can be
% .tif, multi-tiffs (1D array), .raw files (1D array), or an array of
% filenames organized in an cell array of the dimension of the stack. In fact,
% any image format accepted by MATLAB is accepted (use command 'imformats'
% to list them). If the format includes multi-page information, it is read
% as a stack. If the format is a movie format, it is read as a stack.
%
% A stack is the building block of many functions provided in the
% dcclab library. It represents a 1D, 2D, or 3D array 
% of images, which may themselves be grasycale (1 parameter), RGB (3
% parameters) or RGBA (4 parameters).
%
% Typically, the returned stack will be a uint8 matrix of size (H,W,SPP,S1)
% with H,W height and width, SPP samplesPerPixel and S1 the size of the 1D
% stack. A 2D stack will be (H,W,SPP,S1, S2) and a 3D stack will be
% (H,W,SPP,S1,S2,S3). Even grayscale stacks have the third dimension
% (samplesPerPixel), it is set to one.  
% 
% There are many different ways to provide input parameters to load the 
% stack from disk:
%
% 1) A single filepath with a printf-style expression or regular expression
% for indices Example: loadStack('roi-%03d.tif') or
% loadStack('roi-\d\d\d.tif') will load roi-000.tif, roi-001.tif and so on
% from the current directory until there are no other files.
% loadStack('roi-%03d-%03d.tif') will load roi-000-000.tif, roi-001-000.tif
% etc... If the filepath does not include printf-style formats, and does
% not correspond to a real file, it is assumed that the filepath is
% "name-%03d.ext" and a 1D stack is created from the matching files in the
% current directory.
%
% 2) A single directory (or no argument for current directory) will load
% all files that match '\d\d\d.tif' in that directory and make a 1D stack.
% Example: loadStack() or loadStack('/Users/dcclab/Desktop/ROI/')
%
% 3) a 1D, 2D, 3D cell array of filepaths with a regular expression for indices, 
% with or without a directory. This can be generated from
% generateFilepathsFor1DStack() or generateFilepathsFor2DStack().
% Example: files = generateFilepathsFor1DStack('roi-%03d.tif', 20) 
% loadStack(files) (the function is currently private)
%
% The cell array can be of any dimension: 1-D can be a theta-stack, 
% a Z-stack, time series, 2-D could be XY map or ZT stack, 3-D can be XYZ.
% There is no interpretation of the data, simply a loading of the data into
% memory. For example, if the cell array of filenames is 2D and of size a x b, and images are 
% M x N x rgb images, then the final stack will be M x N x 3 x a x b.
% You would extract a given image with stack(:,:,:,i,j)

% The strategy in the function is to first determine the filenamesArray,
% then iterate through each to build the stack of the same dimensionality.

if nargin == 0
    pathTemplate = '.*.tif';
    fileRepresentation = {};
elseif nargin == 1
    pathTemplate = varargin{1};
    
    [groups, stringMatch] = regexp(pathTemplate,'^https?://','tokens','match');
    if length(stringMatch) ~= 0
        pathTemplate = downloadURL(pathTemplate);        
    end
    fileRepresentation = fileRepresentationFromTemplate(pathTemplate);
elseif nargin == 2
    pathTemplate = varargin{1};
    indices= varargin{2};
    fileRepresentation = fileRepresentationFromTemplate(pathTemplate, indices);
end

progressHandle = showProgress(0,'Loading stack');
cleanupObj = onCleanup(@() cleanupProgressBar(progressHandle));                

% The strategy for dealing with multi-dimensional arrays is to "unroll"
% the dimensions: we can always access any multidimensional array with a
% single index, and reshape the final array at the end.
% One annoyance : everything is at least a 2D matrix, hence a 1D row or
% column is a 1 x n or n x 1 matrix.  Any dimension of size 1 is called a
% singleton.

theProperties = stackProperties( fileRepresentation );


if (theProperties.stackArrayDimension == 1 )
    if ( prod(size(fileRepresentation)) == 1 && length(regexp(fileRepresentation{1},'.tif{1,2}')) ~= 0 )
        
        theStack= zeros( theProperties.height, theProperties.width, theProperties.samplesPerPixel, theProperties.stackArraySizes(1),theProperties.class );
        theFile = Tiff(fileRepresentation{1},'r');
        for i=1:theProperties.stackArraySizes
            theFile.setDirectory(i);
            theFrame = theFile.read();
            showProgress( i / prod(theProperties.stackArraySizes), ['Loading ' pathTemplate], progressHandle);
            theStack(:, :, :, i) = theFrame;
        end
        theFile.close();
    elseif ( prod(size(fileRepresentation)) == 1 && length(regexp(fileRepresentation{1},'.h5|hdf5"hd5')) ~= 0 )
        try 
            theStack = h5read(fileRepresentation{1}, '/Cube/Images');
        catch 
            theStack = h5read(fileRepresentation{1}, '/Image/Data');
        end
        
        theStack = repairGrayscaleStack(theStack);
    else            
        for i=1:theProperties.stackArraySizes
            theStack(:,:,:,i) = frameFromFileRepresentation(fileRepresentation, i);
            showProgress( i / prod(theProperties.stackArraySizes), [ 'Loading ' pathTemplate], progressHandle);
        end
    end
elseif (theProperties.stackArrayDimension == 2 )
    for l=1:theProperties.stackArraySizes(2)
        for k=1:theProperties.stackArraySizes(1)
            theStack(:,:,:,k,l) = frameFromFileRepresentation(fileRepresentation, [k l]);
            index = sub2ind(theProperties.stackArraySizes, k,l);
            showProgress( index / prod(theProperties.stackArraySizes), [ 'Loading ' pathTemplate], progressHandle);
        end
    end
elseif (theProperties.stackArrayDimension == 3 )
     for m=1:theProperties.stackArraySizes(3)
        for l=1:theProperties.stackArraySizes(2)
            for k=1:theProperties.stackArraySizes(1)
                theStack(:,:,:,k,l,m) = frameFromFileRepresentation(fileRepresentation, [k l m]);
                index = sub2ind(theProperties.stackArraySizes, k,l,m);
                showProgress( index / prod(theProperties.stackArraySizes), [ 'Loading ' pathTemplate], progressHandle);
            end
        end
    end
elseif (theProperties.stackArrayDimension == 4 )
    for l=1:theProperties.stackArraySizes(4)
        for k=1:theProperties.stackArraySizes(3)
            for j=1:theProperties.stackArraySizes(2)
                for i=1:theProperties.stackArraySizes(1)
                    theStack(:,:,:,i,j,k,l) = frameFromFileRepresentation(fileRepresentation, [i j k l]);
                    index = sub2ind(theProperties.stackArraySizes, i,j,k,l);
                    showProgress( index / prod(theProperties.stackArraySizes), [ 'Loading ' pathTemplate], progressHandle);
                end
            end
        end
    end
else

end

end

function cleanupProgressBar(h)
    if ishandle(h) 
        close(h);
    end
end
