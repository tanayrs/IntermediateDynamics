% RO2102 Dynamics and Simulation %
% Assignment-3; Problem-8 %
% Tanay Srinivasa, 25 Jan 2025 %
% Due Date: 28 Jan 2025 %
% Time Spent on Problem: 1.5 Hour  %

clc;
clear all;
close all;

% Plotting option as defined in Homework Guidelines %
set(0, 'DefaultAxesFontSize', 20);

% Initial Conditions %
time_scale = 5;
tstart = 0; tend = 10; tspan = [tstart, tend];
r0 = 1; theta0 = pi/4; rdot0 = 8; thetadot0 = 3;
r0_vec = r0 * [cos(theta0); sin(theta0)];
z0 = [r0; theta0; rdot0; thetadot0];

% Function Definition %
rhs = @(t, z) myrhs(z, t);

% Solving using ODE45 %
options = odeset('AbsTol', 1e-3, 'RelTol', 1e-3);
solution = ode15s(rhs, tspan, z0, options);

% Animate the motion %
animate(solution, tspan, z0, time_scale);

% Check for "straightness" %
t = solution.x;
z = solution.y;
r = z(1:3,:);
r_cartesian = [
        z(1,:) .* cos(z(2,:));
        z(1,:) .* sin(z(2,:));
    ];

figure;
hold on;
grid on; axis equal;
xlabel("x-error (m)", 'FontSize',20); ylabel("y-error (m)",'FontSize',20);

for i = 1:length(t)
    % Get current rdot and thetadot from solution
    rdot = z(3,i);
    thetadot = z(4,i);
    theta = z(2,i);
    
    % Calculate current velocity vector in Cartesian coordinates
    v = [cos(theta) -sin(theta); sin(theta) cos(theta)] * [rdot; z(1,i)*thetadot];
    
    % Calculate expected position for straight-line motion
    expected_pos = r0_vec + v*t(i);
    
    % Calculate actual position
    actual_pos = r_cartesian(1:2,i);
    
    % Calculate error
    error = expected_pos - actual_pos;
    
    % Plot error
    plot(error(1), error(2), 'ro', 'MarkerFaceColor', 'r');
end
hold off;

% EoM Definition %
function zdot = myrhs(z, t)
    r = z(1);
    theta = z(2);
    rdot = z(3);
    thetadot = z(4);
    
    zdot(1) = rdot;
    zdot(2) = thetadot;
    zdot(3) = r*(thetadot^2);
    zdot(4) = -(2*rdot*thetadot)/r;

    zdot = zdot';
end

% Animation Function %
function retval = animate(solution, tspan, z0, time_scale)
    z_vals = deval(solution, linspace(tspan(1), tspan(2), 500));

    % Conversion to Cartesian coordinates %
    r_vals = [
        z_vals(1,:).* cos(z_vals(2,:));
        z_vals(1,:) .* sin(z_vals(2,:))
    ];


    % Figure Setup %
    figure;
    hold on; grid on; axis equal;
    
    xlim([min(r_vals(1,:))-0.5, max(r_vals(1,:))+0.5]);
    ylim([min(r_vals(2,:))-0.5, max(r_vals(2,:))+0.5]);

    xlabel("x-position (m)", "FontSize",20);
    ylabel("y-position (m)", "FontSize",20);

    % Initialize Mass %
    er = [cos(z0(2)), sin(z0(2))];
    r0 = z0(1)*er;
    
    mass = plot(r0(1), r0(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    
    % Animation Loop %
    total_time = tspan(2) - tspan(1);
    t_start = tic();
    
    while true
        elapsed_time = toc(t_start)*time_scale;

        if elapsed_time > total_time
            break;
        end

        z_current = deval(solution, elapsed_time);
        
        r = z_current(1);
        theta = z_current(2);

        er = [cos(theta); sin(theta)];
        r = r*er;


        set(mass, 'XData', r(1), 'YData', r(2));
        drawnow;
    end
    
    hold off;
end
