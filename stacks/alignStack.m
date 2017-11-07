function [ alignedStack ] = alignStack( theStack )
%ALIGNSTACK Align a 1D stack.

theProperties = stackProperties(theStack);

if theProperties.stackArrayDimension ~= 1
    ME = MException('dcclab:IncorrectStackDimension', 'Only 1D stacks can be aligned at this time');
    throw(ME);                            
end

alignedStack = theStack(:,:,:,1);

for i=2:theProperties.stackArraySizes(1)
    alignedStack(:,:,:,i) = alignImage(theStack(:,:,:,i),alignedStack(:,:,:,i-1));
end

