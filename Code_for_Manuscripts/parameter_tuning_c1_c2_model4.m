% ***************************************************************
% *** Matlab code for Parameter tuning of c1 and c2  for  PSO   
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************

%% Code for Parameter tuning of c1 and c2 for PSO  
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
%% Problem Definition
%all parameters for c1 and c2 for tunning 
cc1=0.1:0.1:2; cc2=0.1:0.1:2; 
%loop for varyng c1 and c2
for ic1=1:length(cc1)
    for ic2=1:length(cc2)
%Run Model for 10 times and taking best model out of this 10 independent runs
    for ii=1:10
        CostFunction =@(x) myCostFunction(x,grv_obs,x_obs,z_obs,density,t,c)+10000*constrained(x);
        %accelaration coefficients variation
        c1=cc1(ic1); c2=cc2(ic2);
        nVar=4;                %Number of Unknown Variable including density
        MaxIt = 1000;           %Maximum number of iterations
        nPoP =  40;            %Population size or swarm size
        %Optimization using PSO 
        tic
        [best_var, best_cost,iter_count,error_energy]  = WIPSO_spl(CostFunction,nVar,MaxIt,nPoP,c1,c2);
        time=toc;
        all_best(ii,1)=best_cost;
        all_best(ii,2)=time;
        all_best(ii,3)=iter_count;
        
    end
%mean of all best cost, computation time and iteration count
[val,id]=sort(all_best(:,1));
mean_beast=mean(all_best(id(1:3),:));
costt(ic1,ic2)=mean_beast(1);
timee(ic1,ic2)=mean_beast(2);
iterr(ic1,ic2)=floor(mean_beast(3));
%printing results for all c1 and c2
fprintf('For c1=%1.1f and c2=%1.1f, best cost =%2.2e, best time==%2.4f and number of iteration=%d\n',c1,c2,costt(ic1,ic2),timee(ic1,ic2),iterr(ic1,ic2))
    end
end    
save cost_model4.dat iterr
%% Cost function for optimization
        function val=myCostFunction(x,data,x_obs,z_obs,density,t,c)

        %Inputs
                %x       = parameters to be optimized in meter
                %          defines the location of Fault plane (vertices)
                %data    = Gravity anomaly data for optimization in mGal
                %x_obs   = Horizontal location of observation points in meter
                %z_obs   = Vartical location of observation point in meter
                %density = density distribution as a function of z;
                %           density=@(z) f(z) in kg/m^3
                %t       = Gauss legendre nodes for integration
                %c       = Gauss legendre weights for integration
         %Output
                %val= misfit functional value for optimized parameter

                %locations of Fault plane from parameters
                xll=x(1); yll=x(2);  %location of lower vertex of fault plane
                xhh=x(3); yhh=x(4);  %location of upper vertex of fault plane

                %checking for orientation of the fault
                dd1(1)=abs(data(1)); dd1(2)=abs(data(end));
                if dd1(1)>dd1(2)  
                    %Right side oriented fault
                    x1=[xhh xll -inf -inf];
                    y1=[yhh yll yll yhh];

                else
                    %Left side oriented fault
                    x1=[xll xhh inf inf];
                    y1=[yll yhh yhh yll];
                end

                %Gravity field of the basin for varying density
                yy1=poly_gravityrho(x_obs,z_obs,x1,y1,density,t,c);
                %misfit error
                val=sqrt((sum((data-yy1).^2))/length(data));

        end

      %Depth Constraint for the optimization 
        function val=constrained(x)
        %Function constrained will provides the depth constraint for lower
        %limit of the depth for fault optimization
            %x       = parameters to be optimized in meter

            val=0;
            %implementing Penalty constraint for optimization
            for ii=1:4
                rr=x(ii);
                gg=(-rr);
                %value for penalty function
                val=val+(max(0,gg))^2;
            end
        end
 %PSO Algorithm with a break point after achieving desire accuracy       
 function [best_var, best_cost,iter_count,error_energy]  = WIPSO_spl(CostFunction,nVar,MaxIt,nPoP,c1,c2)
	% WIPSO_spl calculates the optimized parameters (best_var) for a given objective function (CostFunction)
	% using Particle Swarm Optimization.
