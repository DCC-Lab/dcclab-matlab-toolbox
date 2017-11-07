function value = isOpticalPath( object )
%ISOPTICALPATH Returns true if the object is an array of matrices (optical path)
%   Detailed explanation goes here

if ( size(size(object),2) == 3)
    value = true;
else
    value = false;    
end

end

