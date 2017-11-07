function drawObject( position, size)
%DRAWOBJECT Draw an arrow at a given position with a given size
%   Detailed explanation goes here

[xaf, yaf] = ds2nfu([position position],[0 size]);

if ( (xaf <= 1) & (yaf <= 1) & (xaf >=0) & (yaf >= 0) )
    annotation('arrow',xaf,yaf,'LineWidth',2)
end

%line(xn, yn,'Color',[0.5 0.5 0.5],'LineWidth',6)

end

