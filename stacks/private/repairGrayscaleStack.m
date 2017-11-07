function [ stack ] = repairGrayscaleStack( stack )
%repairGrayscaleStack Will add a singleton dimension if necessary to obtain
%a single channel matrix usable easily in calculations so that the 4th
%dimension is always the real stack index
p = stackProperties(stack);

if (p.imageArrayDimension == 2)
    sizes = size(stack);
    stack = reshape(stack, [sizes(1:2), 1, sizes(3:2+p.stackArrayDimension)]);
end

end
