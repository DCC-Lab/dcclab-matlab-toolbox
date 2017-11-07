function freespace = isFreespace( matrix )
%ISFREESPACE Returns true if the matrix is a freespace matrix
%   Detailed explanation goes here

loadConstants;

freespace = true;

if isExtended(matrix) 
    if matrix(kIndexType) == kFreespaceType
        freespace = true;
    end
else
    if (matrix(1,1) == 1) && (matrix(2,1) == 1)

    end
end

end

