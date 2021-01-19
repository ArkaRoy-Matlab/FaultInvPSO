% ***************************************************************
% *** Matlab code for error energy plot   
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************

%Error Energy plot 
%%Matlab code for Error energy plot
clear all
close all

%% plotting for error energy
y1_wo=importdata('error_energy_Model1_wo.dat');
y2_wo=importdata('error_energy_Model2_wo.dat');
y3_wo=importdata('error_energy_Model3_wo.dat');
y4_wo=importdata('error_energy_Model4_wo.dat');
%converging to 10^-5
y1_wo(y1_wo<10^-5)=10^-5;
y2_wo(y2_wo<10^-5)=10^-5;
y3_wo(y3_wo<10^-5)=10^-5;
y4_wo(y4_wo<10^-5)=10^-5;

y1_w=importdata('error_energy_Model1_w.dat');
y2_w=importdata('error_energy_Model2_w.dat');
y3_w=importdata('error_energy_Model3_w.dat');
y4_w=importdata('error_energy_Model4_w.dat');

%Plotting of error energy of both model for noise free cases as shown in figure 6 (a).  	
figure(1)
%semi log plot for better visualization
semilogy(1:length(y1_wo),y1_wo,'--','linewidth',2)
hold on
semilogy(1:length(y2_wo),y2_wo,'-.','linewidth',2)
semilogy(1:length(y3_wo),y3_wo,'-v','linewidth',0.25)
semilogy(1:length(y4_wo),y4_wo,'linewidth',2)
ylim([10^-6 10^4])
%title and axis labeling
xlabel('Number of time steps')
ylabel('rms error (mGal)')
legend('Model1','Model2','Model3','Model4')
figure(2)
%semi log plot for better visualization
semilogy(1:length(y1_w),y1_w,'--','linewidth',2)
hold on
semilogy(1:length(y2_w),y2_w,'-.','linewidth',2)
semilogy(1:length(y3_w),y3_w,'-v','linewidth',0.25)
semilogy(1:length(y4_w),y4_w,'linewidth',2)
ylim([10^-1 10^2])
%title and axis labeling
xlabel('Number of time steps')
ylabel('rms error (mGal)')
%title('Error Energy plot for Noisy data')
legend('Model1','Model2','Model3','Model4')