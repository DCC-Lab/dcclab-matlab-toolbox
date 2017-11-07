function saveStack( stackRepresentation, baseTemplate )
%SAVESTACK Save a stack from memory onto disk. The stack can be saved as a multi-page tiff, separate files, or a movie.
% 
% Usage: saveStack(theStack, '/Users/joe/Test.tif') or saveStack(theStack, 'Test-%04d.tif')

theProperties = stackProperties(stackRepresentation);

if ( ~strcmp(theProperties.type,'memory' ) )  
    theStack = loadStack(stackRepresentation);
else
    theStack = stackRepresentation;
end

[root name ext ] = fileparts(baseTemplate);
if ~exist(root) && length(root) ~= 0
    mkdir(root);
end

progressHandle = showProgress(0,'Saving stack');
cleanupObj = onCleanup(@() cleanupProgressBar(progressHandle));                

numberOfIndices = hasPrintfFormattedIndices(baseTemplate);
type = 'files';
if numberOfIndices ~= theProperties.stackArrayDimension
   if  numberOfIndices == theProperties.stackArrayDimension - 1
       if regexp(ext, '(?:\.mp4$)|(?:\.mov$)|(?:\.avi$)|(?:\.tif{1,2})')
           type = 'multipage files';
           fileIndexSizes = theProperties.stackArraySizes(1:numberOfIndices);
           pageIndexSize = theProperties.stackArraySizes(theProperties.stackArrayDimension);
       else
           ME = MException('dcclab:TemplateMissing', 'You must provide a valid template with one %03d per dimension in your stack, or provide a file format such as TIFF that accepts many images per file');
           throw(ME);       
       end
   else
       ME = MException('dcclab:TemplateMissing', 'You must provide a valid template with one %03d per dimension in your stack, or provide a file format such as TIFF that accepts many images per file');
       throw(ME);                            
   end
else
   fileIndexSizes = theProperties.stackArraySizes;
   pageIndexSize = 0;
end

stackArraySizes = theProperties.stackArraySizes;

if numberOfIndices == 0
    filenamesCellArray{1} = baseTemplate;
else
    filenamesCellArray = generatePathsArrayForStack(baseTemplate, fileIndexSizes);
end

if (theProperties.stackArrayDimension == 1 )
    if strcmp(type,'multipage files')
        framesToFile(theStack, filenamesCellArray{1}, 1:stackArraySizes(1) );
    else
        for i=1:theProperties.stackArraySizes
            framesToFile(theStack, filenamesCellArray{i}, i);
            showProgress( i / theProperties.stackArraySizes(1), [ 'Saving ' baseTemplate], progressHandle);
        end
    end
elseif (theProperties.stackArrayDimension == 2 )    
    for i=1:stackArraySizes(1)
        if strcmp(type,'multipage files')
            indices = sub2ind(stackArraySizes, repmat(i, 1,stackArraySizes(2)), 1:stackArraySizes(2));
            framesToFile(theStack, filenamesCellArray{i}, indices );
        else
            for j=1:stackArraySizes(2)
                index = sub2ind(stackArraySizes, i, j);
                framesToFile(theStack, filenamesCellArray{i,j}, index);    
                showProgress( i / theProperties.stackArraySizes(1), [ 'Saving ' baseTemplate], progressHandle);
            end
        end
    end
elseif (theProperties.stackArrayDimension == 3 )
    for i=1:theProperties.stackArraySizes(1)
        for j=1:theProperties.stackArraySizes(2)
            if strcmp(type,'multipage files')
                indices = sub2ind(stackArraySizes, repmat(i, 1,stackArraySizes(3)), repmat(j, 1,stackArraySizes(3)), 1:stackArraySizes(3));
                framesToFile(theStack, filenamesCellArray{i,j}, indices );
            else
                for k=1:theProperties.stackArraySizes(3)
                    index = sub2ind(theProperties.stackArraySizes, i, j, k);
                    framesToFile(theStack, filenamesCellArray{i,j,k}, index);    
                    showProgress( i / theProperties.stackArraySizes(1), [ 'Saving ' baseTemplate], progressHandle);
                end
            end
        end
    end

elseif (theProperties.stackArrayDimension == 4 )
    for i=1:theProperties.stackArraySizes(1)
        for j=1:theProperties.stackArraySizes(2)
            for k=1:theProperties.stackArraySizes(3)
                if strcmp(type,'multipage files')
                    indices = sub2ind(stackArraySizes, repmat(i, 1, stackArraySizes(4)), repmat(j, 1, stackArraySizes(4)),repmat(k, 1, stackArraySizes(4)), 1:stackArraySizes(4));
                    framesToFile(theStack, filenamesCellArray{i,j,k}, indices );
                else
                    for l=1:theProperties.stackArraySizes(4)
                        index = sub2ind(theProperties.stackArraySizes, i, j, k,l);
                        framesToFile(theStack, filenamesCellArray{i,j,k,l}, index);    
                        showProgress( i / theProperties.stackArraySizes(1), [ 'Saving ' pathTemplate], progressHandle);
                    end
                end
            end
        end
    end
end

end


function cleanupProgressBar(h)
    if ishandle(h) 
        close(h);
    end
end

