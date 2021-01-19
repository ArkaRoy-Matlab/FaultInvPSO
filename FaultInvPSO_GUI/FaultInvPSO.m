% ***************************************************************
% *** Matlab GUI for inversion of fault plane from gravity data
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************

function varargout = FaultInvPSO(varargin)
% FAULTINVPSO MATLAB code for FaultInvPSO.fig
%      FAULTINVPSO, by itself, creates a new FAULTINVPSO or raises the existing
%      singleton*.
%
%      H = FAULTINVPSO returns the handle to a new FAULTINVPSO or the handle to
%      the existing singleton*.
%
%      FAULTINVPSO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FAULTINVPSO.M with the given input arguments.
%
%      FAULTINVPSO('Property','Value',...) creates a new FAULTINVPSO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FaultInvPSO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FaultInvPSO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FaultInvPSO

% Last Modified by GUIDE v2.5 20-Dec-2020 13:55:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FaultInvPSO_OpeningFcn, ...
                   'gui_OutputFcn',  @FaultInvPSO_OutputFcn, ...
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

% --- Executes just before FaultInvPSO is made visible.
function FaultInvPSO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FaultInvPSO (see VARARGIN)

% Choose default command line output for FaultInvPSO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FaultInvPSO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FaultInvPSO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function obs_path_Callback(hObject, eventdata, handles)
% hObject    handle to obs_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of obs_path as text
%        str2double(get(hObject,'String')) returns contents of obs_path as a double
file_obs= get(hObject,'String');
x_obs=importdata(file_obs);


% --- Executes during object creation, after setting all properties.
function obs_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obs_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function grv_path_Callback(hObject, eventdata, handles)
% hObject    handle to grv_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of grv_path as text
%        str2double(get(hObject,'String')) returns contents of grv_path as a double



% --- Executes during object creation, after setting all properties.
function grv_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grv_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function density_fnc_Callback(hObject, eventdata, handles)
% hObject    handle to density_fnc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of density_fnc as text
%        str2double(get(hObject,'String')) returns contents of density_fnc as a double


% --- Executes during object creation, after setting all properties.
function density_fnc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to density_fnc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in obs_btn.
function obs_btn_Callback(hObject, eventdata, handles)
% hObject    handle to obs_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=uigetfile({'*.*'},'File for Observation points');
fullname_obs=fullfile(filepath,filename);
set(handles.obs_path, 'string', fullname_obs);


% --- Executes on button press in grv_btn.
function grv_btn_Callback(hObject, eventdata, handles)
% hObject    handle to grv_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=uigetfile({'*.*'},'File for Gravity Data');
fullname_fld=fullfile(filepath,filename);
set(handles.grv_path, 'string', fullname_fld);


% --- Executes when entered data in editable cell(s) in data_table.
function data_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to data_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in data_load.
function data_load_Callback(hObject, eventdata, handles)
% hObject    handle to data_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file_obs= get(handles.obs_path,'String');
x_obs=importdata(file_obs);
file_data= get(handles.grv_path,'String');
data=importdata(file_data);
val=[x_obs data];
set(handles.data_table,'data',val)



function yspan_Callback(hObject, eventdata, handles)
% hObject    handle to yspan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yspan as text
%        str2double(get(hObject,'String')) returns contents of yspan as a double


% --- Executes during object creation, after setting all properties.
function yspan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yspan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function npop_Callback(hObject, eventdata, handles)
% hObject    handle to npop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of npop as text
%        str2double(get(hObject,'String')) returns contents of npop as a double


% --- Executes during object creation, after setting all properties.
function npop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to npop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c1_Callback(hObject, eventdata, handles)
% hObject    handle to c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c1 as text
%        str2double(get(hObject,'String')) returns contents of c1 as a double


% --- Executes during object creation, after setting all properties.
function c1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c2_Callback(hObject, eventdata, handles)
% hObject    handle to c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c2 as text
%        str2double(get(hObject,'String')) returns contents of c2 as a double


% --- Executes during object creation, after setting all properties.
function c2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxit_Callback(hObject, eventdata, handles)
% hObject    handle to maxit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxit as text
%        str2double(get(hObject,'String')) returns contents of maxit as a double


