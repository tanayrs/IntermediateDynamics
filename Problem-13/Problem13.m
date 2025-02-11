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
p.m = 1; p.ka = 1; p.kb = 1; p.la = 1; p.lb = 2; p.g = 10;
p.ca = 1; p.cb = 1; p.ra = [0; 0]; p.rb = [1; 0]; time_scale = 1;

% Solving Statics using solve %
% statics(p);

% Initial Conditions %
tstart = 0; tend = 10; tspan = [tstart, tend];
r0 = [0.45; -6.49]; v0 = [0; 0];
z0 = [r0; v0];

% Numerical Function %
rhs = @(t,z) myrhs(z, t, p);
options = odeset('AbsTol',1e-3, 'RelTol',1e-3);
solution = ode45(rhs,tspan,z0,options);

% Animation %
% animate(solution, tspan, z0, p, time_scale);

% Finding Equilibria using fsolve %
mystatics = @(z) sum_of_forces(z(1:2),[0;0],p);
options = optimoptions('fsolve', 'FunctionTolerance',1e-30, 'OptimalityTolerance',1e-8, 'MaxFunctionEvaluations',10000, 'MaxIterations',10000, 'Disp','off');
[root, fval, exitflag] = fsolve(mystatics,z0(1:2),options);
if exitflag < 1
    disp('Tanay says: FSOLVE is not happy. We want fval to be close to zeros.');
    fval
end

disp('The x and y equilibrium point is')
disp(root);