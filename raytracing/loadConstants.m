%LOADCONSTANTS A set of constants for readability. Add to scripts with 'loadConstants'.
kUnknownType = 0;
kFreespaceType = 1;
kLensType = 2;
kGRINType = 3;
kApertureType = 4;
kInterfaceType = 5;
kCurvedInterfaceType = 6;

%position, 1/apertureSize, 1, type, elementIndex
kRadiusRayIndex = 1;
kAngleRayIndex = 2;
kZPositionRayIndex = 3;
kInverseApertureRayIndex = 4;
kInverseApertureAngleRayIndex = 5;
kElementRayIndex = 6;
kTypeRayIndex = 7;
k1RayIndex = 8;

kMaxIndex = k1RayIndex;

kPhysicalLengthMatrixIndex = sub2ind([kMaxIndex kMaxIndex], kZPositionRayIndex, k1RayIndex);
kInverseApertureMatrixIndex = sub2ind([kMaxIndex kMaxIndex], kInverseApertureRayIndex, k1RayIndex);
kApertureAngleMatrixIndex = sub2ind([kMaxIndex kMaxIndex], kInverseApertureAngleRayIndex, k1RayIndex);
kTypeMatrixIndex = sub2ind([kMaxIndex kMaxIndex], kTypeRayIndex, k1RayIndex);
k1MatrixIndex = sub2ind([kMaxIndex kMaxIndex], k1RayIndex, k1RayIndex);



