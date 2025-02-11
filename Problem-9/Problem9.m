% RO2102 Dynamics and Simulation %
% Assignment-3; Problem-9 %
% Tanay Srinivasa, 25 Jan 2025 %
% Due Date: 28 Jan 2025 %
% Time Spent on Problem: 2.5 Hours  %

clc;
clear all;
close all;

% Plotting options as defined in Homework Guidelines %
set(0,'DefaultAxesFontSize', 20);

% Parameters %
p.m = 1; p.g = 1; p.c = 1; time_scale = 2;

% Initial Conditions %
tstart = 0; tend = 10; tspan = [tstart, tend];
r0 = [0; 0]; v0_scalar = 1; theta0 = pi/4; 
v0 = [v0_scalar*cos(theta0); v0_scalar*sin(theta0)];
z0 = [r0; v0];

% Analytical solutions derived manually
[x_fun, y_fun] = analytical_sol(p,z0);

% Numerical Function %
rhs = @(t,z) myrhs(z, t, p);
options = odeset('AbsTol',1e-3, 'RelTol',1e-3, 'Events',@hit_ground);
solution = ode45(rhs,tspan,z0,options);

time = solution.x;

% Animation %
animation_ode45(solution, [time(1),time(end)], z0, time_scale);
animate_analytical_solution(x_fun, y_fun, [time(1), time(end)], p, time_scale);

% Error Comparison %
tspan_errors = [0 2];
compare_errors(x_fun, y_fun, rhs, tspan_errors, z0, p);

% Compare v0 %
tspan_v0 = [0; 500];
compare_v0(rhs, tspan_v0, theta0);

% Find Best Launch Angle %
% Comment: As v0 increases, best_theta tends to 0.
tstart = 0; tend = 10; tspan = [tstart, tend];
r0 = [0; 0]; v0_scalar = 100000;
theta = 0.1:0.001:pi/4;

best_theta = pi/4;
best_range = 0;

for i = 1:length(theta)
    v0 = [v0_scalar*cos(theta(i)); v0_scalar*sin(theta(i))] ;
    z0 = [r0; v0];
    rhs = @(t,z) myrhs(z, t, p);
    options = odeset('AbsTol',1e-3, 'RelTol',1e-3, 'Events',@hit_ground);
    solution = ode45(rhs,tspan,z0,options);

    z = solution.y;
    x = z(1,:);
    range = x(end);

    if range > best_range
        best_theta = theta(i);
        best_range = range;
    end
end

disp(rad2deg(best_theta));

function [value, isterminal, direction] = hit_ground(t, z)
    value = z(2);    
    isterminal = 1;
    direction = -1;
end