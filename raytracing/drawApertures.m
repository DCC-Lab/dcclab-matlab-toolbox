function drawApertures(opticalPath)
%DRAWAPERTURES Draw the apertures of an optical path
    loadConstants;
    rayCollection = rayCalc([0; 0.01], opticalPath);
    
    apertures = rayCollection([kZPositionRayIndex kInverseApertureRayIndex kTypeRayIndex],:);
    apertures(:,apertures(2,:)==0)=[]; % This removes all 'zero' apertures

    if ~isempty(apertures)
        
        [~, widthQuantum] = drawingProperties(opticalPath);

        width = widthQuantum/2;
        height = 0.1/min(apertures(2,:));
        for i=1:size(apertures,2)
            x = apertures(1,i);
            y = 1/apertures(2,i);

            if apertures(3,i) == kLensType ||  apertures(3,i) == kApertureType 
                line([ x x ], [ y y+height], 'Color',[0 0 0 ],'LineWidth',3);
                line([ x-width x+width ], [ y y], 'Color',[0 0 0 ],'LineWidth',3);
                line([ x x ], [ -y -y-height], 'Color',[0 0 0 ],'LineWidth',3);
                line([ x-width x+width ], [ -y -y], 'Color',[0 0 0 ],'LineWidth',3);
            elseif apertures(3,i) == kGRINType
                line([ x-width/2  x+width/2 ], [ y y], 'Color',[0 0 0 ],'LineWidth',3);
                line([ x-width/2 x+width/2 ], [ -y -y], 'Color',[0 0 0 ],'LineWidth',3);
            else
                line([ x x+width ], [ y y], 'Color',[0 0 0 ],'LineWidth',3);
                line([ x x+width ], [ -y -y], 'Color',[0 0 0 ],'LineWidth',3);
            end
        end

        [ theSize, zPosition, ~ ] = apertureStop(opticalPath);
        w = 1;h=1; % Text does not clip so might as well use a tiny box
        posVec = ds2nfu([zPosition-w/2 -theSize-h-2*height  w h] );
        if posVec(1) >= 0 && posVec(1) <= 1 &&  posVec(2) >= 0 && posVec(2) <= 1
            annotation('textbox', posVec,'String', 'AS','LineStyle','none','FontUnits', 'normalized','FontSize',0.05,'HorizontalAlignment','center');
        end
        
        [ theSize, zPosition, ~ ] = fieldStop(opticalPath);
        posVec = ds2nfu([zPosition-w/2 -theSize-h-2*height  w h] );
        if posVec(1) >= 0 && posVec(1) <= 1 &&  posVec(2) >= 0 && posVec(2) <= 1
            annotation('textbox', posVec,'String', 'FS','LineStyle','none','FontUnits', 'normalized','FontSize',0.05,'HorizontalAlignment','center');
        end
    end
end
