function filenameCellArray = generatePathsArrayForStack(basePath,  theSizes)

stackDimension = hasPrintfFormattedIndices(basePath);

if ( stackDimension == 0 )
	ME = MException('dcclab:IncorrectTemplate', 'For a stack, the basePath should include a single format template for integers such as %%03d');
    throw(ME);
end

if ( stackDimension ~= size(theSizes, 2) ) 
	ME = MException('dcclab:IncorrectSizes', 'The number of formatted indices (%%03d) must match the size array');
    throw(ME);    
end

if ( stackDimension == 1)
   theSizes = [ theSizes 1 ];
end

filenameCellArray={};
numPoints = prod(theSizes);

for i=1:numPoints
    [x,y,z,t] = ind2sub(theSizes,i);
    switch ( stackDimension ) 
        case 1
            filenameCellArray{i} = sprintf(basePath, x-1);
        case 2
            filenameCellArray{i} = sprintf(basePath, x-1, y-1);
        case 3
            filenameCellArray{i} = sprintf(basePath, x-1, y-1, z-1);
        case 4
            filenameCellArray{i} = sprintf(basePath, x-1, y-1, z-1, t-1);
    end
end

filenameCellArray=reshape(filenameCellArray, theSizes);