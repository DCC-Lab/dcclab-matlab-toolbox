function demoExtended(opticalPath,angleRange,radiusRange)

h=figure;
drawApertures(opticalPath)

for r = radiusRange
    for angle = angleRange
        rayCollection = rayCalc([r;angle], opticalPath);
     
        hue = (r+max(radiusRange))/(max(radiusRange)-min(radiusRange));
        color = hsv2rgb(hue,1,1);
        rayTrace(rayCollection, color)
        
    end
end

figure(h)