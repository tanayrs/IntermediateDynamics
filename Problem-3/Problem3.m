% RO2102 Dynamics and Simulation %
% Assignment-2; Problem-3 %
% Tanay Srinivasa, 19 Jan 2025 %
% Due Date: 24 Jan 2025 %
% Time Spent on Problem: 2 Hour 15 Min(19-Jan-2025 12:45 PM to 1:30 PM, 5:30 PM to 7:00 PM) %

%% Euler Method %%
clc;
clear all;
close all;

% Plotting option as defined in Homework Guidelines %
set(0, 'DefaultAxesFontSize', 20);

% Solve the ODE for the system %
p.k = 4; p.m = 1; p.g = 9.81;

% Initial Conditions %
tstart = 0; tend = 10; h = 1e-3;
r0 = [0;1]; v0 = [0; 0]; z0 = [r0; v0];

% Defining Function %
rhs = @(t, z) myrhs(t, z, p);

% Finding Solution using my_euler() function %
[t, sol] = my_euler(rhs, tstart, tend, h, z0);

r = sol(1:2, :); % Extract position components
v = sol(3:4, :); % Extract velocity components

% plot(tstart:h:tend,r(2,:))
% shg

animate_my_euler(sol,t)

%% ODE-45 %%
tspan = [tstart, tend];
options = odeset('AbsTol', 1e-3, 'RelTol', 1e-3);
solution = ode45(rhs, tspan, z0, options);

% Generate time points and evaluate solution %
t = linspace(0, tend, 1000)';
animate_ode45(solution,tspan)

%% Function Definition: myrhs() %%
% Function for the right-hand side of the ODE %
function zdot = myrhs(t, z, p)
    r = z(1:2);
    v = z(3:4);
    
    % Unpack parameters %
    k = p.k; m = p.m; g = p.g;

    j = [0;1];
    
    % Compute spring forces %
    Ftot = (-k*r) - (m*g*j);
    
    % Equations of motion %
    rdot = v;
    vdot = Ftot / m;
    
    zdot = [rdot; vdot];
end

%% Function Definition: my_euler() %%
function [t_array, sol] = my_euler(rhs, tstart, tend, h, z0)
    % Initialize time array and solution storage %
    t_array = tstart:h:tend;
    n_steps = length(t_array);
    sol = zeros(length(z0), n_steps);
    
    % Set initial conditions %
    z = z0;
    sol(:, 1) = z;
    
    % Time-stepping loop %
    for i = 2:n_steps
        zdot = rhs(t_array(i-1), z);
        z = z + (h * zdot); % Euler's update
        sol(:, i) = z;
    end
end

%% Function Definition: animate_my_euler %%
function animate_my_euler(z, t)
    % Inputs:
    %   z - State matrix where rows represent [x; y; vx; vy]
    %   t - Time vector
    
    % Extract position
    r = z(1:2, :); % Position [x; y]

    % Initialize figure
    figure;
    shg
    hold on;

    % Plot full trajectory as a dashed line
    trajectory = plot(NaN, NaN, 'k--', 'LineWidth', 1.5); 

    % Initialize mass position
    h_mass = plot(NaN, NaN, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

    % Set axis labels and title
    xlabel('x-position', 'FontSize', 20);
    ylabel('y-position', 'FontSize', 20);
    title('Animated Trajectory of the Mass (my Euler)', 'FontSize', 20);

    % Set dynamic axis limits
    x_min = min(r(1, :)) - 0.5;
    x_max = max(r(1, :)) + 0.5;
    y_min = min(r(2, :)) - 0.5;
    y_max = max(r(2, :)) + 0.5;

    xlim([x_min, x_max]);
    ylim([y_min, y_max]);
    axis equal;
    grid on;

    % Animation loop using tic-toc
    n_frames = length(t);
    t_start = tic; % Start timer
    total_time = t(end); % Total animation time in seconds

    while true
        % Elapsed time since animation started
        elapsed_time = toc(t_start);

        % Check if animation is complete
        if elapsed_time >= total_time
            break;
        end

        % Determine the current frame based on elapsed time
        [~, frame_idx] = min(abs(t - elapsed_time));

        % Update trajectory
        set(trajectory, 'XData', r(1, 1:frame_idx), 'YData', r(2, 1:frame_idx));

        % Update mass position
        set(h_mass, 'XData', r(1, frame_idx), 'YData', r(2, frame_idx));
        drawnow
    end

    hold off;
end

%% Function Definition: animate_ode45 %%
function animate_ode45(solution, tspan)
    % Inputs:
    %   solution - ODE45 solution structure
    %   tspan - Time range [tstart, tend]

    % Extract the solution time and states for plotting
    t_vals = solution.x; % Time values
    r_vals = solution.y; % State values (positions)

    % Initialize figure
    figure;
    shg;
    hold on;
    grid on;
    axis equal;

    % Set dynamic axis limits based on the trajectory
    x_min = min(r_vals(1, :)) - 0.5;
    x_max = max(r_vals(1, :)) + 0.5;
    y_min = min(r_vals(2, :)) - 0.5;
    y_max = max(r_vals(2, :)) + 0.5;

    xlim([x_min, x_max]);
    ylim([y_min, y_max]);

    % Set axis labels and title
    xlabel('x-position', 'FontSize', 20);
    ylabel('y-position', 'FontSize', 20);
    title('Animated Trajectory of the Mass (ODE45)', 'FontSize', 20);

    % Initialize plot objects
    trajectory = plot(NaN, NaN, 'k--', 'LineWidth', 1.5); 
    mass = plot(NaN, NaN, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % Mass

    % Total animation duration
    total_time = tspan(2) - tspan(1);

    % Animation loop using tic-toc
    t_start = tic; % Start timer
    while true
        % Elapsed time since animation started
        elapsed_time = toc(t_start);

        % Check if animation is complete
        if elapsed_time >= total_time
            break;
        end

        % Interpolate the solution at the current time step
        r_current = deval(solution, elapsed_time);

        % Find the closest time indices for trajectory updating
        idx = find(t_vals >= elapsed_time, 1);

        % Interpolate the trajectory points between the previous and current position
        if idx > 1
            r_prev = deval(solution, t_vals(idx - 1));
            x_vals = linspace(r_prev(1), r_current(1), 10); % Interpolation for x
            y_vals = linspace(r_prev(2), r_current(2), 10); % Interpolation for y

            % Update trajectory by adding interpolated points
            set(trajectory, 'XData', [get(trajectory, 'XData'), x_vals], 'YData', [get(trajectory, 'YData'), y_vals]);
        else
            % If it's the first point, just set the trajectory to the initial point
            set(trajectory, 'XData', r_current(1), 'YData', r_current(2));
        end

        % Update mass position
        set(mass, 'XData', r_current(1), 'YData', r_current(2));

        % Pause to create animation effect
        drawnow
    end

    hold off;
end
