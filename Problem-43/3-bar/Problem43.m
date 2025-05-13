%% RO2102: Dynamics and Simulation
% Assignment 8; Problem-30
% By: Tanay Srinivasa, Time Spent: 2 Hours

clc;
clear all;
close all;

%% Newton-Euler Minimal Co-ordinates %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% System Parameters %%
p.Ig1 = 1; p.Ig2 = 1; p.Ig3 = 1; p.d1 = 0.5; p.d2 = 0.5; p.d3 = 0.5;
p.g = 10; p.l1 = 1; p.l2 = 1; p.l3 = 1; p.m1 = 10; p.m2 = 10; p.m3 = 10;

z0 = [pi/2; pi/4; pi/5; 0; 0; 0];
tend = 10 ; tspan = [0 tend];

time_scale = tend/10;

%% Call RHS %%
rhs = @(t,z) myrhs(z,t,p);

%% Solve ODE %%
options = odeset('AbsTol',1e-6,'RelTol',1e-6);
solution = ode45(rhs,tspan,z0,options);

%% Animate %%
% animate(solution, tspan, z0, p, time_scale);

%% Energy Check %%
[E1, E2] = energy_check(solution,p)

%% Lagrange Equations %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Call RHS %%
rhs_le = @(t,z) myrhs_le(z,t,p);

%% Solve ODE %%
options = odeset('AbsTol',1e-6,'RelTol',1e-6);
solution_le = ode45(rhs_le,tspan,z0,options);

%% Animate %%
% animate(solution_le, tspan, z0, p, time_scale);

%% Energy Check %%
[E1, E2] = energy_check(solution_le,p)

%% DAE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initial Conditions for DAE %%
z0 = [pi/2; pi/4; pi/5; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
%% Call RHS %%
rhs_dae = @(t,z) myrhs_dae(z,t,p);

%% Solve ODE %%
options = odeset('AbsTol',1e-6,'RelTol',1e-6);
solution_dae = ode45(rhs_dae,tspan,z0,options);

%% Animate %%
animate(solution_dae, tspan, z0, p, time_scale);

%% Energy Check %%
[E1, E2] = energy_check(solution_dae,p)



%% Angle Check %%
t_NE = solution.x;
z_vals_NE = solution.y;

t_DAE = solution_dae.x;
z_vals_DAE = solution_dae.y;

t_LE = solution_le.x;
z_vals_LE = solution_le.y;

figure;
subplot(3,1,1);
plot(t_NE, z_vals_NE(1,:),'DisplayName',"NE");
hold on;
plot(t_DAE, z_vals_DAE(1,:),'DisplayName',"DAE");
plot(t_LE, z_vals_LE(1,:),'DisplayName',"LE");
legend();
xlabel("Time (s)");
ylabel("\theta_1 (rad)");
hold off;

subplot(3,1,2);
plot(t_NE, z_vals_NE(2,:),'DisplayName',"NE");
hold on;
plot(t_DAE, z_vals_DAE(2,:),'DisplayName',"DAE");
plot(t_LE, z_vals_LE(2,:),'DisplayName',"LE");
legend();
xlabel("Time (s)");
ylabel("\theta_2 (rad)");
hold off;

subplot(3,1,3);
plot(t_NE, z_vals_NE(3,:),'DisplayName',"NE");
hold on;
plot(t_DAE, z_vals_DAE(3,:),'DisplayName',"DAE");
plot(t_LE, z_vals_LE(3,:),'DisplayName',"LE");
legend();
xlabel("Time (s)");
ylabel("\theta_3 (rad)");
hold off;