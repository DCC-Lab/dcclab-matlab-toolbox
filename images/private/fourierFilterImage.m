function [ outImage ] = fourierFilterImage( image, fourierMask )
%fourierFilterImage Function that multiplies an image by a mask in the
%Fourier domain

inputImageClass = class(image);

if ( size(size(fourierMask),2) == 2 )
    fourierMask = repmat(fourierMask(:,:,1), [ 1 1 size(image,3) ]);
end

IM = fftshift( fft2( double(image) ) ); 

IP = IM .* fourierMask; 

outImage = cast(abs(ifft2(ifftshift(IP))), inputImageClass);

end

