% ***************************************************************
% *** Matlab code for inversion of Aswaraopet Fault from gravity anomaly   
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************

%%Matlab code for real field example of Aswaraopet Fault for gravity inversion 
clear all
close all

%% Importing data for Aswaraopet Fault 
grv_obs= importdata('grv_Aswaraopet.dat'); %Gravity Anomaly
x_obs  = importdata('obs_Aswaraopet.dat'); %Observation points
%density contrast of the fault in kg/m^3
density=@(z) ((-0.5.^3)./((-0.5-0.1711.*z.*10^-3).^2)).*1000; 

%% inversion for Real model
%Run Model for 10 times and taking best model out of this 10 independent runs
z_obs=0; 
    for i=1:10
        %running independent model
        [x_l,z_l,x_h,z_h,best_cost,error_energy]=Fault_Invert(grv_obs,x_obs,z_obs,density);
        %Saving data for all independent run
        xx_l(i)=x_l; xx_h(i)=x_h; zz_l(i)=z_l; zz_h(i)=z_h; bb_cost(i)=best_cost; err(i,:)=error_energy;
        fprintf('\t%d independent run finished.\n',i);
     end
    %finding minimum of cost function
    [mm,id]=min(bb_cost);
    %outputs for best Model
    x_l=xx_l(id);x_h=xx_h(id); %vertex location horizontal
    z_l=zz_l(id);z_h=zz_h(id); %vertex location vertical
    bst_err=squeeze(err(id,:))';%error energy for best model
    clim=([-450 -100]); %colorbar axis limit
    
    %inverted gravity anomaly
    grv_cal=plot_fault_real(x_l,z_l,x_h,z_h,x_obs,grv_obs,density,clim);
    %saving error energy data
    %save error_energy_Model4_wo.dat bst_err -Ascii
    %save error_energy_Model1_w.dat bst_err -Ascii
 %% Uncertainty Estimation 
  %RMSE for gravity  
     N_g=length(grv_obs);  %Number of Observation points 
     %RMSE of given model 
     RMSE_g=sqrt((sum((grv_obs'-grv_cal).^2))/N_g);
     
     %Printing the RMSE error gravity profile and the information of inverted Fault plane 
     fprintf('RMSE in gravity field=%e\n',RMSE_g)
     fprintf('Optimized location of fault plane x_l=%2.2f x_h=%2.2f and z_l=%2.2f z_h=%2.2f\n',...
         x_l,x_h,z_l,z_h)
    %dip angle of inverted model
    dip_cal=rad2deg(atan(abs(z_l-z_h)/abs(x_l-x_h)));
    %printing dip angle
    fprintf('Dip angle of the inverted fault is %f degree\n',dip_cal)