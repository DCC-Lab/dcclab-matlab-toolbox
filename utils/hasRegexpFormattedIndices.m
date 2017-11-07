function [ howMany ] = hasRegexpFormattedIndices( string ) 
    stringFormats = regexpi(string,'(\\d:?){1,3}','match');
    % FIXME: [tok,str]=regexp('\d-\d\d-\d\d\d-\d{1,3}-\d{3}-\d?-\d+-\d*-\d*?','(\\d\{\d(,\d)?\})|(\\d(*|+)?(\??)){1,4}','tokens','match')
    % THis insane regexp will match a regexp (!)
    howMany = length(stringFormats);
end

