% RO2102 Dynamics and Simulation %
% Assignment-1; Problem-2 %
% Tanay Srinivasa %
% Due Date: 16 Jan 2025 %
% Time Spent on Problem: 3.5 Hour  %

%% Part (b): Finding End Points of Shortest Line Segment %%

clc;
clear all;
close all;

ra = [2; 3; 4];
rb = [8; 7; 6];
rc = [9; 6; 5];
rd = [4; 9; 5];

line1 = rb - ra;
line1 = line1/norm(line1);
line2 = rd - rc;
line2 = line2/norm(line2);

syms x y;

point1 = ra + (x * line1);
point2 = rc + (y * line2);

[x, y] = minimize_distance(ra, rc, line1, line2);

% Compute final points and distance
p1 = ra + x*line1;
p2 = rc + y*line2;
d = norm(p2 - p1);

fprintf('Optimal x: %.6f\n', x);
fprintf('Optimal y: %.6f\n', y);
fprintf('Minimum distance: %.6f\n', d);

% Theoretical Answer 
min_dist_th = dot((rc-ra),cross((rb-ra),(rc-rd))/norm(cross((rb-ra),(rc-rd))));

fprintf('Theoretical Minimum distance: %.4f\n', min_dist_th);

function [x, y] = minimize_distance(ra, rc, line1, line2)
    % Initialize parameters
    learning_rate = 0.01;
    max_iterations = 1000;
    tolerance = 1e-6;
    
    % Initial guess
    x = 0;
    y = 0;
    
    for i = 1:max_iterations
        % Current points
        p1 = ra + x*line1;
        p2 = rc + y*line2;
        
        % Vector between points
        w = p2 - p1;
        
        % Compute Loss Function
        grad_x = -2 * dot(w, line1);
        grad_y = 2 * dot(w, line2);
        
        % Update x and y
        x_new = x - learning_rate * grad_x;
        y_new = y - learning_rate * grad_y;
        
        % Check convergence
        if norm([x_new - x, y_new - y]) < tolerance
            break;
        end
        
        x = x_new;
        y = y_new;
    end
end