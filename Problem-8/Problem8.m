% RO2102 Dynamics and Simulation %
% Assignment-2; Problem-8 %
% Tanay Srinivasa, 25 Jan 2025 %
% Due Date: 28 Jan 2025 %
% Time Spent on Problem: 1.5 Hour  %

clc;
clear all;
close all;

% Plotting option as defined in Homework Guidelines %
set(0, 'DefaultAxesFontSize', 20);

% Initial Conditions %
tstart = 0; tend = 10; tspan = [tstart, tend];
r0 = 1; theta0 = pi/4; phi0 = pi/6; v0 = 8;
z0 = [r0; theta0; phi0; v0;];

% Function Definition %
rhs = @(t, z) myrhs(z, t);

% Solving using ODE45 %
options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
solution = ode45(rhs, tspan, z0, options);

% Animate the motion
animate(solution, tspan, z0);

% EoM Definition %
function zdot = myrhs(z, t)
    r = z(1);
    theta = z(2);
    phi = z(3);
    v = z(4);
    
    zdot(1) = v;
    zdot(2) = 0;
    zdot(3) = 0;
    zdot(4) = 0;

    zdot = zdot';
end

% Animation Function %
function retval = animate(solution, tspan, z0)
    z_vals = deval(solution, linspace(tspan(1), tspan(2), 500));

    % Conversion to Cartesian coordinates %
    r_vals = [
        z_vals(1,:) .* sin(z_vals(2,:)) .* cos(z_vals(3,:));
        z_vals(1,:) .* sin(z_vals(2,:)) .* sin(z_vals(3,:));
        z_vals(1,:) .* cos(z_vals(2,:))
    ];

    % Figure Setup %
    figure;
    hold on; grid on; axis equal; view(3);
    
    xlim([min(r_vals(1,:))-0.5, max(r_vals(1,:))+0.5]);
    ylim([min(r_vals(2,:))-0.5, max(r_vals(2,:))+0.5]);
    zlim([min(r_vals(3,:))-0.5, max(r_vals(3,:))+0.5]);

    xlabel("x-position (m)", "FontSize",20);
    ylabel("y-position (m)", "FontSize",20);
    zlabel("z-position (m)", "FontSize",20);

    % Initialize Mass %
    r0_cartesian = [
        z0(1) * sin(z0(2)) * cos(z0(3));
        z0(1) * sin(z0(2)) * sin(z0(3));
        z0(1) * cos(z0(2))
    ];

    mass = plot3(r0_cartesian(1), r0_cartesian(2), r0_cartesian(3), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    
    % Animation Loop %
    total_time = tspan(2) - tspan(1);
    t_start = tic();
    
    while true
        elapsed_time = toc(t_start);

        if elapsed_time > total_time
            break;
        end

        z_current = deval(solution, elapsed_time);
        r = [
            z_current(1) * sin(z_current(2)) * cos(z_current(3));
            z_current(1) * sin(z_current(2)) * sin(z_current(3));
            z_current(1) * cos(z_current(2))
        ];

        set(mass, 'XData', r(1), 'YData', r(2), 'ZData', r(3));
        drawnow;
    end
    
    hold off;
end
