function stackTIFFToMultiTIFF( basePath, combinedPath )
%STACKTIFFTOMULTITIFF Take a multi-file stack and saves it into less fiels with the last dimensions being a multi-TIFF file.

[root, name, ext]=fileparts(combinedPath);

if ( ~(strcmpi(ext,'.tif') == 1 || strcmpi(ext,'.tiff')==1) )
    ME = MException('dcclab:UnsupportedFileExtension', 'The extension must be .tif or .tiff for a multi-page tiff');
    throw(ME);                            
end

% Always write last dimension as a multi-tiff ?
stringFormats = regexpi(basePath,'\\d','match');

if ( length(stringFormats)== 0 )
    ME = MException('dcclab:MustHaveRegexp', 'You must provide an expression to match the indices');
    throw(ME);                                
end

pathArray = filesMatchingRegexpPattern(basePath); 
    
for i=1:length(pathArray)
    theImage = imread( pathArray{i} );
    
    if ( i == 1 ) 
        imwrite( theImage, combinedPath );
    else
        imwrite( theImage, combinedPath, 'WriteMode','append' );
    end
end
