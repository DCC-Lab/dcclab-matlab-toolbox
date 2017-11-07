function [  ] = guiProfile( I )
%profile Trace le profile d'intensité à la position ayant été déterminée comme
%étant le maximum

if ( size(size(I),2) == 3 ) 
    Ik = sum (I, 3) / size(I,3);
else
    Ik = I;
end

[xc yc] = beamMaximum(Ik);
[w h] = beam_Diametre(Ik);

if w>h
    x=double([(yc-w/2) (yc+w/2)]);
    y=double([(xc-w/2) (xc+w/2)]);
else
    x=double([(xc-h/2) (xc+h/2)]);
    y=double([(yc-h/2) (yc+h/2) ]);
end

improfile(Ik,x,y);

end

