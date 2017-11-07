function [ howMany ] = hasPrintfFormattedIndices( string ) 
    stringFormats = regexpi(string,'%(0{0,1})\d','match');

    howMany = length(stringFormats);
end