function [ output_args ] = fixStackNumbering( varargin )
%fixStackNumbering Fix files making up a stack by creating empty files when needed.

fileRepresentation = fileRepresentationFromTemplate(varargin{:});

properties = {};

for i=1:prod(size(fileRepresentation))
    filePath = fileRepresentation{i};
    if exist(filePath, 'file')
        imageTemplate = imread(filePath);
        imageTemplate(:) = 0;
        break
    end
end

for i=1:prod(size(fileRepresentation))
    filePath = fileRepresentation{i};
    if ~exist(filePath, 'file')
        imwrite(imageTemplate, filePath);
    end
end

