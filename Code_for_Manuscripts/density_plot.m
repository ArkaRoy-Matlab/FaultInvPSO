% ***************************************************************
% *** Matlab code for plotting different depth varying density contrasts
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************
%%Matlab code for plotting of depth varying density contrasts
clear all
close all

%density contrast of the fault in kg/m^3
%linear depth varying density contrast   
    density2=@(z) -750+((z-300)/9); 
    
%exponential depth varying density contrast   
    density4=@(z) (-0.38-0.42*exp(-0.5*z*10^-3))*1000; 
    
%parabolic depth varying density contrast   
    density1=@(z) ((-0.65.^3)./((-0.5-0.1711.*z.*10^-3).^2)).*1000;   
    
%constant depth varying density contrast   
    density3=@(z) -600+0.*z; 
    
 %depth in m
 zz=linspace(0,3000,1001);
 %corresponding density values
 dd1=density1(zz);
 
 %corresponding density values
 dd2=density2(zz);
 
 %corresponding density values
 dd3=density3(zz);
 
 %corresponding density values
 dd4=density4(zz);
 
 %plotting the density contrasts
 subplot(2,2,1)
 plot(dd1,zz,'linewidth',2)
 ylabel('depth (m)')
 xlabel('density contrast (kg/m^3)')
 %title('parabolic density contrast')
 set(gca,'YDir','reverse')
 set(gca,'XDir','reverse')
 xlim([-1000 -100])
 subplot(2,2,2)
 plot(dd2,zz,'linewidth',2)
 ylabel('depth (m)')
 xlabel('density contrast (kg/m^3)')
 %title('linear density contrast')
 set(gca,'YDir','reverse')
 set(gca,'XDir','reverse')
 xlim([-1000 -100])
 
 subplot(2,2,3)
 plot(dd3,zz,'linewidth',2)
 ylabel('depth (m)')
 xlabel('density contrast (kg/m^3)')
 %title('constant density contrast')
 set(gca,'YDir','reverse')
 set(gca,'XDir','reverse')
 xlim([-1000 -100])
 
 subplot(2,2,4)
 plot(dd4,zz,'linewidth',2)
 ylabel('depth (m)')
 xlabel('density contrast (kg/m^3)')
 %title('exponential density contrast')
 set(gca,'YDir','reverse')
 set(gca,'XDir','reverse')
 xlim([-1000 -100])
 
 %****************************************************************%
 