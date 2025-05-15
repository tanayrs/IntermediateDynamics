%% RO2102: Dynamics and Simulation
% Final Project; Problem-53
% By: Tanay Srinivasa, Time Spent: 3 Hours

clc;
clear all;
close all;

% p.I1 = 10; p.I2 = 1; p.I3 = 1; % Random Initial COnditions
m = 100; r = 1;
p.I1 = (1/4)*m*(r^2); p.I2 = (1/4)*m*(r^2); p.I3 = (1/2)*m*(r^2);
time_scale = 1;

z0 = [0;0;0;0;5;0;
    1;0;0;
    0;1;0;
    0;0;1];

tend = 100; tspan = [0 tend];

rhs = @(t,z) myrhs(z,t,p);

options = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);
solution = ode45(rhs,tspan,z0,options);

t = linspace(tspan(1), tspan(2), 1000);

z_vals = deval(solution,t);

animate(solution,z0,tspan,time_scale);
