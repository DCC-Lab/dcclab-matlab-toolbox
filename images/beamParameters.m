function p=beamParameters(beamDiameterVector, positionVector)
%gaussianBeamParameters returns the mean beam width, the divergence, 
%Beam width
adjustPosition=1000*positionVector;

if length(beamDiameterVector) == length(positionVector);
    
    adjustRadius=beamDiameterVector./2;
    indPos=find(adjustRadius<=3*min(adjustRadius));
    radius=adjustRadius(indPos(1,1):indPos(1,end));
    diameter=2*radius;
    
    [minRadius indMinRadius]=min(radius);
    resolution=2*minRadius;
    
    newPosition = adjustPosition(1,indPos(1):(indPos(end)));
    offsetPosition=newPosition(indMinRadius);
    position = newPosition - offsetPosition;
    
    
    indConfRadius=find(radius<=minRadius*sqrt(2));
    confocalParameter=(position(1,indConfRadius(end))- position(1,indMinRadius));
    
    divergence=tan(radius(1,end)/position(1,end)); 
   
    p = struct('resolution',resolution,'confocalParameter',confocalParameter,...
        'indConfRadius',indConfRadius,'divergence',divergence,'position',position,'diameter',...
        diameter,'adjustDiameter',beamDiameterVector,'adjustPosition',adjustPosition,'radius',radius,...
        'indMinRadius',indMinRadius,'minRadius',minRadius);
else

end





