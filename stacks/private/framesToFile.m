function framesToFile( theStack, filePath, indices )
%framesToFileRepresentation Saves a set of frames from a stack to a file
%   Detailed explanation goes here

theProperties = stackProperties(theStack);

if ( ~isempty(regexp(filePath, '(?:\.mp4$)|(?:\.mov$)|(?:\.avi$)')) )
   [root filename ext ] = fileparts( filePath );
   
   if (strcmp(ext, '.avi') )
        v = VideoWriter(filePath);
   elseif (strcmp(ext, '.mov') || strcmp(ext, '.mp4') )
        v = VideoWriter(filePath, 'MPEG-4');
   end
   open(v);
   
       if (theProperties.hasAlpha)
           if strcmp(theProperties.class, 'uint16')
                writeVideo(v, single(theStack(:,:,1:3,indices)));
           else
                writeVideo(v, theStack(:,:,1:3,indices));
           end
       else
           if strcmp(theProperties.class, 'uint16')
                writeVideo(v, single(theStack(:,:,:,indices)));
           else
                writeVideo(v, theStack(:,:,:,indices));
           end
       end       
   close(v);    
elseif ~isempty(regexp(filePath, '.tif{1,2}'))
    theFile = Tiff(filePath,'w8');
    if ( theProperties.samplesPerPixel > 1)
        tiffTags.Photometric = Tiff.Photometric.RGB;
    else
        tiffTags.Photometric = Tiff.Photometric.MinIsBlack;
    end
    tiffTags.ImageLength = theProperties.height;
    tiffTags.ImageWidth = theProperties.width;
    tiffTags.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
    tiffTags.RowsPerStrip = 16; 
    tiffTags.BitsPerSample = theProperties.bitsPerSample; 
    tiffTags.SamplesPerPixel = theProperties.samplesPerPixel;
    if theProperties.samplesPerPixel == 4
       tiffTags.ExtraSamples =  Tiff.ExtraSamples.AssociatedAlpha;
    end
    if strcmp(theProperties.class,'single') || strcmp(theProperties.class,'double') 
        tiffTags.SampleFormat = Tiff.SampleFormat.IEEEFP;
        tiffTags.BitsPerSample = 32; % always float
    else
        tiffTags.SampleFormat = Tiff.SampleFormat.UInt;
    end

    for i=indices
        theFile.setTag(tiffTags);
        if tiffTags.SampleFormat == Tiff.SampleFormat.IEEEFP
            theFile.write(single(theStack(:,:,:,i)));
        else
            theFile.write(theStack(:,:,:,i));
        end

        theFile.close();
        theFile = Tiff(filePath,'a');
    end
    theFile.close();

else
    imwrite(theStack(:,:,:,indices), filePath );
end

end

