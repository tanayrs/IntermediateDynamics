% RO2102 Dynamics and Simulation %
% Assignment-2; Problem-9 %
% Tanay Srinivasa, 25 Jan 2025 %
% Due Date: 28 Jan 2025 %
% Time Spent on Problem: 2.5 Hours  %

clc;
clear all;
close all;

% Plotting options as defined in Homework Guidelines %
set(0,'DefaultAxesFontSize', 20);

% Parameters %
p.m = 1; p.g = 1; p.c = 1; time_scale = 5;

% Initial Conditions %
tstart = 0; tend = 2.5; tspan = [tstart, tend];
r0 = [0; 0]; v0_scalar = 1; theta0 = pi/4; 
v0 = [v0_scalar*cos(theta0); v0_scalar*sin(theta0)];
z0 = [r0; v0];

% Analytical solutions derived manually
[x_fun, y_fun] = analytical_sol(p,z0);

% Numerical Function %
rhs = @(t,z) myrhs(z, t, p);
options = odeset('AbsTol',1e-3, 'RelTol',1e-3);
solution = ode45(rhs,tspan,z0,options);

% Animation %
animation_ode45(solution, tspan, z0, time_scale);
animate_analytical_solution(x_fun, y_fun, tspan, p, time_scale);

% Error Comparison %
tspan_errors = [0 2];
compare_errors(x_fun, y_fun, rhs, tspan_errors, z0, p);

% Compare v0 %
tspan_v0 = [0; 500];
compare_v0(rhs, tspan_v0, theta0);
