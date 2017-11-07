function [ localFilepath ] = downloadURL( url )
%downloadURL Download the URL to a (temporary) local file and return the local path

[groups, stringMatch] = regexp(url,'^https?://(.*?)/(.*)/(.*?)\.(tif{1,2}|mov|mp4|m4v|avi|raw)','tokens','match');
server = groups{1}{1};
root = groups{1}{2};
filename = groups{1}{3};
ext = groups{1}{4};

if length(stringMatch) ~= 0
    origFolder = pwd;
    tmpFolder = tempname;
    mkdir(tmpFolder);
    cd(tmpFolder);
    if strcmp(server, 'cafeine.crulrg.ulaval.ca')
        [ status, output ] = unix(['DYLD_LIBRARY_PATH="";curl -L -o ' filename '.' ext  ' -udcclab:microscope ' url ] );
    else
        [ status, output ] = unix(['DYLD_LIBRARY_PATH="";curl -L -o ' filename '.' ext ' ' url ] );
    end
    
    if status ~= 0
        localFilepath = '';
    else
        localFilepath = [tmpFolder '/' filename '.' ext ];
    end
    cd(origFolder);
end

end

