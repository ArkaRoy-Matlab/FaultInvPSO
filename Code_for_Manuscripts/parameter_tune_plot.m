% ***************************************************************
% *** Matlab code for plotting parameter tunning plot and depth
%     resolution plot
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************

%%Matlab code for plotting all generation counts for different models and
%%resolution plots for different number of data points 
clear all
close all
%importing data for 1st model
yy=importdata('cost_model1.dat');
c1=0.1:0.1:2; c2=0.1:0.1:2;
[C1,C2]=meshgrid(c1,c2);
figure(1)
subplot(2,2,1)
surf(C1,C2,yy')
view(0,90)
box on
caxis([200 1000])
xlabel('C1')
ylabel('C2')
zlabel('generation count')
shading interp
hold on
plot3([0.1 1.1],[0.6 0.6],[1000 1000], 'k--','linewidth',2)
plot3([0.1 1.1],[1.4 1.4],[1000 1000], 'k--','linewidth',2)
plot3([1.1 1.1],[0.6 1.4],[1000 1000], 'k--','linewidth',2)
plot3([0.1 0.1],[0.6 1.4],[1000 1000], 'k--','linewidth',2)
%importing data for 2nd model
yy=importdata('cost_model2.dat');
subplot(2,2,2)
surf(C1,C2,yy')
view(0,90)
box on
caxis([200 1000])
shading interp
xlabel('C1')
ylabel('C2')
zlabel('generation count')
hold on
plot3([0.1 1.1],[0.6 0.6],[1000 1000], 'k--','linewidth',2)
plot3([0.1 1.1],[1.4 1.4],[1000 1000], 'k--','linewidth',2)
plot3([1.1 1.1],[0.6 1.4],[1000 1000], 'k--','linewidth',2)
plot3([0.1 0.1],[0.6 1.4],[1000 1000], 'k--','linewidth',2)
%importing data for 3rd model
yy=importdata('cost_model3.dat');
subplot(2,2,3)
surf(C1,C2,yy')
view(0,90)
box on
caxis([200 1000])
shading interp
xlabel('C1')
ylabel('C2')
zlabel('generation count')
hold on
plot3([0.1 1.1],[0.6 0.6],[1000 1000], 'k--','linewidth',2)
plot3([0.1 1.1],[1.4 1.4],[1000 1000], 'k--','linewidth',2)
plot3([1.1 1.1],[0.6 1.4],[1000 1000], 'k--','linewidth',2)
plot3([0.1 0.1],[0.6 1.4],[1000 1000], 'k--','linewidth',2)
%importing data for 4th model
yy=importdata('cost_model4.dat');
subplot(2,2,4)
surf(C1,C2,yy')
view(0,90)
box on
cll={'red','yellow','lime','cyan','blue','purple'};
ccmap=makecolormap(cll, 64);
caxis([200 1000])
colormap(ccmap)
shading interp
xlabel('C1')
ylabel('C2')
zlabel('generation count')
hold on
plot3([0.1 1.1],[0.6 0.6],[1000 1000], 'k--','linewidth',2)
plot3([0.1 1.1],[1.4 1.4],[1000 1000], 'k--','linewidth',2)
plot3([1.1 1.1],[0.6 1.4],[1000 1000], 'k--','linewidth',2)
plot3([0.1 0.1],[0.6 1.4],[1000 1000], 'k--','linewidth',2)

%importing all data for observed data resolutions
y1=importdata('model1_resolution.dat');
y2=importdata('model2_resolution.dat');
y3=importdata('model3_resolution.dat');
y4=importdata('model4_resolution.dat');

loc=3:50;
%%Plotting for resolution plot
figure(2)
semilogy(loc,y1,'linewidth',2)
hold on
semilogy(loc,y2,'*-','linewidth',2)
semilogy(loc,y3,'o-','linewidth',2)
semilogy(loc,y4,'d-','linewidth',2)
xlabel('Number of observation points')
ylabel('Error norm (m)')
legend('Model-1','Model-2','Model-3','Model-4')