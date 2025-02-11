% RO2102 Dynamics and Simulation %
% Assignment-3; Problem-10 %
% Tanay Srinivasa, 25 Jan 2025 %
% Due Date: 28 Jan 2025 %
% Time Spent on Problem: 1.5 Hour  %

clc;
clear all;
close all;

% Plotting option as defined in Homework Guidelines %
set(0, 'DefaultAxesFontSize', 20);

% Initialising Parameters %
p.k = 5; p.l0 = 0; p.g = pi^2; p.m = 7; p.time_scale = 1;

% Initial Conditions %
tstart = 0; tend = 2*pi*sqrt(p.m/p.k) - 0.1; tspan = [tstart, tend];
r0 = [pi; -pi; exp(1)]; v0 = [1;2;-3]; z0 = [r0; v0];

% Function Definition %
rhs = @(t,z) myrhs(t,z,p);

% Solving using ODE45 %
options = odeset('AbsTol', 1e-10, 'RelTol', 1e-10);
solution = ode45(rhs,tspan,z0,options);

plot_trajectory(solution,tspan)
% animate(solution,tspan,z0, p.time_scale);

function zdot = myrhs(t,z,p)
    k = p.k; m = p.m; g = p.g; l0 = p.l0;

    r = z(1:3);
    v = z(4:6);

    khat = [0;0;1];
    rddot = ((-k*(norm(r)-l0)/(m*norm(r)))*r) - (g*khat);

    zdot(1) = v(1);
    zdot(2) = v(2);
    zdot(3) = v(3);
    zdot(4) = rddot(1);
    zdot(5) = rddot(2);
    zdot(6) = rddot(3);

    zdot = zdot';
end

function animate(solution, tspan, z0, time_scale)
    z_vals = solution.y;
    x_vals = z_vals(1,:);
    y_vals = z_vals(2,:);
    z_vals = z_vals(3,:);
    
    figure;
    shg;
    hold on;
    grid on;
    axis equal;
    view(3);
    
    % Set Limits for Plot %
    xlim([min(x_vals)-0.5,max(x_vals)+0.5]);
    ylim([min(y_vals)-0.5,max(y_vals)+0.5]);
    zlim([min(z_vals)-0.5,max(z_vals)+0.5]);

    % Set Axis Labels %
    xlabel('x-position (m)', 'FontSize', 20);
    ylabel('y-position (m)', 'FontSize', 20);
    zlabel('z-position (m)', 'FontSize', 20);
    title('Animated Trajectory of Mass', 'FontSize',20);

    % Initialising Mass %
    mass = plot3(z0(1), z0(2), z0(3), 'ro', 'MarkerSize',10, 'MarkerFaceColor','r');
    string = plot3([0,z0(1)],[0,z0(2)],[0,z0(3)],'LineWidth',1.5, 'Color','w');

    % Initialising Clock %
    total_time = tspan(2) - tspan(1);
    tstart = tic;

    while true
        elapsed_time = toc(tstart)*time_scale;

        if elapsed_time > total_time
            break;
        end

        z_current = deval(solution, elapsed_time);
        set(mass, 'XData', z_current(1), 'YData', z_current(2), 'ZData', z_current(3));
        set(string, 'XData', [0, z_current(1)], 'YData', [0, z_current(2)], 'ZData', [0, z_current(3)]);
        drawnow
    end

end

function plot_trajectory(solution, tspan)
    t = linspace(tspan(1),tspan(2),1e5);
    z_vals = deval(solution,t);
    r_vals = z_vals(1:3,:);

    view(3);
    plot3(r_vals(1,:),r_vals(2,:),r_vals(3,:),'LineWidth',1.5, 'Color','w');
    xlabel("x-position (m)", 'FontSize',20);
    ylabel("y-position (m)", 'FontSize',20);
    zlabel("z-position (m)", 'FontSize',20);
    axis equal;
    grid on;
    title("Trajectory of mass");
end

%% Comments for part (b) and part (c) %%

% Irrespective of the initial conditions and the parameters, at most, given
% a zero length spring in 3-D, the wildest moiton you can obtain is a
% elliptical motion, which for some special cases is limited to a line. The
% analytical reason for this is when solved analytically, the equations of
% motion unfold to be a simple harmonic oscillator in three dimensions.
% For non zero gravity, there is an additional particular solution which is
% also added to the equation of a harmonic oscillator.