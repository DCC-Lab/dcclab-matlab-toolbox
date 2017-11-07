function theHandle = showProgress(progress, message, varargin)    
    useDesktop = usejava('Desktop');
    
    if nargin == 3
        theHandle = varargin{1};
    else 
        if useDesktop
            theHandle = waitbar(0,message, 'Visible','off');
            if ishghandle(theHandle)
                setappdata(theHandle, 'startTime', cputime);
                setappdata(theHandle, 'nextStep', 1);
            else
                theHandle = [];
            end
        else
            theHandle = [];
        end
    end
    
    if ishghandle(theHandle)
        startTime = getappdata(theHandle, 'startTime');
        nextStep = getappdata(theHandle, 'nextStep');
    else
        startTime = 0;
        nextStep = 5;
    end
    
    if ( cputime - startTime > 2 )
        percent = int16(progress*100);
        if percent >= nextStep
            if useDesktop && ishghandle(theHandle)
                set(theHandle, 'Visible', 'on');
                nextStep = 1;
                waitbar( progress, theHandle, message);
            else
                disp(sprintf('%d/100', percent));
            end
            
            if percent < 10
                nextStep = percent + 1;
            elseif mod(percent,10) == 0 
                nextStep = percent + 10;
            end
        end
    end
end