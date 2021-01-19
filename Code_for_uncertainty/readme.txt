% ***************************************************************
% *** Help file for running codes for uncertainty appraisal
% *** Source Code is mainly written for research purposes. The codes are
% *** having copyrights and required proper citations whenever it is used.
% *** Originated by:
% ***       Mr. Arka Roy (email: arka.phy@gmail.com)
% ***       Mr. Thatikonda Suresh Kumar (email: sureshkumarncess@gmail.com)
% ***       Crustal Processes Group, National Centre for Earth Science Studies,
% ***       Ministry of Earth Sciences, Government of India
% ***       Thiruvanthapuram, Kerala, India
% ****************************************************************
This is a help file for a description of all Data, Source Code, and Subroutine used for the implementation of our present paper 
'FaultInvPSO: A Matlab based program for Gravity inversion of 2D Fault having variable density contrast using Particle Swarm Optimization.'  

(Copy all set of files including data in one folder and run)

	1. Subroutines
		a. lgwt.m
		b. Fault_Invert_uncertainty
		c. poly_gravityrho.m
		d. WIPSO_uncertainty.m
		e. pca_reduction

	a. lgwt.m - This script is for computing definite integrals using Legendre-Gauss 
 Quadrature. Computes the Legendre-Gauss nodes and weights  on an interval [a,b] with truncation order N. Suppose you have a continuous function f(x) which is defined on [a,b]
which you can evaluate at any x in [a,b]. Simply evaluate it at all of the values contained in the x vector to obtain a vector f. Then compute the definite integral using sum(f.*w);

	This code is written by Greg von Winckel - 02/25/2004. Here we have used it for our calculation and cited in main manuscript. 
	
	b. Fault_Invert_uncertainty.m - Main Matlab Function for Fault inversion having given Density distribution, observation points and corresponding gravity anomaly and used for uncertainty analysis.
	
	c. poly_gravityrho.m - poly_gravityrho function calculates z component of gravity field for any polygon shape 2d body having depth varying density contrast. This program based on line integral in anticlockwise direction using Gauss Legendre quadrature
%integral formula. For more detail go through Zhou 2008. 

	d. WIPSO_uncertainty.m - WIPSO_uncertainty calculates the optimized parameters (best_var) for a given objective function (CostFunction) using Particle Swarm Optimization.
	
	e. pca_reduction - Matlab function for principal component analysis and projecting actual data into pca space. 

	
	3. Source Codes
		a. model1_uncertainty.m
		b. model2_uncertainty.m
		c. model3_uncertainty.m
		d. model4_uncertainty.m
				
	a. model1_uncertainty.m- It calculates the uncertainty appraisal for model 1 and plotting the error topography as shown in figure 8.

	b. model2_uncertainty.m- It calculates the uncertainty appraisal for model 1 and plotting the error topography as shown in figure 8.

	c. model3_uncertainty.m- It calculates the uncertainty appraisal for model 1 and plotting the error topography as shown in figure 8.

	d. model4_uncertainty.m- It calculates the uncertainty appraisal for model 1 and plotting the error topography as shown in figure 8.	
	