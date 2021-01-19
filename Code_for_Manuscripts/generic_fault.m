clear all
close all
density=@(z) ((-0.65.^3)./((-0.5-0.1711.*z.*10^-3).^2)).*1000;
x_l=3000; x_h=5000; 
z_l=3000; z_h=5000;
x_obs=linspace(0,10000);

            figure(1)
            hold on
            %plotting the inverted model using patched surface
            p2=patch([x_l x_h x_obs(1) x_obs(1) x_l],[z_l z_h z_h z_l z_l],density([z_l z_h z_h z_l z_l]),'EdgeColor','red','linewidth',02.5) ;
            %colormap for the surface plot
            colormap cool
            box on
            %making z axis in reverse direction
            set(gca,'Ydir','reverse')
            %x axis limit as per the maximum and minimum observation points 
            xlim([0 10000])
            %z location of end point of fault block
            z_left_end=1.5*abs(z_h-z_l)+z_h;
            %x location of end point of fault block
            x_left_end=((x_l-x_h)/(z_l-z_h))*(z_left_end-z_l)+x_l;
            hold off
            hold on
            %plotting the hanging wall and footwall of fauult
            %plotting the Footwall
            plot([x_h  x_left_end x_obs(1) x_obs(1) x_h],[z_h z_left_end z_left_end z_h z_h],'r','linewidth',02.5) 
            fill([x_h  x_left_end x_obs(1) x_obs(1) x_h],[z_h z_left_end z_left_end z_h z_h],'y','facealpha',0.22)
            %z location of end point of fault block
            z_mid_end=1.5*abs(z_h-z_l)+z_l;
            %x location of end point of fault block
            x_mid_end=((x_l-x_h)/(z_l-z_h))*(z_mid_end-z_l)+x_l;
            %plotting the hanging wall
            plot([x_l  x_mid_end x_obs(end) x_obs(end) x_l],[z_l z_mid_end z_mid_end z_l z_l],'r','linewidth',02.5) 
            fill([x_l  x_mid_end x_obs(end) x_obs(end) x_l],[z_l z_mid_end z_mid_end z_l z_l],'y','facealpha',0.22)
            hold off
            ylim([0 10000])
            hold on
            plot(x_obs,1000*ones(size(x_obs)),'linewidth',2.5)
            plot(x_l,z_l,'k*','linewidth',5)
            plot(x_h,z_h,'k*','linewidth',5)
            %text(1500,2500,'A (\it x_l , z_l )','FontSize',16)
            %text(5300,z_h,'B ( \itx_h , z_h )','FontSize',16)
            plot(8000,1000,'b*','linewidth',5)
            %text(8000,500,'P ( \itx_i , z_i )','FontSize',16)
            %text(4900,-5,'Observation point','FontSize',16)
            set(gca,'xtick',[])
            set(gca,'xticklabel',[])
            set(gca,'ytick',[])
            set(gca,'yticklabel',[])
            box off
            %xlabel('x direction (m)')
            %ylabel('z direction (m)')