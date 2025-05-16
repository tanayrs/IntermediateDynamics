%% RO2102: Dynamics and Simulation
% Assignment 8; Problem-43 b
% By: Tanay Srinivasa, Time Spent: 3 Hours

clc;
clear all;
close all;

%% System Parameters %%
p.Ig1 = 1; p.Ig2 = 1; p.Ig3 = 1; p.d1 = 0.5; p.d2 = 0.5; p.d3 = 0.5;
p.g = 10; p.l1 = 1; p.l2 = 1; p.l3 = 2; p.m1 = 10; p.m2 = 10; p.m3 = 10;

d1 = p.d1; d2 = p.d2; d3 = p.d3; l1 = p.l1; l2 = p.l2; l3 = p.l3;

theta1 = pi; theta2 = pi/2; theta3 = 0;
w1 = 0.01; w2 = 0; w3 = 0;

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
vg3 = -w3*(l3-d3)*etheta3;

z0 = [theta1; theta2; theta3; rg1(1); rg1(2); rg2(1); rg2(2); rg3(1); rg3(2); ...
    w1; w2; w3; vg1(1); vg1(2); vg2(1); vg2(2); vg3(1); vg3(2)];

tend = 100 ; tspan = [0 tend];

% time_scale = tend/10;
time_scale = 0.5;

%% DAE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initial Conditions for DAE %%

%% Call RHS %%
rhs_dae = @(t,z) myrhs_dae(z,t,p);

%% Solve ODE %%
options = odeset('AbsTol',1e-6,'RelTol',1e-6);
solution_dae = ode45(rhs_dae,tspan,z0,options);

%% Animate %%
animate_dae(solution_dae, tspan, z0, p, time_scale);

%% Energy Check %%
[E1, E2] = energy_check(solution_dae,p,"DAE")