clc;
clear all;
close all;

%% Define Parameters %%
p.m1 = 1; p.m2 = 1; p.F0 = 1; p.omega = 1; p.k = 1e4; p.l0 = 1;

r0 = [0; p.l0]; v0 = [0; 0]; z0 = [r0; v0];

tend = 10; tspan = [0; tend];

%% Define RHS %%
rhs = @(t,z) myrhs_constraint(z,t,p);

%% Define ODE %%
options = odeset('AbsTol',1e-3, 'RelTol', 1e-3);
solution = ode45(rhs, tspan, z0, options);

%% Animate ODE %%
% animate(solution, tspan, z0, 1);

%% Compare DAE Method with Direct Solution %%
rhs_dir = @(t,z) myrhs_wo_constraint(z, t, p);
solution_dir = ode45(rhs_dir, tspan, z0, options);

compare_error(solution, solution_dir, tspan)

%% Compare Solution with Spring %%
rhs_spring = @(t,z) myrhs_spring(z, t, p);
solution_spring = ode45(rhs_spring, tspan, z0, options);

compare_spring(solution, solution_spring, tspan);

%% Computation Time %%

tstart_dae = tic();
solution = ode45(rhs, tspan, z0, options);
tend_dae = toc(tstart_dae);

tstart_dir = tic();
solution_dir = ode45(rhs_dir, tspan, z0, options);
tend_dir = toc(tstart_dir);

tstart_spring = tic();
solution_spring = ode45(rhs_spring, tspan, z0, options);
tend_spring = toc(tstart_spring);

% It is seen that the direct approach is 1/10th the speed of the other two 
% approaches.

disp("***************************")
tend_dae
tend_dir
tend_spring