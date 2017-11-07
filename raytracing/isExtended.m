function extended = isExtended( object )
%ISEXTENDED Returns whether or not the ray or matrix is extended
%   Detailed explanation goes here

sizes = size(object);

if sizes(1) > 2
   extended = true;
else
    extended = false;
end

end

