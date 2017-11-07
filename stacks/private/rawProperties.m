function [ theProperties ] = rawProperties( filepath )
%rawProperties Returns the properties of a iPhoton raw file.

[root, name, ext] = fileparts(filepath);

if (length(regexp(ext,'raw')) ~= 0 )
    fileID = fopen(filepath);
    txt = fread(fileID, 5000);
    txt = char(txt(find(txt>0)))';
    fclose(fileID);

    rawProperties=XMLPlistToStruct(txt);
    theProperties = struct( 'bitsPerSample',rawProperties.bitsPerSample__INTEGER, 'samplesPerPixel', rawProperties.samplesPerPixel__INTEGER, 'height', rawProperties.pixelsHigh__INTEGER, 'width', rawProperties.pixelsWide__INTEGER);
elseif (length(regexp(ext,'stack')) ~= 0 )
    levels = {'','../','../../'};
    for i = 1:length(levels)
        infoFile = fullfile(root,levels{i},'info.json');
        if exist(infoFile) 
            rawProperties = jsondecode(fileread(infoFile));
            theProperties = struct( 'bitsPerSample',16, 'samplesPerPixel', 1, 'height', rawProperties.ySize, 'width', rawProperties.xSize);
        end
    end
end


end