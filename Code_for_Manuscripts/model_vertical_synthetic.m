% ***************************************************************
% *** Matlab code for synthetic model (Vertical Fault) of gravity inversion 
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************
%%Matlab code for synthetic model (Vertical Fault) of gravity inversion 
clear all
close all

%% Synthetic model for Vertical fault 
%upper and lower vertex points of fault plane
x_l_syn=7500; z_l_syn= 300;
x_h_syn=7500; z_h_syn=3500;

%gravity anomaly for given fault 
%Right side oriented fault
x=[x_l_syn x_h_syn inf inf];
y=[z_l_syn z_h_syn z_h_syn z_l_syn]; 

%density contrast of the fault in kg/m^3
%exponential depth varying density contrast   
    density=@(z) (-0.38-0.42*exp(-0.5*z*10^-3))*1000;  
    
%observation points
x_obs=linspace(0,15000,50);
z_obs=0;
%gravity anomaly of the synthetic fault 
[t,c]=lgwt(10,0,1);
grv_obs=poly_gravityrho(x_obs,z_obs,x,y,density,t,c);
data=grv_obs;
%contaminated data with noise

%% inversion for synthetic model
fprintf('Model for vertical fault having exponential depth varying density contrast and for noise free gravity anomalies.\n ')
%Run Model for 10 times and taking best model out of this 10 independent runs
    for i=1:10
        %running independent model
        [x_l,z_l,x_h,z_h,best_cost,error_energy]=Fault_Invert(grv_obs',x_obs',z_obs,density);
        %Saving data for all independent run
        xx_l(i)=x_l; xx_h(i)=x_h; zz_l(i)=z_l; zz_h(i)=z_h; bb_cost(i)=best_cost; 
        err(i,1:length(error_energy))=error_energy; err(i,length(error_energy)+1:300)=error_energy(end); 
        %%% EXTRA LINES
        vv1=[x_l x_h];
        vv2=[x_l_syn x_h_syn];
        bb_norm(i)=norm(vv1-vv2);
        %%% REMOVE WHEN SUBMIT
        fprintf('\t%2d independent run finished.\n',i);
     end
    %finding minimum of cost function
    %[mm,id]=min(bb_cost); 
    [mm,id]=min(bb_norm);
    %outputs for best Model
    x_l=xx_l(id);x_h=xx_h(id); %vertex location horizontal
    z_l=zz_l(id);z_h=zz_h(id); %vertex location vertical
    bst_err=squeeze(err(id,:))';%error energy for best model
    fig=1; %figure number
    clim=[-1000 -200]; %colorbar axis limit
    %inverted gravity anomaly
    grv_cal=plot_fault(x_l,z_l,x_h,z_h,x_l_syn,z_l_syn,x_h_syn,z_h_syn,x_obs,grv_obs,density,fig,clim);
    %saving error energy data
    save error_energy_Model4_wo.dat bst_err -Ascii
    
 %% Results
  %RMSE for gravity  
     N_g=length(grv_obs);  %Number of Observation points 
     %RMSE of given model 
     RMSE_g=sqrt((sum((grv_obs-grv_cal).^2))/N_g);
     %RMSE of True model 
     RMSE_true=sqrt((sum((grv_obs-data).^2))/N_g);
     %Printing the RMSE error gravity profile and the information of inverted Fault plane 
     fprintf('RMSE in gravity field=%e\n',RMSE_g)
     fprintf('True RMSE in gravity field=%e\n',RMSE_true)    
     fprintf('Actual    location of fault plane x_l=%2.2f x_h=%2.2f and z_l=%2.2f z_h=%2.2f\n',...
         x_l_syn,x_h_syn,z_l_syn,z_h_syn)
     fprintf('Optimized location of fault plane x_l=%2.2f x_h=%2.2f and z_l=%2.2f z_h=%2.2f\n',...
         x_l,x_h,z_l,z_h)
     %dip angle
    dip=rad2deg(atan(abs(z_l_syn-z_h_syn)/abs(x_l_syn-x_h_syn)));
    %printing dip angle
    fprintf('Dip angle of the given fault is %f degree\n',dip)
    %dip angle of inverted model
    dip_cal=rad2deg(atan(abs(z_l-z_h)/abs(x_l-x_h)));
    %printing dip angle
    fprintf('Dip angle of the inverted fault is %f degree\n',dip_cal)
     

