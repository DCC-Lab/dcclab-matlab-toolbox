function [ theImage ] = loadImage( filePath )
%loadImage Loads a microscopy image regardless of format
%   Many formats supported, such as HDF5

[root name ext ] = fileparts(filePath);

if regexp(ext, '(?:\.hd5$)|(?:\.h5$)')
    try 
        theImage = h5read(filePath, '/Image/Data');
    catch
    end
end

try 
    theImage = imread(filePath);
catch
    
end
