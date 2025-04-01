%% RO2102: Dynamics and Simulation
% Assignment 9; Problem-29
% By: Tanay Srinivasa, Time Spent: 2 Hours
clc;
clear all;
close all;

%% Initialise Parameters %%
p.g = 10; p.omega = 68.5; p.d = 1; p.m = 1; p.Ig = 1; p.r = 0.1;

z0 = [0.1; 0];
tend = 10; tspan = [0, 10];

%% Get RHS %%
rhs = @(t,z) myrhs(z, t, p);

%% Solve ODE %%
options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution = ode45(rhs, tspan, z0, options);

%% Animate %%
% animate(solution, z0, tspan, p, 0);

%% Using DAE Approach %%
z0 = [0; 0; 0.1; 0; 0; 0];
rhs_dae = @(t,z) myrhs_dae(z, t, p);

options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution_dae = ode45(rhs_dae, tspan, z0, options);

% figure;
% animate(solution_dae, z0, tspan, p, 1);

%% Plot Difference in Solutions %%

t = linspace(solution.x(1), solution.x(end), 1000);
z_vals_minimal = deval(solution, t);
z_vals_dae = deval(solution_dae, t);

theta_minimal = z_vals_minimal(1,:);
theta_dae = z_vals_dae(3,:);

difference = theta_minimal - theta_dae;

figure;
subplot(2,1,1);

plot(t,theta_dae, 'DisplayName',"DAE Approach");
hold on;

plot(t,theta_minimal, 'DisplayName',"N-E Minimal Coordinates");

xlabel('Time (s)');
ylabel('\theta (rad)');
grid on;
legend();
hold off;

subplot(2,1,2);
plot(t,difference);
xlabel('Time (s)');
ylabel('Difference (rad)');
grid on;