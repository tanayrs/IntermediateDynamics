%% RO2102: Dynamics and Simulation
% Final Project; Problem-43-a
% By: Tanay Srinivasa, Time Spent: 4 Hours

clc;
clear all;
close all;

%% Newton-Euler Minimal Co-ordinates %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% System Parameters %%
p.Ig1 = 1; p.Ig2 = 1; p.Ig3 = 1; p.d1 = 0.5; p.d2 = 0.5; p.d3 = 0.5;
p.g = 0; p.l1 = 1; p.l2 = 1; p.l3 = 1; p.m1 = 10; p.m2 = 10; p.m3 = 10;

theta1 = 0; theta2 = 0; theta3 = pi/2;
w1 = 1; w2 = 1; w3 = 1;

z0 = [theta1; theta2; theta3; w1; w2; w3];
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
[E1, E2] = energy_check(solution,p,"NE")

disp("NE Energy Difference")
E1 - E2

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
[E1, E2] = energy_check(solution_le,p,"LE");
disp("LE Energy Difference")
E1 - E2

%% DAE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initial Conditions for DAE %%
d1 = p.d1; d2 = p.d2; d3 = p.d3; l1 = p.l1; l2 = p.l2;

i = [1; 0; 0];
j = [0; 1; 0];
k = [0; 0; 1];

er1 = (sin(theta1)*i) - (cos(theta1)*j);
er2 = (sin(theta2)*i) - (cos(theta2)*j);
er3 = (sin(theta3)*i) - (cos(theta3)*j);

etheta1 = cross(k,er1);
etheta2 = cross(k,er2);
etheta3 = cross(k,er3);

rg1 = d1*er1;
rg2 = d2*er2 + l1*er1;
rg3 = d3*er3 + l2*er2 + l1*er1;

vg1 = w1*d1*etheta1;
vg2 = w1*l1*etheta1 + w2*d2*etheta2;
vg3 = w1*l1*etheta1 + w2*l2*etheta2 + w3*d3*etheta3;

z0 = [theta1; theta2; theta3; rg1(1); rg1(2); rg2(1); rg2(2); rg3(1); rg3(2); ...
    w1; w2; w3; vg1(1); vg1(2); vg2(1); vg2(2); vg3(1); vg3(2)];
%% Call RHS %%
rhs_dae = @(t,z) myrhs_dae(z,t,p);

%% Solve ODE %%
options = odeset('AbsTol',1e-6,'RelTol',1e-6);
solution_dae = ode45(rhs_dae,tspan,z0,options);

%% Animate %%
animate_dae(solution_dae, tspan, z0, p, time_scale);

%% Energy Check %%
[E1, E2] = energy_check(solution_dae,p,"DAE")
disp("DAE Energy Difference")
E1 - E2

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