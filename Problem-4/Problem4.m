% RO2102 Dynamics and Simulation %
% Assignment-2; Problem-4 %
% Tanay Srinivasa, 20 Jan 2025 %
% Due Date: 24 Jan 2025 %
% Time Spent on Problem: 3 Hour 30 Min %

% Vector Definitions
a = [0.7;0.3;0.5];
b = [0.3;1.2;0.8];
c = [0.4;0.2;0.5];
d = b + c;

% Projections onto the plane orthogonal to A
b_dash = norm(b) * (b - (dot(b, a) / dot(a, a)) * a);
c_dash = norm(c) * (c - (dot(c, a) / dot(a, a)) * a);
d_dash = norm(d) * (d - (dot(d, a) / dot(a, a)) * a);

% Scaling by the magnitude of A
b_ddash = norm(a) * b_dash;
c_ddash = norm(a) * c_dash;
d_ddash = norm(a) * d_dash;

% Rotating by 90° positively about A
axangle = [a(1)/norm(a), a(2)/norm(a), a(3)/norm(a), pi/2];
R = axang2rotm(axangle);

b_dddash = R * b_ddash;
c_dddash = R * c_ddash;
d_dddash = R * d_ddash;

% Plotting
figure('Position', [100, 100, 1200, 900]);

% Plot 1: a, b, b_dash, b_ddash, b_dddash
subplot(2, 2, 1);
hold on; grid on; axis equal; view(3);
quiver3(0, 0, 0, a(1), a(2), a(3), 'w', 'LineWidth', 1.5, 'DisplayName', 'a');
quiver3(0, 0, 0, b(1), b(2), b(3), 'b', 'LineWidth', 1.5, 'DisplayName', 'b');
quiver3(0, 0, 0, b_ddash(1), b_ddash(2), b_ddash(3), 'g', 'LineWidth', 1.5, 'DisplayName', 'b\_ddash');
quiver3(0, 0, 0, b_dash(1), b_dash(2), b_dash(3), 'r', 'LineWidth', 1.5, 'DisplayName', 'b\_dash');
quiver3(0, 0, 0, b_dddash(1), b_dddash(2), b_dddash(3), 'm', 'LineWidth', 1.5, 'DisplayName', 'b\_dddash');
plotPlane([0,0,0], a, (b - (dot(b, a) / dot(a, a)) * a), 'cyan', 0.3, 'Plane A-B');
legend show; title('Plot 1');

% Plot 2: a, c, c_dash, c_ddash, c_dddash
subplot(2, 2, 2);
hold on; grid on; axis equal; view(3);
quiver3(0, 0, 0, a(1), a(2), a(3), 'w', 'LineWidth', 1.5, 'DisplayName', 'a');
quiver3(0, 0, 0, c(1), c(2), c(3), 'b', 'LineWidth', 1.5, 'DisplayName', 'c');
quiver3(0, 0, 0, c_ddash(1), c_ddash(2), c_ddash(3), 'g', 'LineWidth', 1.5, 'DisplayName', 'c\_ddash');
quiver3(0, 0, 0, c_dash(1), c_dash(2), c_dash(3), 'r', 'LineWidth', 1.5, 'DisplayName', 'c\_dash');
quiver3(0, 0, 0, c_dddash(1), c_dddash(2), c_dddash(3), 'm', 'LineWidth', 1.5, 'DisplayName', 'c\_dddash');
plotPlane([0,0,0], a, (c - (dot(c, a) / dot(a, a)) * a), 'red', 0.3, 'Plane A-C');
legend show; title('Plot 2');

% Plot 3: a, d, d_dash, d_ddash, d_dddash
subplot(2, 2, 3);
hold on; grid on; axis equal; view(3);
quiver3(0, 0, 0, a(1), a(2), a(3), 'w', 'LineWidth', 1.5, 'DisplayName', 'a');
quiver3(0, 0, 0, d(1), d(2), d(3), 'b', 'LineWidth', 1.5, 'DisplayName', 'd');
quiver3(0, 0, 0, d_ddash(1), d_ddash(2), d_ddash(3), 'g', 'LineWidth', 1.5, 'DisplayName', 'd\_ddash');
quiver3(0, 0, 0, d_dash(1), d_dash(2), d_dash(3), 'r', 'LineWidth', 1.5, 'DisplayName', 'd\_dash');
quiver3(0, 0, 0, d_dddash(1), d_dddash(2), d_dddash(3), 'm', 'LineWidth', 1.5, 'DisplayName', 'd\_dddash');
plotPlane([0,0,0], a, (d - (dot(d, a) / dot(a, a)) * a), 'yellow', 0.3, 'Plane A-D');
legend show; title('Plot 3');

% Plot 4: a, b_dddash, c_dddash (starting at head of b_dddash), d_dddash
subplot(2, 2, 4);
hold on; grid on; axis equal; view(3);
quiver3(0, 0, 0, a(1), a(2), a(3), 'w', 'LineWidth', 1.5, 'DisplayName', 'a');
quiver3(0, 0, 0, b_dddash(1), b_dddash(2), b_dddash(3), 'b', 'LineWidth', 1.5, 'DisplayName', 'b\_dddash');
quiver3(b_dddash(1), b_dddash(2), b_dddash(3), c_dddash(1), c_dddash(2), c_dddash(3), 'r', 'LineWidth', 1.5, 'DisplayName', 'c\_dddash');
quiver3(0, 0, 0, d_dddash(1), d_dddash(2), d_dddash(3), 'g', 'LineWidth', 1.5, 'DisplayName', 'd\_dddash');
plotPlane([0,0,0], a, (b - (dot(b, a) / dot(a, a)) * a)/norm((b - (dot(b, a) / dot(a, a)) * a)), 'cyan', 0.3, 'Plane A-B');
plotPlane([0,0,0], a, (c - (dot(c, a) / dot(a, a)) * a)/norm((c - (dot(c, a) / dot(a, a)) * a)), 'red', 0.3, 'Plane A-C');
plotPlane([0,0,0], a, (d - (dot(d, a) / dot(a, a)) * a)/norm((d - (dot(d, a) / dot(a, a)) * a)), 'yellow', 0.3, 'Plane A-D');
legend show; title('Plot 4');
hold off;

% Function to plot plane
function plotPlane(origin, vec1, vec2, color, alpha, label)
 [X,Y] = meshgrid([-1 1], [-1 1]);
 % Calculate plane points directly
 X_plane = origin(1) + vec1(1)*X + vec2(1)*Y;
 Y_plane = origin(2) + vec1(2)*X + vec2(2)*Y;
 Z_plane = origin(3) + vec1(3)*X + vec2(3)*Y;
 surf(X_plane, Y_plane, Z_plane, ...
'FaceColor', color, 'FaceAlpha', alpha, 'EdgeColor', 'none', 'DisplayName',label); 
end