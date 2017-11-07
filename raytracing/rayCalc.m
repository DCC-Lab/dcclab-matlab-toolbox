function rayCollection = rayCalc(ray, opticalPath)
%RAYCALC Returns the ray as transformed by each matrix of the opticalPath
loadConstants;

rayCollection = [];
if ~isExtended(ray)
    ray = extendRay(ray, 0);
end

rayCollection = cat(2,rayCollection, ray);
for i=1:size(opticalPath,3);
    element = opticalPath(:,:,i);
    ray = element * ray;
    assert(~sum(int8(isnan(ray))));
    
    if (abs(ray(kRadiusRayIndex) * ray(kInverseApertureRayIndex)) > 1) || (abs(ray(kAngleRayIndex) * ray(kInverseApertureAngleRayIndex) ) > 1)
        ray(k1RayIndex) = 0;
        rayCollection = cat(2,rayCollection, ray);            
        break
    else
        rayCollection = cat(2,rayCollection, ray);            
    end
        
end
end
