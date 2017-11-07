function [ x, y] = beamMaximum( image )
%beamMaximum Returns the averaged coordinates of the image maximum

image = sum(single(image),3);

peakList = find(image==max(image(:)));
for n=1:size(peakList,1)
    [C(n), R(n)] = ind2sub(size(image), peakList(n,1));
end

% MATLAB uses first index for rows, which means y
y = round(mean(R));
x = round(mean(C));

end

