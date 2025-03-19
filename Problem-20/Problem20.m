clc;
clear all;
close all;

%% Define Parameters %%
p.k = 1; p.l0 = 3; p.m1 = 1; p.m2 = 1; p.F0 = 1;
r0 = [0; p.l0]; v0 = [0; 0]; z0 = [r0; v0];

tend = 10; tspan = [0, tend];

%% Define RHS %%
rhs = @(t,z) myrhs(z,t,p);

%% ODE Set-Up %%
options = odeset('RelTol',1e-3, 'AbsTol', 1e-3);
solution = ode45(rhs,tspan,z0, options);

%% Animate Trajectory %%
animate(solution, tspan, z0, 1)

%% Check for Large K %%
p.k = 1e4;

tend = 1e2; tspan = [0; tend];

solution = ode45(rhs, tspan, z0, options);

%% Plot Trajectory %%
t = linspace(solution.x(1),solution.x(end),1000);
zvals = deval(solution,t);

x1 = zvals(1,:);
x2 = zvals(2,:);
xg = (p.m1*x1 + p.m2*x2)/(p.m1+p.m2);

figure;
subplot(2,1,1);
plot(t, x1, 'DisplayName',"X1")
hold on;
plot(t, x2, 'DisplayName',"X2")
xlabel("t (s)")
ylabel("x (m)")
grid on;

subplot(2,1,2);
plot(t, x1-xg, 'DisplayName', 'X1 - XG');
hold on;
plot(t, x2-xg, 'DisplayName', 'X2 - XG');
xlabel("t(s)");
ylabel("x-error (m)");
grid on;

hold off;