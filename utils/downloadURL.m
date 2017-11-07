function [ localFilepath ] = downloadURL( url )
% Download the URL to a (temporary) local file and return the local path.
% Must be an image or a movie.

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
    [ status, output ] = unix(['DYLD_LIBRARY_PATH="";curl -L -o ' filename '.' ext ' ' url ] );
    
    if status ~= 0
        localFilepath = '';
    else
        localFilepath = [tmpFolder '/' filename '.' ext ];
    end
    cd(origFolder);
end

end

