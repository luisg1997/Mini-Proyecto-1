function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 02-Mar-2020 02:28:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure

% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Begin.
function Begin_Callback(hObject, eventdata, handles)
% hObject    handle to Begin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB 
a = arduino();
h = animatedline;
ax = gca;
ax.YGrid = 'on';
ax.YLim = [-1.5 2];
t = 0;
dt = 0.1;
stop = false;
variable = 0;
n = 1;
banderaentre = 0;
banderaneg = 0;
banderapos = 0;
banderaentre2 = 0;
contador = 0;
banderaabajo = 0;
banderaarriba = 0;
while ~stop
    % Leemos el valor actual
    v = readVoltage(a,'A1')- 1.609; 
    
    variable(n) = v;
    n = n+1;
    if n == 201
        n = 1;
    end
    setappdata(0, 'voltage',variable);
    % Obtenemos el tiempo actual
    t =  t + dt;
    % a164adimos los puntos
    addpoints(h,t,v)
    % Actualizamos los ejes
    ax.XLim = datenum([t-seconds(50000) t]);
    datetick('x','keeplimits')
    drawnow limitrate
    sumavoltajes(n) = v;
    mav = mean(abs(sumavoltajes));
    set(handles.text2 , 'String', num2str(mav));
    
    if (v < -0.2) 
        banderaentre = 0;
        banderaneg =0;
        banderaabajo = 1;
    end
    if(v>-0.2) && (v<0.2) && (banderaabajo == 1)
        banderaentre = 1;
        banderaabajo =0;
        v =0;
    end
    if(v>-0.2) && (v<0.2)
        v =0;
    end
    if(banderaentre==1) && (v>0.2)
        banderaneg = 1;
        banderaentre = 0;
    end
    if(banderaneg ==1)
        contador = contador+1;
        banderaneg = 0;
    end
   %CAMBIO DE POSITIVO A NEGATIVO
    if (v > 0.2)  
        banderaentre2 = 0;
        banderapos =0;
        banderaarriba = 1;
    end
    if(v>-0.2) && (v<0.2) && (banderaarriba == 1)
        banderaentre2 = 1;
        banderaarriba = 0;
    end
    if(banderaentre2==1) && (v<-0.2)
        banderapos = 1;
        banderaentre2 = 0;
    end
    if(banderapos ==1)
        contador = contador+1;
        banderapos = 0;
    end
    set(handles.text3, 'String', num2str(contador));

end
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guardar = getappdata(0, 'voltage');
xlswrite('data4.xlsx',guardar);
