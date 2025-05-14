%% RO2102: Dynamics and Simulation
% Final Project; Problem-39
% By: Tanay Srinivasa, Time Spent: 3 Hours

clc;
clear all;
close all;

% Parameters %
p.d1 = 1; p.d2 = 1; p.phi1 = deg2rad(70+90); p.phi2 = deg2rad(20); p.m = 1; p.Ig = 1;

% Initial Conditions %
z0 = [0;0;0;1;0;1/(2*tan(70))];

tend = 100; tspan = [0, tend];

%% DAE %%
rhs = @(t,z) myrhs_dae(z,t,p);

options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution_dae = ode45(rhs,tspan,z0,options);

t = linspace(tspan(1),tspan(2),1000);
z_vals_dae = deval(solution_dae,t);

x_dae = z_vals_dae(1,:);
y_dae = z_vals_dae(2,:);
theta_dae = z_vals_dae(3,:);

%% LE %%
rhs = @(t,z) myrhs_le(z,t,p);

options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution_le = ode45(rhs,tspan,z0,options);

t = linspace(tspan(1),tspan(2),1000);
z_vals_le = deval(solution_le,t);

x_le = z_vals_le(1,:);
y_le = z_vals_le(2,:);
theta_le = z_vals_le(3,:);

subplot(3,1,1)
plot(t,x_dae,'DisplayName',"DAE");
hold on
plot(t,x_le,'DisplayName',"LE");
ylabel('x(m)');
xlabel('t(s)');
legend();

subplot(3,1,2)
plot(t,y_dae,'DisplayName',"DAE");
hold on
plot(t,y_le,'DisplayName',"LE");
ylabel('y(m)');
xlabel('t(s)');
legend();

subplot(3,1,3)
plot(t,theta_dae,'DisplayName',"DAE");
hold on
plot(t,theta_le,'DisplayName',"LE");
ylabel('\theta(rad)');
xlabel('t(s)');
legend();

figure;
plot(x_dae,y_dae,'DisplayName',"DAE");
hold on;
plot(x_le,y_le,'DisplayName',"LE");
xlabel('x(m)');
ylabel('y(m)');
title("Trajectory")
axis equal;
legend();
