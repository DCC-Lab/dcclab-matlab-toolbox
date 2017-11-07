function M = beamMoment(I, i, j)
% BEAMMOMENT Unnormalized raw moments as calculated by http://en.wikipedia.org/wiki/Image_moment
%  This function calculates x^i y^j * I(x,y) over all pixels.  
%  M = BEAMMOMENT(image, 0, 0 ) calculates the energy
%  M = BEAMMOMENT(image, 1, 0 ) calculates the centroid along x
%  M = BEAMMOMENT(image, 0, 1 ) calculates the centroid along y

I = single(I); % single() is faster than double and sufficient

%  To be efficient it is useful to use a matrix description for the
%  calculation by defining factor matrices such as 1, x, y, x2, y2.  Also,
%  it is useful to make them persistent to avoid recalculating every time
%  these constant matrices.
persistent x0y0 x1y0 x0y1 x2y0 x0y2;

% We pre-allocate and keep these factor matrices, because they are
% expensive to create repeatedly. We re-allocate if 1) they have not been
% allocated or 2) if the size of the image has changed.
if isempty(x0y1) || ~isequal(size(x0y1), size(I))
    nRows = size(I, 1);
    nCols = size(I, 2);
    nChannel = size(I, 3);

    row = single(1:nCols);
    col = single(1:nRows)';

    x0y0 = ones(nRows, nCols, nChannel);
    x1y0 = repmat(row, nRows, 1, nChannel);
    x0y1 = repmat(col, 1, nCols, nChannel);
    x2y0 = x1y0 .* x1y0;
    x0y2 = x0y1 .* x0y1;
end

% Some moments are very common and it is faster to
% assign the matrix directly rather than calculate
% matrix = xMatrix.^i .* yMatrix.^j;
if ( i == 0 && j == 0 )
    matrix = x0y0;
elseif (i == 1 && j == 0)
    matrix = x1y0;
elseif (i == 0 && j == 1)
    matrix = x0y1;
elseif (i == 2 && j == 0)
    matrix = x2y0;
elseif (i == 0 && j == 2)
    matrix = x0y2;
else
    matrix = x1y0.^i .* x0y1.^j;
end

theProduct = I .* matrix;
M = squeeze(sum(sum(theProduct)));