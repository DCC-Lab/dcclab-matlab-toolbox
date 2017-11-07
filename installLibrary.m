%installLibrary.m Script to install the dcclab library.
% This script will install the dcclab files in a directory such that 
% they are available to all users. Administrator privileges are needed.
% 
% OS X: the files are installed in '/Library/Application Support/MATLAB'
% Win : currently not supported (where to install? user or computer?)

% Strategy for the script: it assumes this script is at the top-level of
% the library. It figures out where we are, get the directories for the
% library (there could be many and new ones may be added) and remove any
% hidden directory (.svn and such), figures out what platform we are
% running on then copy the files to an OS-specific directory and add to
% MATLAB path for all users.

[currentPath, name, ext] = fileparts(mfilename('fullpath'));
filesToInstall = dir(currentPath);
j=1;
directories=cell(1,1);
for (i=1:length(filesToInstall))
    if ( filesToInstall(i).isdir && filesToInstall(i).name(1) ~= '.' )
        directories{j} = filesToInstall(i).name;
        j=j+1;
    end
end

if (ismac)
    MATLABSUPPORTROOT='/Library/Application Support/MATLAB';
    LIBROOT=strcat(MATLABSUPPORTROOT, '/', 'dcclab');
elseif (ispc)
    errordlg('Ce script ne peut installer la librarie automatiquement sur ce PC.\n\nManuellement, copiez le repertertoire dcclab à un endroit sur votre machine, et ajoutez dcclab/ et ses sous-repertoires au path de MATLAB');
    pathtool;
    ME = MException('dcclab:SystemNotSupported', 'Unable to install on systems other than Macs');
    throw(ME);
end

if ( exist(MATLABSUPPORTROOT) == 0 ) 
    if (ismac)
        !osascript -e 'tell application "Finder" to make new folder at folder "Application Support" of folder "Library" of startup disk with properties {name:"MATLAB"}'
    else
        ME = MException('dcclab:SystemNotSupported', 'Unable to install on systems other than Macs');
        throw(ME);
    end
end

if ( exist(strcat(LIBROOT)) == 0 )
    if (ismac)
        !osascript -e 'tell application "Finder" to make new folder at folder "MATLAB" of folder "Application Support" of folder "Library" of startup disk with properties {name:"dcclab"}'
    else
        ME = MException('dcclab:SystemNotSupported', 'Unable to install on systems other than Macs');
        throw(ME);
    end
end


copyfile('*', LIBROOT);

% Add to MATLAB path LIBROOT and subdirectories
path(LIBROOT, path);
for (i=1:length(directories))
    path( strcat(LIBROOT,'/',directories{i}), path);
end

% Save to MATLAB path for all users. This may fail without privileges.
savepath

disp('Success. You may try loadStack(''file.raw'').');
disp(['You may also run the tests to confirm everything is working fine:']);
disp(['cd ''' LIBROOT '/tests'';runMyTests']);
