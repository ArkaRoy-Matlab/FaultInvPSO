% ***************************************************************
% *** Matlab function for plotting colorbar 
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************

%%Matlab code for plotting the colorbar of given axix values
clear all
close all
%figure 1 for plotting colorbar with density limit -1000 to -200 kg/m^3
figure(1)
ax = axes;
%position of color bar
c=colorbar('Position', [0.15  0.4 0.75 0.025],'location','southoutside');   
%colormap type
colormap cool
%axix limit
caxis([-1000 -200])
%axis title
c.Label.String = 'Density (kg/m^3)';
%set axis visible off
ax.Visible = 'off';

%figure 2 for plotting colorbar with generation count 200 to 1000  
figure(2)
ax = axes;
%all colors
cll={'red','yellow','lime','cyan','blue','purple'};
%making colormaps
ccmap=makecolormap(cll, 64);
%axis limit
caxis([200 1000])
%colormap type
colormap(ccmap)
%position of color bar
c=colorbar('Position', [0.15  0.4 0.75 0.025],'location','southoutside');   
%axis title
c.Label.String = 'Number of time steps';
%set axis visible off
ax.Visible = 'off';

%figure 3 for plotting colorbar with density limit -450 to -100 kg/m^3
figure(3)
ax = axes;
%position of color bar
c=colorbar('Position', [0.15  0.4 0.75 0.025],'location','southoutside');   
%colormap type
colormap cool
%axix limit
caxis([-450 -100])
%axis title
c.Label.String = 'Density (kg/m^3)';
%set axis visible off
ax.Visible = 'off';

