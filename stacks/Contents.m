% STACKS
%
%
% 
% Files
%   loadStack            - Load a stack, which may be a collection of files, a movie, a multipage TIFF. There are many ways to indicate what stack to load.
%   saveStack            - Save a stack from memory onto disk. The stack can be saved as a multi-page tiff, separate files, or a movie.
%
% Observe stacks
%   stackProperties      - Returns the properties of a stack in the form of a structure (number of images, dimensions, number of channels, etc...)
%   stackShow            - Display a stack in a simplistic window.
%
% Transform stacks
%   alignStack           - Align a 1D stack.
%   normalizeStack       - Normalize intensity and corrects offset in a stack
%   stackTIFFToMultiTIFF - Take a multi-file stack and saves it into less fiels with the last dimensions being a multi-TIFF file.
%
% Very large stacks
%   Stack                - A Stack behaves like a multidimensionnal matrix but does not load all
%   fixStackNumbering    - fixStackNumbering Fix files making up a stack by creating empty files when needed.