%Inputs
%	Costfunction = Objective function of the optimization problem
%	nVar		 = Number of parameters of the optimization problem
%   Maxit		 = Maximum Generations for PSO 	
%	nPoP		 = Number of particles of the swarm in PSO
%	c1           = cognitive component of PSO
%	c2           = social component of PSO

%Outputs 
%best_var		= optimized parameters for PSO
%best_cost		= value of objective function for optimized parameters
%iter_count		= required number of generations for optimization
%error_energy   = Error energy after each generations. 
	
    VarSize = [1 nVar];     %Matrix size of Decision variables
    VarMin= -ones(1,nVar);          %Lower Bound of Unknown variable
    VarMax= ones(1,nVar);           %Upper Bound of Unknown variable

    %% Parameters of PSO
    w_min=0.1; w_max=0.9;                     %inertia coefficient
         
    %% Initialization
    Empty.Particle.Position =[];
    Empty.Particle.Velocity =[];
    Empty.Particle.Cost     =[];

    Empty.Particle.Best.Position =[];
    Empty.Particle.Best.Cost     =[];

    Particle=repmat(Empty.Particle, nPoP,1);

    %initial global best
    GlobalBest.Cost= Inf;
    for i=1:nPoP
        %initialize position with random number from VarMin and VarMax
        for j=1:nVar
            Particle(i).Position(j) =(VarMax(j)-VarMin(j))*rand(1) + VarMin(j);
        end
        %Initialize Velocity
        Particle(i).Velocity =zeros(VarSize);
        %checking cost function value
        Particle(i).Cost = CostFunction(Particle(i).Position);
        %update personal best
        Particle(i).Best.Position =Particle(i).Position;
        Particle(i).Best.Cost =Particle(i).Cost;
        %Update global best
        if Particle(i).Best.Cost < GlobalBest.Cost
            GlobalBest= Particle(i).Best;
        end
    end

    %Best cost value in each iterations
    BestCost=zeros(MaxIt,1);

    %%  Main loop of PSO
%loop for each time steps 
    for it=1: MaxIt
        w=w_max-((w_max-w_min)/MaxIt)*it;
        %loop for all particles of the swarm
        for i=1:nPoP
            %Update Velocity
            Particle(i).Velocity= (w).*Particle(i).Velocity+ ...
                c1*rand(VarSize).*(Particle(i).Best.Position-Particle(i).Position) ...
                + c2*rand(VarSize).*(GlobalBest.Position-Particle(i).Position);
            %Update Position
            Particle(i).Position=Particle(i).Position+Particle(i).Velocity;
            %cost for this iteration
            Particle(i).Cost = CostFunction(Particle(i).Position);
            %Update Personal Best
            if Particle(i).Cost < Particle(i).Best.Cost
                Particle(i).Best.Position =Particle(i).Position;
                Particle(i).Best.Cost =Particle(i).Cost;
                %Update Global Best
                if Particle(i).Best.Cost < GlobalBest.Cost
                    GlobalBest= Particle(i).Best;
                end
            end
        end
        %Display iteration information
        %Store Best Cost value
        BestCost(it)=GlobalBest.Cost;
        %break the process if misfit achieved 0.01
        if BestCost(it)<10^-5
            break
        end
        %printing the cost after each iterations 
        %fprintf('After %d iterations Best Cost Value= %.7f\n',it,BestCost(it))  
        %value for error energy plot
        error_energy(it)=(BestCost(it)).^2;
    end
    %best parameter values for the optimization
        best_var= (GlobalBest.Position)'; 
        best_cost= BestCost(it);
        iter_count= it;  
end       