% RO2102 Dynamics and Simulation %
% Assignment-4; Problem-12 %
% Tanay Srinivasa, 25 Jan 2025 %
% Due Date: 11 Feb 2025 %
% Time Spent on Problem: 1 Hours  %

clc;
clear all;
close all;

% Plotting options as defined in Homework Guidelines %
set(0,'DefaultAxesFontSize', 20);

% Parameters %
p.m = 1; p.g = 1; p.c = 1; time_scale = 1;

% Initial Conditions %
tstart = 0; tend = 10; tspan = [tstart, tend];
r0 = [0; 0]; v0_scalar = 1; theta0 = pi/4; 
w0 = 0.5*p.m*(v0_scalar^2) + (p.m*p.g*r0(2));
v0 = [v0_scalar*cos(theta0); v0_scalar*sin(theta0)];
z0 = [r0; v0; w0];

% Numerical Function %
rhs = @(t,z) myrhs(z, t, p);
options = odeset('AbsTol',1e-3, 'RelTol',1e-3, 'Events',@hit_ground);
solution = ode45(rhs,tspan,z0,options);

time = solution.x;

% Animation %
animate(solution, [time(1), time(end)], z0, time_scale);

% Plot Work %
plot_work(solution,p, time)

% Plot Error %
plot_error(rhs, tspan, z0, p);

% Event function to detect ground hit
function [value, isterminal, direction] = hit_ground(t, z)
    value = z(2);    
    isterminal = 1;
    direction = -1;
end
