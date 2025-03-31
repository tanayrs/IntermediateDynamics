%% RO2102: Dynamics and Simulation
% Assignment 8; Problem-26
% By: Tanay Srinivasa, Time Spent: 2 Hour

clc;
clear all;
close all;

%% Set Initial Conditions %%
phi0 = 0;
tend = 10; tspan = [0; tend];

%% Call RHS %%
rhs = @(t,phi) myrhs(phi,t);

%% Solve ODE %%
options = odeset('AbsTol',1e-6, 'RelTol', 1e-6);
solution = ode45(rhs, tspan, phi0, options);

%% Plot ODE %%
t = linspace(solution.x(1), solution.x(end),1000);
phi = deval(solution,t);

figure;
plot(t,phi);
hold on;
xlabel("t (s)");
ylabel("\phi (rad)");
title("\phi vs t")
hold off;

figure;
animate(solution, phi0, solution.x);