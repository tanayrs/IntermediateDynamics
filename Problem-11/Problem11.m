% RO2102 Dynamics and Simulation %
% Assignment-4; Problem-11 %
% Tanay Srinivasa, 9 Feb 2025 %
% Due Date: 11 Feb 2025 %
% Time Spent on Problem: 1 Hour  %

clc;
clear all;
close all;

set(0, 'DefaultAxesFontSize', 20);

% Parameters
p.k = 100; p.n = imag(pi/10); p.m = 7;

% Initial Conditions
r0 = [1; 0]; v0 = [0.1; -0.1]; z0 = [r0; v0];

tstart = 0; tend = 100;
tspan = [tstart, tend];

% Define ODE system
rhs = @(t,z) myrhs(t,z,p);

% Solve using ODE45
options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution = ode45(rhs, tspan, z0, options);

% Plot and animate
plot_trajectory(solution, tspan);

% Function defining the equations of motion
function zdot = myrhs(t, z, p)
    n = p.n; m = p.m; k = p.k;

    r = z(1:2);
    v = z(3:4);
    
    r_norm = norm(r);
    v_norm = norm(v);
    
    F = -k * exp(-imag(v_norm)*t) * (r / r_norm);
    
    rddot = F / m;
    
    zdot = [v; rddot];
end

% Function to plot trajectory
function plot_trajectory(solution, tspan)
    t = linspace(tspan(1), tspan(2), 1000);
    z_vals = deval(solution, t);
    r_vals = z_vals(1:2,:);
    
    figure;
    plot(r_vals(1,:), r_vals(2,:), 'LineWidth', 1.5);
    xlabel("x-position (m)", 'FontSize', 20);
    ylabel("y-position (m)", 'FontSize', 20);
    axis equal;
    grid on;
    title("Trajectory of mass");
end