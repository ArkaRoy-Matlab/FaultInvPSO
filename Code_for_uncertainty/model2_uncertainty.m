% ***************************************************************
% *** Matlab code for Uncertainty analysis of synthetic model (Reverse Fault)
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenbbever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************
%%Matlab code for synthetic model (Reverse Fault) of gravity inversion 
clear all
close all

%% Synthetic model for Reverse fault 
%upper and lower vertex points of fault plane
x_l=5500; z_l= 300;
x_h=7300; z_h=2800;

%gravity anomaly for given fault 
%Left side oriented fault
x=[x_h x_l -inf -inf];
y=[z_h z_l z_l z_h];

%density contrast of the fault in kg/m^3
%linear depth varying density contrast   
    density=@(z) -750+((z-300)/9); 
    
%observation points
x_obs=linspace(0,15000,50);
z_obs=0;
%gravity anomaly of the synthetic fault 
[t,c]=lgwt(10,0,1);
grv_obs=poly_gravityrho(x_obs,z_obs,x,y,density,t,c);
grv_obs1=grv_obs;
    
    %% Problem Definition for noise free data
    tol1=0.2*10^2;
    tol2=0.2*10^-5;
    %loop for 5 independent run
    for ii=1:5
        [model,ccst,best_var,best_cost]=Fault_Invert_uncertainty(grv_obs',x_obs',z_obs,density,tol1,tol2);
         my_field1 = strcat('model',num2str(ii));
         variable.(my_field1) = model;
         my_field2 = strcat('cost',num2str(ii));
         variable.(my_field2) =ccst;
         bbst_ccst(ii)=best_cost;      
    end
    %finding minimum out of 3 independent run
    [v,p]=min(bbst_ccst);
    model=variable.(strcat('model',num2str(p)));
    ccst=variable.(strcat('cost',num2str(p)));
    best_cost=v;
    
    [pc,Evalues,W] =pca_reduction(model);
    %plot PCA space of the first two PCs: PC1 and PC2
    %plot(pc(1,:),pc(2,:),'.')  
      
     %plotting error topography
     x=pc(1,:); y=pc(2,:);
     [xq,yq] = meshgrid(min(x):10:max(x), min(y):10:max(y));
     vq = griddata(x,y,ccst,xq,yq);
     figure(1)
     subplot(2,1,1)
     %contour plot
     contourf(xq,yq,vq,10)
     colormap jet
     colorbar
     best_model=model(:,end);
     true_model=[x_l;z_l;x_h;z_h];
     %cost for true model
     true_cost=(norm(grv_obs-grv_obs1)./norm(grv_obs))*100;
     %location of true model and best model in pca plane
     loc_best_model=W*(best_model-mean(model,2));
     loc_true_model=W*(true_model-mean(model,2));
     %Plotting true model and best model in pca plane
     hold on
     plot(loc_best_model(1),loc_best_model(2),'r^','linewidth',4)
     plot(loc_true_model(1),loc_true_model(2),'gv','linewidth',4)
     %Axis labelling
     xlabel('Principal component 1')
     ylabel('Principal component 2')
     %title('Relative Misfit in PCA space(Reverse Fault), noise free data')
     lg1=sprintf('Equivalence function topography (in %%)');
     lg2=sprintf('Best model (relative misfit %2.2f%%)',best_cost);
     lg3=sprintf('True model (relative misfit %2.2f%%)',true_cost);
     legend(lg1,lg2,lg3,'location','best')
     
     %printing the result
     fprintf('For noise free problem\n')
     fprintf('\tRelative misfit for Best model=%f\n',best_cost)
     fprintf('\tRelative misfit for True model=%f\n',true_cost)

    %Adding noise 
    grv_obs1=grv_obs;
    %adding noise to anomaly having 0 mean and sqrt(0.75) standard deviation 
    grv_obs = grv_obs+sqrt(0.5).*randn(size(grv_obs))+0;
    
    %% Problem Definition for noise incorporated data
    %loop for 5 independent run
    for ii=1:5
        [model,ccst,best_var,best_cost]=Fault_Invert_uncertainty(grv_obs',x_obs',z_obs,density,tol1,tol2);
         my_field1 = strcat('model',num2str(ii));
         variable.(my_field1) = model;
         my_field2 = strcat('cost',num2str(ii));
         variable.(my_field2) =ccst;
         bbst_ccst(ii)=best_cost;      
    end
    %finding minimum out of 3 independent run
    [v,p]=min(bbst_ccst);
    model=variable.(strcat('model',num2str(p)));
    ccst=variable.(strcat('cost',num2str(p)));
    best_cost=v;
    
    [pc,Evalues,W] =pca_reduction(model);
    %plotting PC1 and PC2
    %plot PCA space of the first two PCs: PC1 and PC2
    %plot(pc(1,:),pc(2,:),'.')  
     
     %plotting error topography
     x=pc(1,:); y=pc(2,:);
     [xq,yq] = meshgrid(min(x):10:max(x), min(y):10:max(y));
     vq = griddata(x,y,ccst,xq,yq);
     %contour plot
     subplot(2,1,2)
     contourf(xq,yq,vq,10)
     colormap jet
     colorbar
     best_model=model(:,end);
     true_model=[x_l;z_l;x_h;z_h];
     %cost for true model
     true_cost=(norm(grv_obs-grv_obs1)./norm(grv_obs))*100;
     %location of true model and best model in pca plane
     loc_best_model=W*(best_model-mean(model,2));
     loc_true_model=W*(true_model-mean(model,2));
     %Plotting true model and best model in pca plane
     hold on
     plot(loc_best_model(1),loc_best_model(2),'r^','linewidth',4)
     plot(loc_true_model(1),loc_true_model(2),'gv','linewidth',4)
     %Axis labelling
     xlabel('Principal component 1')
     ylabel('Principal component 2')
     %title('Relative Misfit in PCA space(Reverse Fault), noise incorporated data')
     lg1=sprintf('Equivalence function topography (in %%)');
     lg2=sprintf('Best model (relative misfit %2.2f%%)',best_cost);
     lg3=sprintf('True model (relative misfit %2.2f%%)',true_cost);
     legend(lg1,lg2,lg3,'location','best')
     
     %printing the result
     fprintf('For noise incorporated problem\n')
     fprintf('\tRelative misfit for Best model=%f\n',best_cost)
     fprintf('\tRelative misfit for True model=%f\n',true_cost)