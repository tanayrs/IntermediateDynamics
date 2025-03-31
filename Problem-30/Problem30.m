%% RO2102: Dynamics and Simulation
% Assignment 8; Problem-30
% By: Tanay Srinivasa, Time Spent: 2 Hours
clc;
clear all;
close all;

%% Define System Parameters %%
p.c = 1; p.g = 10;

%% Define Initial Conditions %%
r0 = [1; 1]; v0 = [0; 0];
z0 = [r0; v0];

tend = 10; tspan = [0, tend];

%% Call RHS %%
rhs = @(t,z) myrhs(z,t,p);

%% Solve ODE %%
options = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);
solution = ode45(rhs, tspan, z0, options);

%% Animate %%
animate(solution, z0, solution.x,p);