function animate_feynman(solution, z0, tspan, time_scale)

% -> for feynman wobbling -> make circular disk centered around z-axis
% -> draw a line coming out of the disk along z-axis
% -> plot the trajectory taken by the tip of the line

    % Create points for a circular disk around z-axis
    num_points = 16; % Number of points on the circumference
    radius = 0.5;    % Radius of the disk
    
    % Create center point and pole point
    disk_center = [0; 0; 0];
    pole_point = [0; 0; 0.5]; % Point extending along z-axis
    
    % Create points around the circumference of the disk
    disk_points = zeros(3, num_points);
    for i = 1:num_points
        angle = 2*pi*(i-1)/num_points;
        disk_points(:, i) = [radius*cos(angle); radius*sin(angle); 0];
    end
    
    % Extract rotation matrix from initial state
    e11 = z0(7); e12 = z0(8); e13 = z0(9);
    e21 = z0(10); e22 = z0(11); e23 = z0(12);
    e31 = z0(13); e32 = z0(14); e33 = z0(15);
    R = [e11 e12 e13;
         e21 e22 e23;
         e31 e32 e33];
    
    % Transform points to world frame
    transformed_center = R*disk_center;
    transformed_pole = R*pole_point;
    transformed_disk_points = zeros(3, num_points);
    for i = 1:num_points
        transformed_disk_points(:, i) = R*disk_points(:, i);
    end
    
    % Create figure and set properties
    figure;
    hold on;
    view(3);
    axis equal;
    xlim([-2 2]);
    ylim([-2 2]);
    zlim([-2 2]);
    grid on;
    
    % Plot disk edges (connecting adjacent points on the circumference)
    disk_edges = cell(num_points, 1);
    for i = 1:num_points
        j = mod(i, num_points) + 1;  % Next point (loops back to first)
        x_data = [transformed_disk_points(1, i), transformed_disk_points(1, j)];
        y_data = [transformed_disk_points(2, i), transformed_disk_points(2, j)];
        z_data = [transformed_disk_points(3, i), transformed_disk_points(3, j)];
        disk_edges{i} = plot3(x_data, y_data, z_data, 'b-', 'LineWidth', 1.5);
    end
    
    % Plot spokes (lines from center to circumference)
    spokes = cell(num_points, 1);
    for i = 1:num_points
        x_data = [transformed_center(1), transformed_disk_points(1, i)];
        y_data = [transformed_center(2), transformed_disk_points(2, i)];
        z_data = [transformed_center(3), transformed_disk_points(3, i)];
        spokes{i} = plot3(x_data, y_data, z_data, 'g-', 'LineWidth', 0.5);
    end
    
    % Plot pole (line along z-axis)
    pole = plot3([transformed_center(1), transformed_pole(1)],... 
                 [transformed_center(2), transformed_pole(2)],...
                 [transformed_center(3), transformed_pole(3)],... 
                 'r-', 'LineWidth', 2.5);
    
    % Plot pole tip (marker at the end of the pole)
    pole_tip = plot3(transformed_pole(1), transformed_pole(2), transformed_pole(3),... 
                    'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
    
    % Plot center point
    center_point = plot3(transformed_center(1), transformed_center(2), transformed_center(3), ...
                        'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8);
    
    % Initialize trajectory plot - will store the path of the pole tip
    trajectory_x = [transformed_pole(1)];
    trajectory_y = [transformed_pole(2)];
    trajectory_z = [transformed_pole(3)];
    trajectory_plot = plot3(trajectory_x, trajectory_y, trajectory_z, 'm-', 'LineWidth', 1);
    
    xlabel('x (m)');
    ylabel('y (m)');
    zlabel('z (m)');
    
    % Set title
    title('Feynman Disk Animation');
    
    % Animation loop
    tstart = tic();
    while true
        curr_time = toc(tstart);
        if curr_time > tspan(2)
            break;
        end
        
        % Get current state
        z = deval(solution, curr_time);
        
        % Extract rotation matrix
        e11 = z(7); e12 = z(8); e13 = z(9);
        e21 = z(10); e22 = z(11); e23 = z(12);
        e31 = z(13); e32 = z(14); e33 = z(15);
        R = [e11 e12 e13;
             e21 e22 e23;
             e31 e32 e33];
        
        % Transform points to world frame
        transformed_center = R*disk_center;
        transformed_pole = R*pole_point;
        
        for i = 1:num_points
            transformed_disk_points(:, i) = R*disk_points(:, i);
        end
        
        % Update disk edges
        for i = 1:num_points
            j = mod(i, num_points) + 1;  % Next point (loops back to first)
            set(disk_edges{i}, 'XData', [transformed_disk_points(1, i), transformed_disk_points(1, j)],...
                              'YData', [transformed_disk_points(2, i), transformed_disk_points(2, j)],...
                              'ZData', [transformed_disk_points(3, i), transformed_disk_points(3, j)]);
        end
        
        % Update spokes
        for i = 1:num_points
            set(spokes{i}, 'XData', [transformed_center(1), transformed_disk_points(1, i)],...
                          'YData', [transformed_center(2), transformed_disk_points(2, i)],...
                          'ZData', [transformed_center(3), transformed_disk_points(3, i)]);
        end
        
        % Update pole
        set(pole, 'XData', [transformed_center(1), transformed_pole(1)],...
                 'YData', [transformed_center(2), transformed_pole(2)],...
                 'ZData', [transformed_center(3), transformed_pole(3)]);
        
        % Update pole tip
        set(pole_tip, 'XData', transformed_pole(1),...
                     'YData', transformed_pole(2),...
                     'ZData', transformed_pole(3));
        
        % Update center point
        set(center_point, 'XData', transformed_center(1),...
                         'YData', transformed_center(2),...
                         'ZData', transformed_center(3));
        
        % Update trajectory
        trajectory_x = [trajectory_x, transformed_pole(1)];
        trajectory_y = [trajectory_y, transformed_pole(2)];
        trajectory_z = [trajectory_z, transformed_pole(3)];
        set(trajectory_plot, 'XData', trajectory_x, 'YData', trajectory_y, 'ZData', trajectory_z);
        
        drawnow;
        
        % Optional: add delay for smoother animation if needed
        % pause(0.01);
    end
end