% ***************************************************************
% *** Matlab function for uncertainty apprisal for fault structure
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whebbnever it is used.
% *** Developed by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************

%%Matlab Function for Fault inversion having given Density distribution
function [model,ccst,best_var,best_cost]=Fault_Invert_uncertainty(data,x_obs,z_obs,density,tol1,tol2)

    %% Input Parameters
    %data         =  gravity anomaly in mGal
    %x_obs        =  Horizontal location of oservation points 
    %z_obs        =  Vertical location of oservation points
    %y_span       =  span of y direction of the fault in meter
    %tol1         =  saving model data beyond this threshold
    %tol2         =  breaking the model;
    %% Output Parameters
    %Location of Fault Plane
    %[xl,yl]  = %location of lower vertex of fault plane
    %[xh,yh]  = %location of  upper vertex of fault plane
    
    %% Problem Definition
    [t,c]=lgwt(10,0,1); 
    CostFunction =@(x) myCostFunction(x,data',x_obs',z_obs,density,t,c)+10000*constrained(x);
    %Legendre Gaussian quadrature integral points.
    c1=1.4; c2=1.7;
    nVar=4;                %Number of Unknown Variable including density
    MaxIt = 300;           %Maximum number of iterations
    nPoP =  40;            %Population size or swarm size
    %Optimization using PSO 
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
    bc=0; %counter for saving model data having cost less than tol
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
       
        if BestCost(it)<tol1
            bc=bc+1;
            model(:,bc)=GlobalBest.Position;   %model parameters
            ccst(bc,1)=GlobalBest.Cost;        %cost for choosen model parameter
            %fprintf('After %d iterations Best Cost Value= %.7f\n',bc,BestCost(it))  
        end
        %printing the cost after each iterations 
        %fprintf('After %d iterations Best Cost Value= %.7f\n',it,BestCost(it))  
        
        if BestCost(it)<tol2
            break
        end
            
    end
    %best parameter values for the optimization
        best_var= (GlobalBest.Position)'; 
        best_cost= BestCost(it);
        iter_count= it;  
    
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
                %val=norm(data-yy1)./norm(data);
                val=(norm(data-yy1)./norm(data))*100;
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

end