% --- Executes during object creation, after setting all properties.
function maxit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    cla(handles.axes4,'reset')
    cla(handles.axes3,'reset')
    cla(handles.axes5,'reset')
    cla(handles.axes1,'reset')
    
    str=get(handles.density_fnc,'String');
    str = vectorize(str);
    density = str2func(['@(z)' str]);
    file_obs= get(handles.obs_path,'String');
    x_obs=importdata(file_obs);
    file_data= get(handles.grv_path,'String');
    data=importdata(file_data);
    
    npop_str= get(handles.npop,'String');
    npop=str2num(npop_str);
    c1_str= get(handles.c1,'String');
    c1=str2num(c1_str);
    c2_str= get(handles.c2,'String');
    c2=str2num(c2_str);
    maxit_str= get(handles.maxit,'String');
    maxit=str2num(maxit_str);
    
    y_span=(x_obs(end)-x_obs(1))/2;
    
    
    z_obs=0;
    ss='Model Started Running';
    drawnow;
    set(handles.md_run,'string', ss)
    %Run Model for 10 times and taking best model out of this 10 independent runs
    for i=1:5
        %running independent model
        [x_l,z_l,x_h,z_h,best_cost,error_energy]=Fault_Invert(data,x_obs,z_obs,density,npop,c1,c2,maxit);
        %Saving data for all independent run
        xx_l(i)=x_l; xx_h(i)=x_h; zz_l(i)=z_l; zz_h(i)=z_h; bb_cost(i)=best_cost; err(i,:)=error_energy;
        ss=sprintf('%d independent run finished.',i);
        drawnow;
        set(handles.md_run,'string', ss)
    end
    ss='';
    set(handles.md_run,'string',ss);
    %finding minimum of cost function
    [mm,id]=min(bb_cost);
    %outputs for best Model
    x_l=xx_l(id);x_h=xx_h(id); 
    z_l=zz_l(id);z_h=zz_h(id); 
    bst_err=sqrt(squeeze(err(id,:)));
