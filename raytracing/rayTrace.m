function rayTrace(rayCollection, color)
%RAYTRACE Trace the collection of rays onto the current figure
loadConstants;
rayPath = cat(2,rayCollection(kZPositionRayIndex,:)', rayCollection(kRadiusRayIndex,:)');
line(rayPath(:,1),rayPath(:,2),'Color',color);

end
