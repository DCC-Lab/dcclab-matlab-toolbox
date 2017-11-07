function varargout = stackShow(varargin)
%STACKSHOW Display a stack in a simplistic window.
%      STACKSHOW, by itself, creates a new STACKSHOW or raises the existing
%      singleton*.
%
%      H = STACKSHOW returns the handle to a new STACKSHOW or the handle to
%      the existing singleton*.
%
%      STACKSHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STACKSHOW.M with the given input arguments.
%
%      STACKSHOW('Property','Value',...) creates a new STACKSHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stackShow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stackShow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stackShow

% Last Modified by GUIDE v2.5 16-Jan-2015 14:31:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stackShow_OpeningFcn, ...
                   'gui_OutputFcn',  @stackShow_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before stackShow is made visible.
function stackShow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stackShow (see VARARGIN)

global theStack;

% Choose default command line output for stackShow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

if length(varargin) == 1
    theStack = varargin{1};
    theProperties = stackProperties(theStack);
end

if ( theProperties.stackArrayDimension >= 1 )
    set(handles.xSlider,'Min', 1);
    set(handles.xSlider,'Max', theProperties.stackArraySizes(1));
    set(handles.xSlider,'Value', 1);
    set(handles.xSlider, 'SliderStep', [1/theProperties.stackArraySizes(1) , 10/theProperties.stackArraySizes(1) ]);
    set(handles.xSlider, 'Visible', 'on');
else
    set(handles.xSlider, 'Visible', 'off');  
end

if ( theProperties.stackArrayDimension >= 2 )
    set(handles.ySlider,'Min', 1);
    set(handles.ySlider,'Max', theProperties.stackArraySizes(2));
    set(handles.ySlider,'Value', 1);
    set(handles.ySlider, 'SliderStep', [1/theProperties.stackArraySizes(2) , 10/theProperties.stackArraySizes(2) ]);
    set(handles.ySlider, 'Visible', 'on');
else
    set(handles.ySlider, 'Visible', 'off');  
end

if ( theProperties.stackArrayDimension >= 3 )
    set(handles.zSlider,'Min', 1);
    set(handles.zSlider,'Max', theProperties.stackArraySizes(3));
    set(handles.zSlider,'Value', 1);
    set(handles.zSlider, 'SliderStep', [1/theProperties.stackArraySizes(3) , 10/theProperties.stackArraySizes(3) ]);
    set(handles.zSlider, 'Visible', 'on');  
else
    set(handles.zSlider, 'Visible', 'off');  
end

% This does not work: need to force redraw in same window.  How?
% addlistener(handles.xSlider,'ContinuousValueChange',@sliderContinuousScroll);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using stackShow.
if strcmp(get(hObject,'Visible'),'off')
    showFrame(hObject, [1 1]);
end

% UIWAIT makes stackShow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stackShow_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figurerand
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on slider movement.
function xSlider_Callback(hObject, eventdata, handles)
% hObject    handle to xSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

xIndex = uint32(get(handles.xSlider,'Value'));
yIndex = uint32(get(handles.ySlider,'Value'));
zIndex = uint32(get(handles.zSlider,'Value'));

showFrame(hObject, [ xIndex yIndex zIndex ]);
set(handles.stackNumber,'String',num2str(xIndex));

% --- Executes during object creation, after setting all properties.
function xSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function sliderContinuousScroll(hObject,eventData)

imageIndex = uint32(get(hObject,'Value'));
showFrame(hObject, imageIndex);


function showFrame(hObject, indices)
global theStack;

theProperties = stackProperties(theStack);

if theProperties.stackArrayDimension == 1
    linearIndex = indices(1);    
elseif theProperties.stackArrayDimension == 2
    linearIndex = sub2ind(theProperties.stackArraySizes, indices(1), indices(2));
elseif theProperties.stackArrayDimension == 3
    linearIndex = sub2ind(theProperties.stackArraySizes, indices(1), indices(2), indices(3));
end

if theProperties.samplesPerPixel > 1
    imshow(theStack(:,:,1:3,linearIndex));
else
    imshow(theStack(:,:,1,linearIndex));
end    


% --- Executes on slider movement.
function ySlider_Callback(hObject, eventdata, handles)
% hObject    handle to ySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
xIndex = uint32(get(handles.xSlider,'Value'));
yIndex = uint32(get(handles.ySlider,'Value'));
zIndex = uint32(get(handles.zSlider,'Value'));

showFrame(hObject, [ xIndex yIndex zIndex ]);


% --- Executes during object creation, after setting all properties.
function ySlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function zSlider_Callback(hObject, eventdata, handles)
% hObject    handle to zSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
xIndex = uint32(get(handles.xSlider,'Value'));
yIndex = uint32(get(handles.ySlider,'Value'));
zIndex = uint32(get(handles.zSlider,'Value'));

showFrame(hObject, [ xIndex yIndex zIndex ]);


% --- Executes during object creation, after setting all properties.
function zSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

