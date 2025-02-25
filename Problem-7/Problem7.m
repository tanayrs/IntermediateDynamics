% RO2102 Dynamics and Simulation %
% Assignment-3; Problem-7 %
% Tanay Srinivasa, 25 Jan 2025 %
% Due Date: 28 Jan 2025 %
% Time Spent on Problem: 1 Hour %

clc;
clear all;
close all;

dvd_screensaver

function dvd_screensaver()
    % Create figure and set properties
    fig = figure('Color', 'k');
    ax = axes('Color', 'k', 'XLim', [0 16], 'YLim', [0 9]);
    grid on;
    axis off;
    set(ax, 'GridColor', [0.2 0.2 0.2], 'GridAlpha', 0.5);
    hold on;
    
    % Draw white border
    plot([0 16 16 0 0], [0 0 9 9 0], 'w', 'LineWidth', 2);
    
    % DVD logo coordinates (simplified)
    dvd_x = [0 0.2 0.2 0.15 0.15 0.05 0 0];
    dvd_y = [0 0 0.1 0.1 0.15 0.15 0.1 0];
    
    % Scale the logo
    scale = 10;
    dvd_x = dvd_x * scale;
    dvd_y = dvd_y * scale;
    
    % Calculate logo width and height for proper edge detection
    logo_width = max(dvd_x) - min(dvd_x);
    logo_height = max(dvd_y) - min(dvd_y);
    
    % Initial position (middle of screen) and velocity
    pos = [8 4.5]; % Middle of 16x9 screen
    speed = 0.025; % Constant speed
    angle = pi/4; % Initial angle (45 degrees)
    vel = speed * [cos(angle) sin(angle)];
    
    % Create patch object for DVD logo
    dvd = patch(dvd_x + pos(1), dvd_y + pos(2), 'w');
    
    % Text for "DVD" (adjusted position and alignment)
    text_handle = text(pos(1) + scale*0.1, pos(2) + scale*0.075, 'DVD', ...
        'Color', 'k', 'FontSize', 16, ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontName','Menlo');
    
    % Animation loop
    colors = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1];
    color_idx = 1;
    
    % Start timing for elapsed time display
    tic;
    
    while ishandle(fig)
        % Update position
        pos = pos + vel;
        
        % Check for collisions with walls
        if pos(1) <= 0 || pos(1) >= (16 - logo_width)
            % Reflect x velocity while maintaining y velocity
            vel(1) = -vel(1);
            color_idx = mod(color_idx, size(colors, 1)) + 1;
            
            % Adjust position to exactly touch the border
            if pos(1) <= 0
                pos(1) = 0;
            else
                pos(1) = 16 - logo_width;
            end
        end
        
        if pos(2) <= 0 || pos(2) >= (9 - logo_height)
            % Reflect y velocity while maintaining y velocity
            vel(2) = -vel(2);
            color_idx = mod(color_idx, size(colors, 1)) + 1;
            
            % Adjust position to exactly touch the border
            if pos(2) <= 0
                pos(2) = 0;
            else
                pos(2) = 9 - logo_height;
            end
        end
        
        % Update logo position and color
        set(dvd, 'XData', dvd_x + pos(1), 'YData', dvd_y + pos(2), ...
            'FaceColor', colors(color_idx, :));
        set(text_handle, 'Position', [pos(1) + scale*0.1, pos(2) + scale*0.075, 0]);
        
        % Use drawnow to update the figure
        drawnow;
    end
end
