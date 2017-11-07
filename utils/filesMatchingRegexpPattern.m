function [ files ] = filesMatchingRegexpPattern(thePattern)

    [root, name, ext] = fileparts(thePattern);

    if length(root) == 0
        f = dir();
    else
        f = dir(root);
    end
        
    files = {};
    for i=1:length(f)
        matches = regexp(f(i).name, [ name ext], 'match');
        if ( length(matches) ~= 0 )
            if length(root) == 0
                files = [ files,[ f(i).name ] ];       
            else
                files = [ files,[ root filesep f(i).name ] ];       
            end            
        end
    end
end
