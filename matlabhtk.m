function varargout = matlabhtk(varargin)
% MATLABHTK MATLAB code for matlabhtk.fig
%      MATLABHTK, by itself, creates a new MATLABHTK or raises the existing
%      singleton*.
%
%      H = MATLABHTK returns the handle to a new MATLABHTK or the handle to
%      the existing singleton*.
%
%      MATLABHTK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATLABHTK.M with the given input arguments.
%
%      MATLABHTK('Property','Value',...) creates a new MATLABHTK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before matlabhtk_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to matlabhtk_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help matlabhtk

% Last Modified by GUIDE v2.5 04-Sep-2016 22:30:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @matlabhtk_OpeningFcn, ...
                   'gui_OutputFcn',  @matlabhtk_OutputFcn, ...
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


% --- Executes just before matlabhtk is made visible.
function matlabhtk_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to matlabhtk (see VARARGIN)

% Choose default command line output for matlabhtk
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes matlabhtk wait for user response (see UIRESUME)
% uiwait(handles.figure1);

    
% --- Outputs from this function are returned to the command line.
function varargout = matlabhtk_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in HTKtrain.
function HTKtrain_Callback(hObject, eventdata, handles)
        
     try
        [t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14] = writetraindata(handles.com,25,handles.gyro1,handles.gyro2,handles.gyro3);
        set (handles.trainstatus, 'string','HTK Train Done'); 
        contents = get(handles.input1,'String'); 
        popupmenu1value = contents{get(handles.input1,'Value')};
        contents = get(handles.input2,'String'); 
        popupmenu2value = contents{get(handles.input2,'Value')};
        contents = get(handles.input3,'String'); 
        popupmenu3value = contents{get(handles.input3,'Value')};
        fid = fopen('traindatahtk\traindatahtk11.lab','wt');
        fprintf(fid, '%.0f %.0f ssil\n%.0f %.0f %s\n%.0f %.0f sp\n%.0f %.0f %s\n%.0f %.0f sp\n%.0f %.0f %s\n%.0f %.0f ssil',t1,t2,t3,t4,popupmenu1value,t5,t6,t7,t8,popupmenu2value,t9,t10,t11,t12,popupmenu3value,t13,t14);
        fclose(fid);
        dos('auto.bat');
        h = msgbox('Training done','Success');
    catch 
         errordlg('Please Finish the Background Noise Detection First','System Error');
    end
    
    
% hObject    handle to HTKtrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in backgroundnoise.
function backgroundnoise_Callback(hObject, eventdata, handles)
    
    try
    [gyro1,gyro2,gyro3] = writebackgrounddata(handles.com,2);
    handles.gyro1 = gyro1;
    handles.gyro2 = gyro2;
    handles.gyro3 = gyro3;
    guidata(hObject, handles);
    if ((gyro1 > handles.presetaveragegyro)||(gyro2 > handles.presetaveragegyro)|| (gyro3 > handles.presetaveragegyro))
        set (handles.backgroundnoisestatus, 'string','Background Noise too high'); 
    else
        set (handles.backgroundnoisestatus, 'string','Background Noise detected, value OK');
    end 
    
    catch 
       errordlg('Please check the connection of Shimmer3','System Error')
    end
% hObject    handle to backgroundnoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in streamdata.
function streamdata_Callback(hObject, eventdata, handles)
    set (handles.text3, 'string','Data Streaming...');
    streamdata(handles.com,1500);
    dbstop if warning
        errordlg('Please check if Shimmer3 connected correctly','System Error');
        set (handles.text3, 'string','...');

    
% hObject    handle to streamdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function backgroundnoisestatus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to backgroundnoisestatus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 


% --- Executes on selection change in input1.
function input1_Callback(hObject, eventdata, handles)
% hObject    handle to input1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns input1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from input1


% --- Executes during object creation, after setting all properties.
function input1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% handles    structure with handle

% --- Executes on selection change in input2.
function input2_Callback(hObject, eventdata, handles)
% hObject    handle to input2 (see GCBO)
% eventdata  reserved - to be defis and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns input2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from input2


% --- Executes during object creation, after setting all properties.
function input2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in input3.
function input3_Callback(hObject, eventdata, handles)
% hObject    handle to input3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns input3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from input3


% --- Executes during object creation, after setting all properties.
function input3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function trainstatus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trainstatus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function HTKtrain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trainstatus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
    presetaveragegyro = 10000000000000000000000000;
    handles.presetaveragegyro = presetaveragegyro;
    guidata(hObject, handles);
    h = msgbox('Deletion Completed','Success');
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Start_recognition.
function Start_recognition_Callback(hObject, eventdata, handles)
if exist('handles.com' , 'var')
    if exist('E:\matlabhtk\hmmlist\hmm47\hmmall', 'file') 
        recognizedata(handles.com,100);
    else
        errordlg('Please check if the Hidden Markov Models exists!','System Error');
    end
else
    errordlg('Please check the connection of Shimmer3!','System Error');
end
% hObject    handle to Start_recognition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Use.
function Use_Callback(hObject, eventdata, handles)
    presetaveragegyro = 800;
    handles.presetaveragegyro = presetaveragegyro;
    guidata(hObject, handles);
    h = msgbox('Pre-set background noise setting Completed','Success');
% hObject    handle to Use (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function COM_Callback(hObject, eventdata, handles)
    comnumber = get(hObject,'String');
    handles.comnumber = comnumber;
    guidata(hObject, handles);
    
% hObject    handle to COM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of COM as text
%        str2double(get(hObject,'String')) returns contents of COM as a double


% --- Executes during object creation, after setting all properties.
function COM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to COM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Confirm.
function Confirm_Callback(hObject, eventdata, handles)
    try
        com = handles.comnumber;
        handles.com = com;
        guidata(hObject, handles);
        h = msgbox('COM setting done','Success');
    catch 
        errordlg('Please Enter the COM first','System Error')
    end
% hObject    handle to Confirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in HELP.
function HELP_Callback(hObject, eventdata, handles)
    url = 'http://cedrus.com/support/rb_series/tn1045_usbport_win.htm';
    web(url);
% hObject    handle to HELP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Recover.
function Recover_Callback(hObject, eventdata, handles)
    dos('recover.bat');
% hObject    handle to Recover (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
