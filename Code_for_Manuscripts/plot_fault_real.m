% ***************************************************************
% *** Matlab function for plotting fault planes
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************

%%Matlab code for plotting any fault for giving Fault plane location
function grv_cal=plot_fault_real(x_l,z_l,x_h,z_h,x_obs,grv_obs,density,clim)

    % [x_l,z_l] and [x_h,z_h] are the vertex points of the inverted Fault plane
    % x_obs     = horizontal locations of Observation points
    % grv_obs   = Gravity anomaly at observation points
    % density   = density distribution as a function of z; density=@(z) f(z)
    % clim      = axis limit for colorbar
    % For plotting the Fault we have required 6 planes each having 4 vertices
    %vertical location of observation points
    z_obs=0;
    %minimum and maximum location of observation points
    x_min=x_obs(1);x_max=x_obs(end); 
    %checking for orientation of the fault
                dd(1)=abs(grv_obs(1)); dd(2)=abs(grv_obs(end));
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
     %Gravity field of the fault for varying density
     [t,c]=lgwt(10,0,1); %Gauss Legendre quadrature
     grv_cal=poly_gravityrho(x_obs,z_obs,x,y,density,t,c);
     
     figure(1)
     %plotting for observed and inverted gravity profile 
     subplot(2,1,1)
     %observed gravity anomaly
     plot(x_obs,grv_obs,'ro','Linewidth',2)
     hold on
     %inverted gravity anomaly
     plot(x_obs,grv_cal,'Linewidth',2)
     %axis lebeling
     xlabel('Horizontal distance (m)')
     ylabel('Gravity anomaly (mGal)')
     legend('Synthetic data','Inverted data','Location','best')
     box on
     xlim([x_min x_max])
     %checking the orientation of the fault 
        if dd(1)>dd(2)  
            %Plotting Left side oriented fault
            figure(1)
            subplot(2,1,2)
            hold on
            %plotting the inverted model using patched surface
            p2=patch([x_l x_h x_obs(1) x_obs(1) x_l],[z_l z_h z_h z_l z_l],density([z_l z_h z_h z_l z_l]),'EdgeColor','none') ;
            %colormap for the surface plot
            colormap cool
            box on
            %making z axis in reverse direction
            set(gca,'Ydir','reverse')
            %x axis limit as per the maximum and minimum observation points 
            xlim([x_min x_max])
            %location of colorbar as per the density contrast and outside
            %the plotting region
            hp4 = get(subplot(2,1,2),'Position');
            c=colorbar('Position', [hp4(1)+hp4(3)+0.01  hp4(2)+0.03  0.015  .3]);
            %colorbar labelling
            c.Label.String = 'Density contrast (kg/m^3)';
            caxis(clim)
            set(c,'visible','off')
            %z location of end point of fault block
            z_left_end=1.5*abs(z_h-z_l)+z_h;
            %x location of end point of fault block
            x_left_end=((x_l-x_h)/(z_l-z_h))*(z_left_end-z_l)+x_l;
            hold off
            %plotting the hanging wall and footwall of fault
            subplot(2,1,2)
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
            %Plotting Right side oriented fault
            figure(1)
            %plotting the true model using red discontinuous line
            subplot(2,1,2)
            hold on
            %plotting the inverted model using patched surface
            p2=patch([x_l x_obs(end) x_obs(end) x_h x_l],[z_l z_l z_h z_h z_l],density([z_l z_l z_h z_h z_l]),'EdgeColor','none');
            %colormap for the surface plot
            colormap cool
            box on
            %making z axis in reverse direction
            set(gca,'Ydir','reverse')
            %x axis limit as per the maximum and minimum observation points 
            xlim([x_min x_max])
            %location of colorbar as per the density contrast and outside
            %the plotting region
            hp4 = get(subplot(2,1,2),'Position');
            c=colorbar('Position', [hp4(1)+hp4(3)+0.01  hp4(2)+0.03  0.015  .3]);
            %colorbar labelling
            c.Label.String = 'Density contrast (kg/m^3)';
            caxis(clim)
            set(c,'visible','off')
            %z location of end point of fault block
            z_left_end=1.5*abs(z_h-z_l)+z_h;
            %x location of end point of fault block
            x_left_end=((x_l-x_h)/(z_l-z_h))*(z_left_end-z_l)+x_l;
            hold off
            %plotting the hanging wall and footwall of fault
            subplot(2,1,2)
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
        %title(title2)      
end