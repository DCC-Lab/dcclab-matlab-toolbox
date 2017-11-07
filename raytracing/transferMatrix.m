function [ transferMatrix  ] = transferMatrix( thePath )
%TRANSFERMATRIX Calculates the product of all matrices in a path, and returns the trandfer matrix
%   Detailed explanation goes here

transferMatrix = eye( size(thePath,1), size(thePath,2));

for i=1:size(thePath,3)
    transferMatrix = thePath(:,:,i) * transferMatrix;
end

end

