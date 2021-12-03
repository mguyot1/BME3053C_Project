% Authors: Matthew Nguyen, Michael Guyot, Cameron Manson, Nathan Jones
% Course: BME 3053C Computer Applications for BME
% Term: Fall 2021
% J. Crayton Pruitt Family Department of Biomedical Engineering
% University of Florida

%Creates GUI for inital scar tissue segmentation screening
function varargout = advSegGUI(varargin)
% ADVSEGGUI MATLAB code for advSegGUI.fig
%      ADVSEGGUI, by itself, creates a new ADVSEGGUI or raises the existing
%      singleton*.
%
%      H = ADVSEGGUI returns the handle to a new ADVSEGGUI or the handle to
%      the existing singleton*.
%
%      ADVSEGGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADVSEGGUI.M with the given input arguments.
%
%      ADVSEGGUI('Property','Value',...) creates a new ADVSEGGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before advSegGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to advSegGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help advSegGUI

% Last Modified by GUIDE v2.5 02-Dec-2021 17:04:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @advSegGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @advSegGUI_OutputFcn, ...
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


% --- Executes just before advSegGUI is made visible.
function advSegGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to advSegGUI (see VARARGIN)

% Choose default command line output for advSegGUI
handles.output = hObject;
load('var.mat')
axes(handles.draw)
imshow(I); 

freehandLeft = drawfreehand('color', 'k');
freehandRight = drawfreehand('color', 'k');

xLeft = freehandLeft.Position(:,1);
yLeft = freehandLeft.Position(:,2);
xRight = freehandRight.Position(:,1);
yRight = freehandRight.Position(:,2);

save('var.mat', '-append')
% Update handles structure
guidata(hObject, handles);
return

% UIWAIT makes advSegGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = advSegGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
