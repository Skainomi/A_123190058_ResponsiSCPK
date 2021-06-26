function varargout = A_123190058_ResponsiSCPK(varargin)
% A_123190058_ResponsiSCPK MATLAB code for A_123190058_ResponsiSCPK.fig
%      A_123190058_ResponsiSCPK, by itself, creates a new A_123190058_ResponsiSCPK or raises the existing
%      singleton*.
%
%      H = A_123190058_ResponsiSCPK returns the handle to a new A_123190058_ResponsiSCPK or the handle to
%      the existing singleton*.
%
%      A_123190058_ResponsiSCPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in A_123190058_ResponsiSCPK.M with the given input arguments.
%
%      A_123190058_ResponsiSCPK('Property','Value',...) creates a new A_123190058_ResponsiSCPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before A_123190058_ResponsiSCPK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to A_123190058_ResponsiSCPK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help A_123190058_ResponsiSCPK

% Last Modified by GUIDE v2.5 26-Jun-2021 10:29:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @A_123190058_ResponsiSCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @A_123190058_ResponsiSCPK_OutputFcn, ...
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


% --- Executes just before A_123190058_ResponsiSCPK is made visible.
function A_123190058_ResponsiSCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to A_123190058_ResponsiSCPK (see VARARGIN)

% Choose default command line output for A_123190058_ResponsiSCPK
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes A_123190058_ResponsiSCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = A_123190058_ResponsiSCPK_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_proses.
function btn_proses_Callback(hObject, eventdata, handles)
% hObject    handle to btn_proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
optsData = detectImportOptions('Data_Rumah.xlsx','DataRange', 'C2:H20');
optsData.VariableNamesRange = ('A1');
optsNumber = detectImportOptions('Data_Rumah.xlsx','DataRange', 'A2:A20');
dataNumber = readmatrix('Data_Rumah.xlsx', optsNumber);
dataData = readmatrix('Data_Rumah.xlsx', optsData);
data = [dataNumber, dataData];%Menggabungkan data dari data yang sudah diambil
set(handles.tb_data, 'data', data);%Menampilkan data ke tabel
w=[0.30, 0.20, 0.23, 0.10, 0.07, 0.10];%Menambah bobot per kriteria
k=[0,1,1,1,1,1];%attribute tiap kriteria. 1 bila benefit, 0 bila cost.
[m,n]=size (dataData);%menyimpan ukuran data
R=zeros (m,n);%membuat matriks R, yang merupakan matriks kosong
for j=1:n
    if k(j)==1%statement untuk kriteria dengan atribut keuntungan
    	R(:,j)=dataData(:,j)./max(dataData(:,j));
    else
        R(:,j)=min(dataData(:,j))./dataData(:,j);
    end
end
%proses perangkingan nilai
for i=1:m
    V(i)= sum(w.*R(i,:));
end
[rank,rowRank] = sort(V,'descend');%sort nilai terbaik
optsNama = detectImportOptions('Data_Rumah.xlsx');
optsNama.SelectedVariableNames = [2];
dataNama = readmatrix('Data_Rumah.xlsx', optsNama);%mengambil nama rumah
set(handles.tb_hasil, 'data', dataNama(rowRank));%menampilkan nama rumah dengan urutan nilai V terbesar
