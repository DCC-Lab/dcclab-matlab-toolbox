function [abcdExtendedMatrix] = extendMatrix(matrix, length, apertureSize, varargin)
%EXTENDMATRIX Returns an extended version of the provided ABCD matrix that includes physical length, aperture size and optional apertureAngle (defaults to pi/2).

apertureAngle = pi;
if nargin == 4
    apertureAngle = varargin{1};
end

if apertureAngle == 0
   apertureAngle 
end

% Matrix :  [ A B; C D]
% Extended matrix :    [ A B 0 0 0 0 0 0  ] 
% L : length           [ C D 0 0 0 0 0 0  ]
% a : inverse aperture [ 0 0 1 0 0 0 0 L  ]
% T: type              [ 0 0 0 0 0 0 0 a  ]
%                      [ 0 0 0 0 0 0 0 ang]
%                      [ 0 0 0 0 1 0 0 1  ]
%                      [ 0 0 0 0 0 0 0 T  ]
%                      [ 0 0 0 0 0 0 0 1  ]
%
% Extended ray       [ r    ]
%                    [ theta]
%  z : position      [ z    ]
%  a : aperture      [ a    ]
%                    [ ang  ]
%                    [ index]
%                    [ T    ]
%                    [ 1    ]

% ray'               [ Ar + B theta ]
%                    [ Cr + D theta ]
%  z : position      [ z + L        ]
%  a : aperture      [ a'           ]
%                    [ ang          ]
%                    [ index + 1    ]
%                    [ T            ]
%                    [ 1            ]

loadConstants;


%Extend matrix
a = matrix(1,1);
b = matrix(1,2);
c = matrix(2,1);
d = matrix(2,2);

type = kUnknownType;
if (a == 1) && (c == 0) && (d == 1)
    type = kFreespaceType;
elseif (a == 1) && (b == 0) && (d == 1) 
    type = kLensType;
elseif (a == 1) && (b == 0 ) && (d == 1) && matrix(kPhysicalLengthIndex) == 0
    type = kApertureType;
end

%EXTENDRAY Returns an extended ray from a standard ABCD ray [ r, theta, position, 1/apertureSize, 1/apertureAngle, 1, type, elementIndex] 

abcdExtendedMatrix = [a b 0 0 0 0 0 0; ... 
                      c d 0 0 0 0 0 0; ...
                      0 0 1 0 0 0 0 length ; ...
                      0 0 0 0 0 0 0 1/apertureSize; ...
                      0 0 0 0 0 0 0 1/apertureAngle; ...
                      0 0 0 0 0 1 0 1; ...
                      0 0 0 0 0 0 0 type; ... 
                      0 0 0 0 0 0 0 1];

end
