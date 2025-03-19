clc;
clear all;
close all;

%% Define Parameters %%
p.m = 10; p.L = 1;

r0 = [-p.L/2; 0; p.L/2; 0]; v0 = [0; 1; 0; -1]; z0 = [r0; v0];

tend = 10; tspan = [0, tend];

%% Bring RHS %%
rhs = @(t,z) myrhs(z, t, p);

%% Define ODE %%
options = odeset('AbsTol',1e-6, 'RelTol', 1e-6);
solution = ode45(rhs, tspan, z0, options);

%% Animate %%
animate(solution, z0, 1);