function [ theProperties ] = stackPropertiesFromTemplate( templateRepresentation, varargin )
%stackPropertiesFromTemplate 

fileRepresentation = fileRepresentationFromTemplate(templateRepresentation, varargin);

theProperties = stackPropertiesFromFileRepresentation( fileRepresentation );

if ( hasRegexpFormattedIndices( templateRepresentation ) > 0 ) 
    theProperties.type = 'regexp';
    theProperties.regexp = templateRepresentation;
    [ root nameWithRegexep ext ] = fileparts(templateRepresentation);
    theProperties.basepath = char(strcat( root, regexp(nameWithRegexep, '^(.*?)(?=-(\\d){1,4})', 'match')));
    theProperties.ext = ext;
    theProperties.stackArraySize = 0;
    theProperties.printf = strcat(root, theProperties.basepath, repmat('-%03d',1,theProperties.stackArrayDimension), ext );
elseif ( hasPrintfFormattedIndices( templateRepresentation ) > 0 ) 
    theProperties.type = 'printf';
    theProperties.stackArraySize = 0;
    theProperties.printf = templateRepresentation;
    [ root nameWithPrintf ext ] = fileparts(templateRepresentation);
    theProperties.basepath = char(strcat( root, regexp(nameWithPrintf, '^(.*?)(?=-(%\d{1,2}d))', 'match')));
    theProperties.ext = ext;
    theProperties.stackArraySize = 0;
    theProperties.regexp = strcat(root, theProperties.basepath, repmat('-\d\d\d',1,theProperties.stackArrayDimension), ext );
else
    theProperties.type = 'string';
    [ root name ext ] = fileparts(theRepresentation);
    theProperties.basepath = char([root name]);
    theProperties.ext = ext;
    theProperties.stackArrayDimension = 0;
    theProperties.stackArraySize = 0;
end

end
