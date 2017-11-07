function [ theProperties ] = hd5fProperties( filepath )
%hd5fProperties Returns the properties of a stack stored in an HDF5 file.

try
    theStack = h5read(filepath, '/Cube/Images');
catch
    try 
        theStack = h5read(filepath, '/Image/Data');
        theStack = reshape(theStack, size(theStack,1), size(theStack,2), 1, 1);
    catch
        'Unable to';
    end
    
end


theStack = repairGrayscaleStack(theStack);

theProperties = stackPropertiesFromArray(theStack);
theProperties.type = 'hdf5';
