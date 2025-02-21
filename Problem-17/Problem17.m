%% RO2102: Dynamics and Simulation
% Assignment 5; Problem-17
% By: Tanay Srinivasa, Time Spent: 1 Hour 40 Min

clc;
clear all;
close all;

%% 2.1 Time Units
p.G = 1; p.m = 1;

% r10 = [0; 1.5]; r20 = -1.5*[sind(60); cosd(60)]; r30 = 1.5*[sind(60); -cosd(60)];
r10 = [-0.9700046; 0.24308753]; r20 = -r10; r30 = [0; 0];

% v_scalar = sqrt(4*p.G*p.m/p.d);
% v10 = [v_scalar; 0]; v20 = v_scalar * [r20(2); -r20(1)]/norm(r20); v30 = v_scalar * [r30(2); -r30(1)]/norm(r30);
v30 = [0.93240737; 0.86473146]; v10 = -v30/2; v20 = -v30/2;
z0 = [r10; r20; r30; v10; v20; v30];

time_scale = 1;
tstart = 0; tend = 2.1; tspan = [tstart tend];

rhs = @(t, z) myrhs(z,t,p);

options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution = ode45(rhs, tspan, z0, options);

animate(solution, tspan, z0, time_scale);

%% 10 Time Units

tstart = 0; tend = 10; tspan = [tstart tend];

rhs = @(t, z) myrhs(z,t,p);

options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution = ode45(rhs, tspan, z0, options);

animate(solution, tspan, z0, time_scale);

%% Slightly Different Initial Conditions

time_scale = 10;
tstart = 0; tend = 100; tspan = [tstart tend];

z0 = z0 + (1e-3*ones(size(z0)));
rhs = @(t, z) myrhs(z,t,p);

options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution = ode45(rhs, tspan, z0, options);

animate(solution, tspan, z0, time_scale);

%% Very Different Initial Conditions
z0 = z0 + randn(size(z0));

rhs = @(t, z) myrhs(z,t,p);

options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution = ode45(rhs, tspan, z0, options);

animate(solution, tspan, z0, time_scale);