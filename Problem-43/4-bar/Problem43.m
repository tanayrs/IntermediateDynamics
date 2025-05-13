%% RO2102: Dynamics and Simulation
% Assignment 8; Problem-30
% By: Tanay Srinivasa, Time Spent: 2 Hours

clc;
clear all;
close all;

%% System Parameters %%
p.Ig1 = 1; p.Ig2 = 1; p.Ig3 = 1; p.d1 = 0.5; p.d2 = 0.5; p.d3 = 0.5;
p.g = 10; p.l1 = 1; p.l2 = 1; p.l3 = 1; p.m1 = 10; p.m2 = 10; p.m3 = 10;

z0 = [pi/2; pi/4; pi/5; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
% z0 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
tend = 10 ; tspan = [0 tend];

time_scale = tend/10;

%% DAE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initial Conditions for DAE %%

%% Call RHS %%
rhs_dae = @(t,z) myrhs_dae(z,t,p);

%% Solve ODE %%
options = odeset('AbsTol',1e-6,'RelTol',1e-6);
solution_dae = ode45(rhs_dae,tspan,z0,options);

%% Animate %%
animate(solution_dae, tspan, z0, p, time_scale);

%% Energy Check %%
[E1, E2] = energy_check(solution_dae,p,"DAE")