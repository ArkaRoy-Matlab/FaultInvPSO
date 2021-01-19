% ***************************************************************
% *** Matlab code for synthetic model (Normal Fault) of gravity inversion 
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************
%%Matlab code for synthetic model (Normal Fault) of gravity inversion for
%%error resolution plot
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
    cnt=0;
%loop for different data resolutions 
for i_rs=3:50
cnt=cnt+1;
%observation points
x_obs=linspace(0,15000,i_rs);
z_obs=0;
%gravity anomaly of the synthetic fault 
[t,c]=lgwt(10,0,1);
grv_obs=poly_gravityrho(x_obs,z_obs,x,y,density,t,c);
data=grv_obs;
    
%% inversion for synthetic model
fprintf('Model for vertical fault having exponential depth varying density contrast and for noise free gravity anomalies.\n ')
%Run Model for 10 times and taking best model out of this 10 independent runs
    for i=1:10
        %running independent model
        [x_l,z_l,x_h,z_h,best_cost,error_energy]=Fault_Invert(grv_obs',x_obs',z_obs,density);
        %Saving data for all independent run
        xx_l(i)=x_l; xx_h(i)=x_h; zz_l(i)=z_l; zz_h(i)=z_h; bb_cost(i)=best_cost; err(i,:)=error_energy;
        %%% EXTRA LINES
        vv_x1=[x_l x_h];
        vv_x2=[x_l_syn x_h_syn];
        vv_z1=[z_l z_h];
        vv_z2=[z_l_syn z_h_syn];
        %bb_norm(i)=norm(vv_x1-vv_x2)+norm(vv_z1-vv_z2);
        bb_norm(i)=norm(z_h-z_h_syn);
        %%% REMOVE WHEN SUBMIT
        
     end
   %finding minimum of cost function
    [mm,id]=sort(bb_norm);
    if mm<=10^-14
        mm=10^-14;
    end
    bst_err(cnt)=mean(bb_norm(id(1:3)));%error norm for fault location
    loc(cnt)=i_rs;
    fprintf('\tfor %d data points location error norm=%2.2e.\n',i_rs,bst_err(cnt));
end
%%
save model4_resolution.dat bst_err -ascii
