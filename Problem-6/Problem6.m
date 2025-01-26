% RO2102 Dynamics and Simulation %
% Assignment-2; Problem-6 %
% Tanay Srinivasa, 25 Jan 2025 %
% Due Date: 28 Jan 2025 %
% Time Spent on Problem: 45 Min  %

clc;
clear all;
close all;

% Plotting option as defined in Homework Guidelines %
set(0, 'DefaultAxesFontSize', 20);

% Initialising Parameters %
p.k = 1; p.l0 = 1; p.g = 10; p.m = 1; p.time_scale = 20;

% Initial Conditions %
tstart = 0; tend = 100; tspan = [tstart, tend];
r0 = [1; 1.5]; v0 = [0;0]; z0 = [r0; v0];

% Function Definition %
rhs = @(t,z) myrhs(t,z,p);

% Solving using ODE45 %
options = odeset('AbsTol', 1e-3, 'RelTol', 1e-3);
solution = ode45(rhs,tspan,z0,options);

plot_trajectory(solution,tspan)
animate(solution,tspan,z0, p.time_scale);

function zdot = myrhs(t,z,p)
    k = p.k; m = p.m; g = p.g; l0 = p.l0;

    r = z(1:2);
    v = z(3:4);

    j = [0;1];
    rddot = (-k*(norm(r)-l0)/(m*norm(r)))*r - g*j;

    zdot(1) = z(3);
    zdot(2) = z(4);
    zdot(3) = rddot(1);
    zdot(4) = rddot(2);

    zdot = zdot';
end

function animate(solution, tspan, z0, time_scale)
    z_vals = solution.y;
    x_vals = z_vals(1,:);
    y_vals = z_vals(2,:);
    
    figure;
    shg;
    hold on;
    grid on;
    axis equal;
    
    % Set Limits for Plot %
    xlim([min(x_vals)-0.5,max(x_vals)+0.5]);
    ylim([min(y_vals)-0.5,max(y_vals)+0.5]);

    % Set Axis Labels %
    xlabel('x-position', 'FontSize', 20);
    ylabel('y-position', 'FontSize', 20);
    title('Animated Trajectory of Mass', 'FontSize',20);

    % Initialising Mass %
    mass = plot(z0(1), z0(2), 'ro', 'MarkerSize',10, 'MarkerFaceColor','r');
    string = plot([0,z0(1)],[0,z0(2)],'LineWidth',1.5, 'Color','w');

    % Initialising Clock %
    total_time = tspan(2) - tspan(1);
    tstart = tic;

    while true
        elapsed_time = toc(tstart)*time_scale;

        if elapsed_time > total_time
            break;
        end

        z_current = deval(solution, elapsed_time);
        set(mass, 'XData', z_current(1), 'YData', z_current(2));
        set(string, 'XData', [0, z_current(1)], 'YData', [0, z_current(2)]);
        drawnow
    end

end

function plot_trajectory(solution, tspan)
    t = linspace(tspan(1),tspan(2),1000);
    z_vals = deval(solution,t);
    r_vals = z_vals(1:2,:);

    plot(r_vals(1,:),r_vals(2,:),'LineWidth',1.5, 'Color','w');
    xlabel("x-position (m)", 'FontSize',20);
    ylabel("y-position (m)", 'FontSize',20);
    title("Trajectory of mass");
end
