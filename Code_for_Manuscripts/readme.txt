% ***************************************************************
% *** Help file for running all codes used in manuscript
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

	1. Data Files
		a. obs_Aswaraopet
		b. grv_Aswaraopet
		c. density_Aswaraopet
		d. error_energy_Model1_wo
		e. error_energy_Model1_w
		f. error_energy_Model2_w
		g. error_energy_Model2_wo
		h. error_energy_Model3_w
		i. error_energy_Model3_wo
		j. error_energy_Model4_w
		k. error_energy_Model4_wo
		l. model1_resolution
		m. model2_resolution
		n. model3_resolution
		o. model4_resolution
		p. cost_model1
		q. cost_model2
		r. cost_model3
		s. cost_model4

	File (a) is the observation points for Aswaraopet boundary fault which is used as real profile in manuscript.
	File (b) is the observed gravity anomaly for Aswaraopet boundary fault which is used as real profile in manuscript.
	file (c) information of depth varying density function for Aswaraopet boundary fault. 
	files(d), (e), (f), (g), (h), (i), (j), (k) are the data file for error energy plot of model1, model2, model3 and model4 for noise-free and noisy data case.
	files (l), (m), (n), (o) are the data for resolution for different number of observation points.
	files (p), (q), (r) and (s) are the files for parameter tuning of acceleration coefficients (c1, c2). 

	2. Subroutines
		a. lgwt.m
		b. Fault_Invert
		c. poly_gravityrho.m
		d. WIPSO.m
		e. plot_fault
		f. plot_fault_real

	a. lgwt.m - This script is for computing definite integrals using Legendre-Gauss 
 Quadrature. Computes the Legendre-Gauss nodes and weights  on an interval [a,b] with truncation order N. Suppose you have a continuous function f(x) which is defined on [a,b]
which you can evaluate at any x in [a,b]. Simply evaluate it at all of the values contained in the x vector to obtain a vector f. Then compute the definite integral using sum(f.*w);

	This code is written by Greg von Winckel - 02/25/2004. Here we have used it for our calculation and cited in main manuscript. 
	
	b. Fault_Invert.m - Main Matlab Function for Fault inversion having given Density distribution, observation points and corresponding gravity anomaly.
	
	c. poly_gravityrho.m - poly_gravityrho function calculates z component of gravity field for any polygon shape 2d body having depth varying density contrast. This program based on line integral in anticlockwise direction using Gauss Legendre quadrature
%integral formula. For more detail go through Zhou 2008. It is same as poly_gravity function but for depth varying density contrast. 

	d. WIPSO.m - WIPSO calculates the optimized parameters (best_var) for a given objective function (CostFunction) using Particle Swarm Optimization.
	
	e. plot_fault - Matlab function for plotting any synthetic fault for giving Fault plane locations in 2D view. 

	f. plot_fault - Matlab function for plotting any real fault for giving Fault plane locations in 2D view. 
	
	3. Source Codes
		a. model_normal_synthetic.m
		b. model_reverse_synthetic.m
		c. model_thrust_synthetic.m
		d. model_vertical_synthetic.m
		e. model1_resolution_appraisal.m
		f. model2_resolution_appraisal.m
		g. model3_resolution_appraisal.m
		h. model4_resolution_appraisal.m
		i. parameter_tuning_c1_c2_model1.m
		j. parameter_tuning_c1_c2_model2.m
		k. parameter_tuning_c1_c2_model3.m
		l. parameter_tuning_c1_c2_model4.m
		m. parameter_tuning_nPoP.m
		n. error_energy_plot.m
		o. generic_fault
		p. real_model.m
		q. density_plot.m
		r. parameter_tune_plot.m
		s. colorbars.m
		
	a. model_normal_synthetic.m- It calculates the inversion of gravity anomaly for a synthetic normal fault having parabolic density contrast with and without noise case (Model1) shown in figure 5 and 6. 

	b. model_reverse_synthetic.m- It calculates the inversion of gravity anomaly for a synthetic reverse fault having linear density contrast with and without noise case (Model2) shown in figure 5 and 6. 

	c. model_thrust_synthetic.m- It calculates the inversion of gravity anomaly for a synthetic thrust fault having uniform density contrast with and without noise case (Model3) shown in figure 5 and 6. 

	d. model_vertical_synthetic.m- It calculates the inversion of gravity anomaly for a synthetic vertical fault having exponential density contrast with and without noise case (Model4) shown in figure 5 and 6. 
	
	e. model1_resolution_appraisal.m- It calculates the number of observation points vs. accuracy of the inverted structure synthetic Model1 shown in figure 9. 

	f. model2_resolution_appraisal.m- It calculates the number of observation points vs. accuracy of the inverted structure synthetic Model2 shown in figure 9. 

	g. model3_resolution_appraisal.m- It calculates the number of observation points vs. accuracy of the inverted structure synthetic Model3 shown in figure 9. 

	h. model4_resolution_appraisal.m- It calculates the number of observation points vs. accuracy of the inverted structure synthetic Model4 shown in figure 9.

	i. parameter_tuning_c1_c2_model1.m- This code for Parameter tuning of PSO for acceleration coefficients (c1, c2) for model 1.  Output of the code is shown in figure 4. 
 	
	j. parameter_tuning_c1_c2_model2.m- This code for Parameter tuning of PSO for acceleration coefficients (c1, c2) for model 2.  Output of the code is shown in figure 4. 
 
	k. parameter_tuning_c1_c2_model3.m- This code for Parameter tuning of PSO for acceleration coefficients (c1, c2) for model 3.  Output of the code is shown in figure 4. 
 
	l. parameter_tuning_c1_c2_model4.m- This code for Parameter tuning of PSO for acceleration coefficients (c1, c2) for model 4.  Output of the code is shown in figure 4. 

	m. parameter_tuning_nPoP.m - This code for Parameter tuning of particle population. Output of the code is shown in table 2.

	n. error_energy_plot.m- This code plots rms error as shown in figure 7 in the manuscript.   
 
	o. generic_fault.m- This code plots general fault plane shown in figure 1 of the manuscript.  

	p. real_model.m- It calculates the fault structure of Aswaraopet boundary fault using inversion of gravity anomaly. Output is shown in figure 9.

	q. density_plot.m- It plots all four density distributions shown in figure 3.
	

	r. parameter_tune_plot.m- It plots output of parameter tune data for all models.

	s. colorbars.m - It plots all colorbars separately for different models.

	