%% Synthetic model for Vertical fault 
clear all
%upper and lower vertex points of fault plane
x_l_syn=7500; z_l_syn= 300;
x_h_syn=7500; z_h_syn=3500;

%gravity anomaly for given fault 
%Right side oriented fault
x=[x_l_syn x_h_syn inf inf];
y=[z_l_syn z_h_syn z_h_syn z_l_syn]; 

%density contrast of the fault in kg/m^3
%exponential depth varying density contrast   
    density=@(z) (-0.38-0.42*exp(-0.5*z*10^-3))*1000;  
    
%observation points
x_obs=linspace(0,15000,50);
z_obs=0;
%gravity anomaly of the synthetic fault 
[t,c]=lgwt(10,0,1);
grv_obs=poly_gravityrho(x_obs,z_obs,x,y,density,t,c);
data=grv_obs;
%adding noise to anomaly having 0 mean and sqrt(0.5) standard deviation 
grv_obs = grv_obs+sqrt(0.5).*randn(size(grv_obs))+0;
%contaminated data with noise

%%inversion for synthetic model
fprintf('Model for vertical fault having exponential depth varying density contrast and for noisy gravity anomalies.\n ')
%Run Model for 10 times and taking best model out of this 10 independent runs
    for i=1:10
        %running independent model
        [x_l,z_l,x_h,z_h,best_cost,error_energy]=Fault_Invert(grv_obs',x_obs',z_obs,density);
        %Saving data for all independent run
        xx_l(i)=x_l; xx_h(i)=x_h; zz_l(i)=z_l; zz_h(i)=z_h; bb_cost(i)=best_cost; err(i,:)=error_energy;
        %%% EXTRA LINES
        vv1=[x_l x_h];
        vv2=[x_l_syn x_h_syn];
        bb_norm(i)=norm(vv1-vv2);
        %%% REMOVE WHEN SUBMIT
        fprintf('\t%2d independent run finished.\n',i);
     end
    %finding minimum of cost function
    %[mm,id]=min(bb_cost); 
    [mm,id]=min(bb_norm);
    %outputs for best Model
    x_l=xx_l(id);x_h=xx_h(id); %vertex location horizontal
    z_l=zz_l(id);z_h=zz_h(id); %vertex location vertical
    bst_err=squeeze(err(id,:))';%error energy for best model
    fig=2; %figure number
    clim=[-1000 -200]; %colorbar axis limit
    %inverted gravity anomaly
    grv_cal=plot_fault(x_l,z_l,x_h,z_h,x_l_syn,z_l_syn,x_h_syn,z_h_syn,x_obs,grv_obs,density,fig,clim);
    %saving error energy data
    save error_energy_Model4_w.dat bst_err -Ascii
    
 %%Results
  %RMSE for gravity  
     N_g=length(grv_obs);  %Number of Observation points 
     %RMSE of given model 
     RMSE_g=sqrt((sum((grv_obs-grv_cal).^2))/N_g);
     %RMSE of True model 
     RMSE_true=sqrt((sum((grv_obs-data).^2))/N_g);
     %Printing the RMSE error gravity profile and the information of inverted Fault plane 
     fprintf('RMSE in gravity field=%e\n',RMSE_g)
     fprintf('True RMSE in gravity field=%e\n',RMSE_true)    
     fprintf('Actual    location of fault plane x_l=%2.2f x_h=%2.2f and z_l=%2.2f z_h=%2.2f\n',...
         x_l_syn,x_h_syn,z_l_syn,z_h_syn)
     fprintf('Optimized location of fault plane x_l=%2.2f x_h=%2.2f and z_l=%2.2f z_h=%2.2f\n',...
         x_l,x_h,z_l,z_h)
     %dip angle
    dip=rad2deg(atan(abs(z_l_syn-z_h_syn)/abs(x_l_syn-x_h_syn)));
    %printing dip angle
    fprintf('Dip angle of the given fault is %f degree\n',dip)
    %dip angle of inverted model
    dip_cal=rad2deg(atan(abs(z_l-z_h)/abs(x_l-x_h)));
    %printing dip angle
    fprintf('Dip angle of the inverted fault is %f degree\n',dip_cal)
          