%% Plotting the estimated Fault structure   
                [t,c]=lgwt(10,0,1);
                %checking for orientation of the fault
                dd(1)=abs(data(1)); dd(2)=abs(data(end));
                if dd(1)>dd(2)  
                    %Left side oriented fault
                    x=[x_h x_l -inf -inf];
                    y=[z_h z_l z_l z_h];
                    tf=0;
                else
                    %Right side oriented fault
                    x=[x_l x_h inf inf];
                    y=[z_l z_h z_h z_l];
                    tf=1;
                end

                %Gravity field of the basin for varying density
                yy=poly_gravityrho(x_obs,z_obs,x,y,density,t,c);
                handles.grv_data = yy;  %new
                guidata(hObject, handles);   %new
        %Plotting the estimated gravity anomaly Fault structure
        
        axes(handles.axes1);
        
        plot(x_obs,data,'ro','Linewidth',2);
        hold on
        plot(x_obs,yy,'Linewidth',2)
        xlabel('Observation Points (m)')
        ylabel('Gravity Anomaly (mGal)')
        title('Gravity Anomaly plot')
        legend('Observed','Optimized','Location','best')
        xlim([x_obs(1) x_obs(end)])
        box on
        
        %checking the orientation of the fault 
        if dd(1)>dd(2)  
            
            axes(handles.axes4);
            
            %plotting the inverted model using patched surface
            patch([x_l x_h x_obs(1) x_obs(1) x_l],[z_l z_h z_h z_l z_l],density([z_l z_h z_h z_l z_l]),'EdgeColor','none') 
            
            %colormap for the surface plot
            colormap cool
            box on
            %making z axis in reverse direction
            set(gca,'Ydir','reverse')
            %x axis limit as per the maximum and minimum observation points 
            xlim([x_obs(1) x_obs(end)])
            %location of colorbar as per the density contrast and outside
            %the plotting region
            c=colorbar('southoutside');
            %colorbar labelling
            c.Label.String = 'Density contrast (kg/m^3)';
       
            %z location of end point of fault block
            z_left_end=1.5*abs(z_h-z_l)+z_h;
            %x location of end point of fault block
            x_left_end=((x_l-x_h)/(z_l-z_h))*(z_left_end-z_l)+x_l;
            hold off
            %plotting the hanging wall and footwall of fault
            
            hold on
            %plotting the Footwall
            plot([x_h  x_left_end x_obs(1) x_obs(1) x_h],[z_h z_left_end z_left_end z_h z_h],'k','linewidth',0.25) 
            fill([x_h  x_left_end x_obs(1) x_obs(1) x_h],[z_h z_left_end z_left_end z_h z_h],'y','facealpha',0.12)
            %z location of end point of fault block
            z_mid_end=1.5*abs(z_h-z_l)+z_l;
            %x location of end point of fault block
            x_mid_end=((x_l-x_h)/(z_l-z_h))*(z_mid_end-z_l)+x_l;
            %plotting the hanging wall
            plot([x_l  x_mid_end x_obs(end) x_obs(end) x_l],[z_l z_mid_end z_mid_end z_l z_l],'k','linewidth',0.25) 
            fill([x_l  x_mid_end x_obs(end) x_obs(end) x_l],[z_l z_mid_end z_mid_end z_l z_l],'y','facealpha',0.12)
            hold off
            
        else
            
            axes(handles.axes4);
            
            hold on
            %plotting the inverted model using patched surface
            patch([x_l x_obs(end) x_obs(end) x_h x_l],[z_l z_l z_h z_h z_l],density([z_l z_l z_h z_h z_l]),'EdgeColor','none')
            
            %colormap for the surface plot
            colormap cool
            box on
            %making z axis in reverse direction
            set(gca,'Ydir','reverse')
            %x axis limit as per the maximum and minimum observation points 
            xlim([x_obs(1) x_obs(end)])
            %location of colorbar as per the density contrast and outside
            %the plotting region
            c=colorbar('southoutside');
            %colorbar labelling
            c.Label.String = 'Density contrast (kg/m^3)';
            
            %z location of end point of fault block
            z_left_end=1.5*abs(z_h-z_l)+z_h;
            %x location of end point of fault block
            x_left_end=((x_l-x_h)/(z_l-z_h))*(z_left_end-z_l)+x_l;
            hold off
            %plotting the hanging wall and footwall of fault
            
            hold on
            %plotting the hanging wall
            plot([x_h  x_left_end x_obs(end) x_obs(end) x_h],[z_h z_left_end z_left_end z_h z_h],'k','linewidth',0.25) 
            fill([x_h  x_left_end x_obs(end) x_obs(end) x_h],[z_h z_left_end z_left_end z_h z_h],'y','facealpha',0.12)
            %z location of end point of fault block
            z_mid_end=1.5*abs(z_h-z_l)+z_l;
            %x location of end point of fault block
            x_mid_end=((x_l-x_h)/(z_l-z_h))*(z_mid_end-z_l)+x_l;
            %plotting the footwall
            plot([x_l  x_mid_end x_obs(1) x_obs(1) x_l],[z_l z_mid_end z_mid_end z_l z_l],'k','linewidth',0.25) 
            fill([x_l  x_mid_end x_obs(1) x_obs(1) x_l],[z_l z_mid_end z_mid_end z_l z_l],'y','facealpha',0.12)
            hold off
            
        end
        xlabel('Horizontal distance (m)')
        ylabel('Depth (m)')
        title('2D Fault Structure')
        
    % tf    = represents the fault orientation 
    %       if tf=0 ; Fault is left side oriented
    %       if tf=1 ; Fault is right side oriented
    % For plotting the Fault we have required 6 planes each having 4 vertices
     
    
    points_upper=sprintf('X = %f m and Z = %f m',x_h,z_h);
    set(handles.upper,'string', points_upper)
    
    points_lower=sprintf('X = %f m and Z = %f m',x_l,z_l);
    set(handles.lower,'string', points_lower)
    %dip 
    dip_cal=rad2deg(atan(abs(z_l-z_h)/abs(x_l-x_h)));
    set(handles.dip,'string', num2str(dip_cal))
    %RMSE of given model 
     RMSE_g=sqrt((sum((data-yy').^2))/length(data))/(max(data(:))-min(data(:)));
     set(handles.rmse,'string', num2str(RMSE_g))
    zz=linspace(0,z_h);
    den=density(zz)+0.*zz;
    
    axes(handles.axes3);
    cla()
    plot(den,zz,'Linewidth',2)
    set(gca,'Ydir','reverse')
    %set(gca,'Xdir','reverse')
    xlabel('Density contrast (kg/m^3)')
    ylabel('Depth (m)')
    title('Density contrast variation with depth')
    
    axes(handles.axes5);
    semilogy(1:length(bst_err),bst_err,'Linewidth',2)
    title('Objective function value for each iterations')
    ylabel('Objective function (mGal)')
    xlabel('Number of iterations')
    
    

% --- Executes on button press in push_fault.
function push_fault_Callback(hObject, eventdata, handles)
% hObject    handle to push_fault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%2. Copy axes to new figure and save
        [filename,pathname] = uiputfile(...
                                     {'*.fig';'*.png';'*.jpg';'*.tif';'*.bmp';'*.*'}, ...
                                        'Save as');
        outputFileName = fullfile(pathname,filename);
        fignew = figure('Visible','on'); % Invisible figure
        newAxes = copyobj(handles.axes4,fignew); % Copy the appropriate axes
        colormap(fignew,cool)
        %the plotting region
            c=colorbar('eastoutside');
            %colorbar labelling
            c.Label.String = 'Density contrast (kg/m^3)';
        set(newAxes,'Position',get(groot,'DefaultAxesPosition')); % The original position is copied too, so adjust it.
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')'); % Make it visible upon loading
        hold on
        saveas(fignew,outputFileName);
        delete(fignew);
       


% --- Executes on button press in push_grav.
function push_grav_Callback(hObject, eventdata, handles)
% hObject    handle to push_grav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uiputfile(...
                                     {'*.fig';'*.png';'*.jpg';'*.tif';'*.bmp';'*.*'}, ...
                                        'Save as');
        outputFileName = fullfile(pathname,filename);
        fignew1 = figure('Visible','on'); % Invisible figure
        newAxes1 = copyobj(handles.axes1,fignew1); % Copy the appropriate axes
        
        set(newAxes1,'Position',get(groot,'DefaultAxesPosition')); % The original position is copied too, so adjust it.
        set(fignew1,'CreateFcn','set(gcbf,''Visible'',''on'')'); % Make it visible upon loading
        hold on
        legend('Observed','Optimized','Location','best')
        saveas(fignew1,outputFileName);
        delete(fignew1);

% --- Executes on button press in push_density.
function push_density_Callback(hObject, eventdata, handles)
% hObject    handle to push_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uiputfile(...
                                     {'*.fig';'*.png';'*.jpg';'*.tif';'*.bmp';'*.*'}, ...
                                        'Save as');
        outputFileName = fullfile(pathname,filename);
        fignew2 = figure('Visible','on'); % Invisible figure
        newAxes2 = copyobj(handles.axes3,fignew2); % Copy the appropriate axes
        
        set(newAxes2,'Position',get(groot,'DefaultAxesPosition')); % The original position is copied too, so adjust it.
        set(fignew2,'CreateFcn','set(gcbf,''Visible'',''on'')'); % Make it visible upon loading
        hold on
        saveas(fignew2,outputFileName);
        delete(fignew2);

% --- Executes on button press in push_rmse.
function push_rmse_Callback(hObject, eventdata, handles)
% hObject    handle to push_rmse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uiputfile(...
                                     {'*.fig';'*.png';'*.jpg';'*.tif';'*.bmp';'*.*'}, ...
                                        'Save as');
        outputFileName = fullfile(pathname,filename);
        fignew3 = figure('Visible','on'); % Invisible figure
        newAxes3 = copyobj(handles.axes5,fignew3); % Copy the appropriate axes
        
        set(newAxes3,'Position',get(groot,'DefaultAxesPosition')); % The original position is copied too, so adjust it.
        set(fignew3,'CreateFcn','set(gcbf,''Visible'',''on'')'); % Make it visible upon loading
        hold on
        saveas(fignew3,outputFileName);
        delete(fignew3);
        

% --- Executes on button press in push_data.
function push_data_Callback(hObject, eventdata, handles)
% hObject    handle to push_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uiputfile(...
                                     {'*.dat';'*.txt';'*.*'}, ...
                                        'Save as');
        
        zz=handles.grv_data;
        fnm = fullfile(pathname,filename);
        fid = fopen(fnm,'wt');
        fprintf(fid,'%.2f\n',zz);
        fclose(fid);
