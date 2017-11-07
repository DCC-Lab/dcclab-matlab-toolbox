function [ theNormalizedStack] = normalizeStack( theStack )
%NORMALIZESTACK Normalize intensity and corrects offset in a stack

theProperties = stackProperties(theStack);
numberOfElements = prod(theProperties.stackArraySizes);
theNormalizedStack = zeros(size(theStack), theProperties.class);

for i=1:numberOfElements
    theNormalizedStack(:,:,:,i) = normalizeImage(theStack(:,:,:,i));
end

