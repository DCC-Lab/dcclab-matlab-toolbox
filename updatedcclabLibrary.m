function updatedcclabLibrary
%UPDATEDCCLABLIBRARY Update the library using subversion

    oldDir = pwd;
    cleanupObj = onCleanup(@() cleanup(oldDir));                

    [dcclabPath file ext ] = fileparts(which('installLibrary'));
    [tokens,matches] = regexp(dcclabPath,'(.*?)/dcclab','tokens','match');
    dcclabroot = tokens{1}{1};

    cd(dcclabPath);
    [ status, output ] = system('svn info');
    if status == 0
        [ status, output ] = system('svn update');
        if status ~= 0
            disp('Unable to update dcclab library through subversion.  Please do it manually.');
        end
    else
        [ status, output ] = system('/opt/local/bin/svn info');
        if status == 0
            [ status, output ] = system('/opt/local/bin/svn update');
            if status ~= 0
                disp('Unable to update dcclab library through subversion.  Please do it manually.');
            end
        else
            tmpDir = tempname;
            mkdir(tmpDir);
            cd(tmpDir);
            status = system('svn export svn+ssh://dcclab@cafeine.crulrg.ulaval.ca/Library/Subversion/Matlab/dcclab');

            if length(dcclabroot) ~= 0
                button = questdlg(['Do you want to update the dcclab library in ' dcclabroot ' and overwrite any changes you may have made?'],'Update dcclab library','Yes','Cancel', 'Cancel') ;
                if strcmp(button, 'Yes')
                     movefile(dcclabPath, [dcclabroot '/dcclab.old']);
                     movefile('dcclab', dcclabroot);
                end    
            end

        end

    end

end


function cleanup(oldDir)
    cd(oldDir);
end
