%% RO2102: Dynamics and Simulation
% Assignment 5; Problem-17
% By: Tanay Srinivasa, Time Spent: 1 Hour 40 Min

%% Comments: 
% The overall movement of the masses looks an awful lot like the motion of
% juggling 3 balls. With the modified intial conditions in part 3, its
% almost like a "mediocre" juggler. They are unable to keep the masses
% following the trajectory constant for all time, there is a small drift
% over time in the motion of masses.

% For 10 time steps or greater, how sensitive is the system to z0? Its a
% non-linear system, so given any z from the solution as z0, will it 
% continue to follow the same trajectory, just delayed or advanced in time?

% Comparing a small variation and large variation, the only difference in
% the code is a uniform increase in all parameters by some factor, as
% compared to in a large variation a standard normal random variable is
% introduced, which now makes the system behave completely differently.
% When this random vector is scaled by 1e-3, it changes the pattern, but
% this pattern looks somewhat regular, for 1e-2 it starts to look
% chaotic. For 1e-1 and higher it one mass shoots out to infinity.

%%
clc;
clear all;
close all;

%% Initialise Parameters
p.G = 1; p.m = 1;

r10 = [-0.9700046; 0.24308753]; r20 = -r10; r30 = [0; 0];
v30 = [0.93240737; 0.86473146]; v10 = -v30/2; v20 = -v30/2;
z0 = [r10; r20; r30; v10; v20; v30];


%% 2.1 Time Units
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
time_scale = 1;
tstart = 0; tend = 10; tspan = [tstart tend];

z0 = z0 + (1e-3*ones(size(z0)));
v10 = z0(7:8); v20 = z0(9:10); v30 = z0(11:12);

v0_sum = -(v10 + v20 + v30)/3;

v10 = v10 + v0_sum;
v20 = v20 + v0_sum;
v30 = v30 + v0_sum;
z0(7:8) = v10 ; z0(9:10) = v20; z0(11:12) = v30;

rhs = @(t, z) myrhs(z,t,p);

options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution = ode45(rhs, tspan, z0, options);

animate(solution, tspan, z0, time_scale);

%% Very Different Initial Conditions

rng(42);

time_scale = 10;
tstart = 0; tend = 100; tspan = [tstart tend];

z0 = z0 + (1e-2*randn(size(z0)));
v10 = z0(7:8); v20 = z0(9:10); v30 = z0(11:12);

v0_sum = -(v10 + v20 + v30)/3;

v10 = v10 + v0_sum;
v20 = v20 + v0_sum;
v30 = v30 + v0_sum;
z0(7:8) = v10 ; z0(9:10) = v20; z0(11:12) = v30;

rhs = @(t, z) myrhs(z,t,p);

options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution = ode45(rhs, tspan, z0, options);

animate(solution, tspan, z0, time_scale);