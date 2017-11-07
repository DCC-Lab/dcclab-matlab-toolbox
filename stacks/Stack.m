classdef Stack
    %A Stack behaves like a multidimensionnal matrix but does not load all
    %the stacks into memory and accesses each file individually.
    
    properties
        filenameTemplate;
        fileRepresentation;
        internalStack;
    end
    

    methods
        function obj = Stack(template)
             obj.filenameTemplate = template;
             obj.fileRepresentation = fileRepresentationFromTemplate(template);
        end

        function theFrame = subsref(obj, S)
            if ( ~isempty(obj.internalStack) )
                obj = subsref(obj.internalStack, S);
            elseif ( size(S.subs,2) >= 4 )
                if ( ~isnumeric(S.subs{4}) )
                    ME = MException('dcclab:Stack:cannotSliceAcrossFrame', 'The frame number (4th index) must be given and cannot be :');
                    throw(ME);            
                end
                theProperties = stackProperties(obj);
                
                switch theProperties.stackArrayDimension 
                    case 1
                        frameIndex = S.subs{4};
                    case 2
                        frameIndex = sub2ind(theProperties.stackArraySizes, S.subs{4},S.subs{5});
                    case 3
                        frameIndex = sub2ind(theProperties.stackArraySizes, S.subs{4},S.subs{5},S.subs{6});
                    case 4
                        frameIndex = sub2ind(theProperties.stackArraySizes, S.subs{4},S.subs{5},S.subs{6},S.subs{7});
                end
                theFrame = frameFromFileRepresentation(obj.fileRepresentation, frameIndex);
                theFrame = theFrame(S.subs{1:3});
            else
                ME = MException('dcclab:Stack:internalStackEmpty', 'Partial stack loading not implemented yet');
                throw(ME);            
            end
        end
        
        function theProperties = stackProperties(obj)
            theProperties = stackProperties(obj.fileRepresentation);
            theProperties.type = 'memory';
        end
        
    end
    
end

