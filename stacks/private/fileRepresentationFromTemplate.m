function [ fileRepresentation ] = fileRepresentationFromTemplate( pathTemplate, varargin )
%filenamesArrayFromTemplate 

if nargin >= 2
    theSizes = [varargin{:}];
end

typeInfo = whos('pathTemplate');
if (strcmp(typeInfo.class,'cell') )
    fileRepresentation = pathTemplate;
elseif ( strcmp(typeInfo.class,'char') )
    % Four options: 1) real file, 2) directory, 3) template for a 1D or 4) 2D stack (-%03d)
    if ( exist(pathTemplate,'file') && ~exist(pathTemplate, 'dir'))
        fileRepresentation = {pathTemplate};  
    elseif ( length(regexpi(pathTemplate,'^http://.*?(tif{1,2}|mov|mp4|m4v)$','match')) ~= 0)
        fileRepresentation = {pathTemplate};      
    else
       if ( exist(pathTemplate, 'dir') )
            [root, name, ext] = fileparts(pathTemplate);
            if length(root) == 0
               pathTemplate = '.*.tif';
            else
               pathTemplate = [root filesep '.*.tif'];
            end
       end

       printfFormattedIndices = hasPrintfFormattedIndices(pathTemplate);
       regexpFormattedIndices = hasRegexpFormattedIndices(pathTemplate);

       if regexpFormattedIndices ~= 0
            fileRepresentation = filesMatchingRegexpPattern( pathTemplate );
            
            if length(fileRepresentation) == 0
                ME = MException('dcclab:FileNotFound', [ 'There are no files matching ' strrep(pathTemplate,'\','\\') ]);
                throw(ME);
            end
            
            % The files are loaded in alphabetical order, which means all 000-
            % come first,
            if ( regexpFormattedIndices > 1)
                theSize = [];
                for i=1:regexpFormattedIndices
                    filesForDim = regexprep(pathTemplate,'\\d\\d\\d','OHSHIT',i);                 
                    filesForDim = regexprep(filesForDim,'\\d\\d\\d','000');                 
                    filesForDim = regexprep(filesForDim,'OHSHIT','\\d\\d\\d');
                    theSize = [length(filesMatchingRegexpPattern(filesForDim)) theSize ]; 
                end
                
                if length(theSize) > 1
                    fileRepresentation = reshape(fileRepresentation, theSize);
                    fileRepresentation = permute(fileRepresentation, flip(1:regexpFormattedIndices));
                    fileRepresentation = squeeze(fileRepresentation);
                end
            end
       elseif printfFormattedIndices ~= 0
            fileRepresentation = generatePathsArrayForStack(pathTemplate, theSizes );
       elseif printfFormattedIndices == 0 && regexpFormattedIndices == 0
           [root, name, ext] = fileparts(pathTemplate);

           if  length(root) == 0
                fileRepresentation = filesMatchingRegexpPattern( [ name '-\d\d\d' ext ] );
           else
                fileRepresentation = filesMatchingRegexpPattern( [ root filesep name '-\d\d\d' ext ] );
           end

           if ( length(fileRepresentation) == 0 )
                ME = MException('dcclab:UnsupportedPath', 'The argument does not point to a file, directory or is not a template that matches files in the directory.');
                throw(ME);
           end
       else
           ME = MException('dcclab:UnsupportedPath', 'The argument does not point to a file, directory or is not a template such as file-%%03d-%%03d.tif.');
           throw(ME);
       end
    end
else
    ME = MException('dcclab:IncorrectFilenameCellArrayType', 'The input type of filenamesCellArray is incorrect (should be ''cell'' or ''char'', is ''%s'')', typeInfo.class);
    throw(ME);
end


end
