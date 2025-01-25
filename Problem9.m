% RO2102 Dynamics and Simulation %
% Assignment-2; Problem-8 %
% Tanay Srinivasa, 25 Jan 2025 %
% Due Date: 28 Jan 2025 %
% Time Spent on Problem: 1.5 Hour  %

clc;
clear all;
close all;

% Plotting options as defined in Homework Guidelines %
set(0,'DefaultAxesFontSize', 20);

% Parameters %
p.m = 1; p.g = 10; p.c = 1; time_scale = 1;

% Initial Conditions %
tstart = 0; tend = 10; tspan = [tstart, tend];
r0 = [0; 0]; v0_scalar = 100; theta0 = pi/4; v0 = [v0_scalar*cos(theta0); v0_scalar*sin(theta0)];
z0 = [r0; v0];

% Defining Function %
rhs = @(t,z) myrhs(z,t,p);
options = odeset('AbsTol', 1e-3, 'RelTol', 1e-3);
solution = ode45(rhs,tspan,z0,options);

animation(solution, tspan, z0, time_scale);

function zdot = myrhs(z,t,p)
    m = p.m; c = p.c; g = p.g;

    r = z(1:2);
    v = z(3:4);

    j = [0;1];
    Ftot = (-c*v) - (m*g*j);
    rddot = Ftot/m;

    zdot(1) = v(1);
    zdot(2) = v(2);
    zdot(3) = rddot(1);
    zdot(4) = rddot(2);

    zdot = zdot';
end

function retval = animation(solution, tspan, z0, time_scale)
    % Unpacking values to calculate limits %
    z_vals = deval(solution, linspace(tspan(1), tspan(2), 500));
    r_vals = z_vals(1:2,:);

    % Figure Setup %
    figure; hold on;
    grid on; axis equal;

    xlim([min(r_vals(1,:))-0.5,max(r_vals(1,:))+0.5]);
    ylim([min(r_vals(2,:))-0.5,max(r_vals(2,:))+0.5]);

    xlabel("x-position (m)", 'FontSize', 20);
    ylabel("y-position (m)", 'FontSize', 20);

    cannon = plot(z0(1),z0(2),'ro','MarkerSize',10,'MarkerFaceColor','r');

    total_time = tspan(2) - tspan(1);
    t_start = tic();

    while true
        elapsed_time = toc(t_start)*time_scale;

        if elapsed_time > total_time
            break;
        end

        z_current = deval(solution, elapsed_time);
        set(cannon,'XData', z_current(1), 'YData', z_current(2));

        drawnow;
    end

end