% RO2102 Dynamics and Simulation %
% Assignment-1; Question-1 %
% Tanay Srinivasa, 15 Jan 2025 %
% Time Spend on Problem: 2 Hours (15-Jan-25: 10:00 AM to 10:40 AM, 2:00 PM to 3:10 PM) %

% Code Structure taken from Ruina Cornell Lec-3, ChatGPT was used to help with syntax for animation %

% Plotting option as defined in Homework Guidelines %
set(0,'DefaultAxesFontSize', 20)

% Defining Paramters of System %
p.k1 = 10; p.k2 = 20; p.l01 = 1; p.l02 = sqrt(2);
p.m = 5; p.F = [5;1]; p.r_b_from_a = [2;0]; p.g = 10;

% Defining time span and initial conditions %
tend = 10; tspan = [0, tend];
r0 = [1; -2]; v0 = [0; 0]; z0 = [r0; v0];

rhs = @(t, z) myrhs(t, z, p);
options = odeset('AbsTol', 1e-3, 'RelTol', 1e-3);
solution = ode45(rhs, tspan, z0, options);

% Generate time points and evaluate solution %
t = linspace(0, tend, 200)';
z = deval(solution, t);
x = z(1, :); y = z(2, :);

% Setup for animation %
figure;
hold on;
grid on;
axis equal;

% Points A and B %
A = [0, 0];
B = p.r_b_from_a;

% Determine dynamic limits for axes %
x_min = min([x, A(1), B(1)]) - 0.5;
x_max = max([x, A(1), B(1)]) + 0.5;

y_min = min([y, A(2), B(2)]) - 0.5;
y_max = max([y, A(2), B(2)]) + 0.5;

% Set the axis limits %
xlim([x_min, x_max]);
ylim([y_min, y_max]);

% Set the axis labels %
xlabel("x (m)",'FontSize',20);
ylabel("y (m)",'FontSize',20);
title("Animation of Dynamics", 'FontSize',20)


% Plot rigid joints %
plot(A(1), A(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k'); % Point A
text(A(1)-0.2, A(2)-0.2, 'A', 'FontSize', 20);

plot(B(1), B(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k'); % Point B
text(B(1)+0.1, B(2)-0.2, 'B', 'FontSize', 20);

% Initialize plot objects for springs and mass %
spring1 = plot([A(1), x(1)], [A(2), y(1)], 'b', 'LineWidth', 2);
spring2 = plot([B(1), x(1)], [B(2), y(1)], 'r', 'LineWidth', 2);
mass = plot(x(1), y(1), 'ks', 'MarkerSize', 12, 'MarkerFaceColor', 'g');

% Animation loop %
for i = 1:length(t)
    % Update spring positions %
    set(spring1, 'XData', [A(1), x(i)], 'YData', [A(2), y(i)]);
    set(spring2, 'XData', [B(1), x(i)], 'YData', [B(2), y(i)]);
    
    % Update mass position %
    set(mass, 'XData', x(i), 'YData', y(i));
    
    % Pause to create animation effect %
    pause(0.05);
end
hold off;

% Function for the right-hand side of the ODE %
function zdot = myrhs(t, z, p)
    r = z(1:2);
    v = z(3:4);
    
    % Unpack parameters %
    k1 = p.k1; k2 = p.k2; l01 = p.l01; l02 = p.l02;
    m = p.m; F = p.F; r_b_from_a = p.r_b_from_a; g = p.g;
    
    % Compute spring forces %
    l1 = norm(r);
    l2 = norm(r - r_b_from_a);
    
    Fs1 = -k1 * (l1 - l01) * (r / l1);
    Fs2 = -k2 * (l2 - l02) * ((r - r_b_from_a) / l2);
    
    % Total force %
    Ftot = F + Fs1 + Fs2 - (m * g * [0; 1]);
    
    % Equations of motion %
    rdot = v;
    vdot = Ftot / m;
    
    zdot = [rdot; vdot];
end
