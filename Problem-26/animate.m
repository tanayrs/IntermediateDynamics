function animate(solution, phi0, tspan)
    theta0 = 0;

    er = [cos(phi0); -sin(phi0); 0];
    etheta = [sin(phi0); cos(phi0); 0];

    er2 = (cos(theta0)*er) - (sin(theta0)*etheta);
    etheta2 = (sin(theta0)*er) + (cos(theta0)*etheta);

    % Define the square plate corners in er-etheta coordinate system
    plate_x = [-3.5*er(1) + 3.5*etheta(1), 3.5*er(1) + 3.5*etheta(1), ...
        3.5*er(1) - 3.5*etheta(1), -3.5*er(1) - 3.5*etheta(1), ...
        -3.5*er(1) + 3.5*etheta(1)];
    
    plate_y = [-3.5*er(2) + 3.5*etheta(2), 3.5*er(2) + 3.5*etheta(2), ...
        3.5*er(2) - 3.5*etheta(2), -3.5*er(2) - 3.5*etheta(2), ...
        -3.5*er(2) + 3.5*etheta(2)];
    
    % Create filled plate with some transparency
    plate_fill = fill(plate_x, plate_y, 'b', 'FaceAlpha', 0.3, 'DisplayName', 'Plate');
    
    hold on;
    
    plate_handle = plot(plate_x, plate_y, 'w-', 'LineWidth', 2, 'DisplayName', 'Plate Outline');
    
    % Create circles centered at +2er and -2er
    circle_radius = 1;
    theta_circle = linspace(0, 2*pi, 100);
    
    % First circle at +2er
    circle1_x = 2*er(1) + circle_radius*cos(theta_circle);
    circle1_y = 2*er(2) + circle_radius*sin(theta_circle);
    circle1_handle = plot(circle1_x, circle1_y, 'w:', 'LineWidth', 1.5, 'DisplayName', 'Circle 1');
    
    % Second circle at -2er
    circle2_x = -2*er(1) + circle_radius*cos(theta_circle);
    circle2_y = -2*er(2) + circle_radius*sin(theta_circle);
    circle2_handle = plot(circle2_x, circle2_y, 'w:', 'LineWidth', 1.5, 'DisplayName', 'Circle 2');
    
    m1 = plot(2*etheta(1), 2*etheta(2), '.', 'MarkerSize', 50, ...
        'DisplayName', "Mass 1");
    m2 = plot((2*er(1)) + er2(1), (2*er(2)) + er2(2), '.', 'MarkerSize', ...
        50, 'DisplayName', "Mass 2");
    m3 = plot(-2*etheta(1), -2*etheta(2), '.', 'MarkerSize', 50, ...
        'DisplayName', "Mass 3");
    m4 = plot(-(2*er(1)) - er2(1), -(2*er(2)) - er2(2), '.', 'MarkerSize', ...
        50, 'DisplayName', "Mass 4");
    
    xlim([-7.5, 7.5]);
    ylim([-7.5, 7.5]);
    
    axis equal;
    grid on;
    legend();
    
    tstart = tic();
    
    while true
        curr_time = toc(tstart);

        if curr_time > tspan(end)
            break;
        end
        
        phi = deval(solution, curr_time);
        theta = pi*(1-cos(curr_time));
        
        er = [cos(phi); -sin(phi); 0];
        etheta = [sin(phi); cos(phi); 0];
        
        er2 = (cos(theta)*er) - (sin(theta)*etheta);
        etheta2 = (sin(theta)*er) + (cos(theta)*etheta);
        
        % Extract x and y coordinates
        plate_x = [-3.5*er(1) + 3.5*etheta(1), 3.5*er(1) + 3.5*etheta(1), ...
            3.5*er(1) - 3.5*etheta(1), -3.5*er(1) - 3.5*etheta(1), ...
            -3.5*er(1) + 3.5*etheta(1)];
        plate_y = [-3.5*er(2) + 3.5*etheta(2), 3.5*er(2) + 3.5*etheta(2), ...
            3.5*er(2) - 3.5*etheta(2), -3.5*er(2) - 3.5*etheta(2), ...
            -3.5*er(2) + 3.5*etheta(2)];
        
        % Update circles
        circle1_x = 2*er(1) + circle_radius*cos(theta_circle);
        circle1_y = 2*er(2) + circle_radius*sin(theta_circle);
        circle2_x = -2*er(1) + circle_radius*cos(theta_circle);
        circle2_y = -2*er(2) + circle_radius*sin(theta_circle);
        
        % Update both the fill and outline
        set(plate_fill, 'XData', plate_x, 'YData', plate_y);
        set(plate_handle, 'XData', plate_x, 'YData', plate_y);
        set(circle1_handle, 'XData', circle1_x, 'YData', circle1_y);
        set(circle2_handle, 'XData', circle2_x, 'YData', circle2_y);
        
        % Update the masses
        set(m1, 'XData', 2*etheta(1), 'YData', 2*etheta(2));
        set(m2, 'XData', (2*er(1)) + er2(1), 'YData', (2*er(2)) + er2(2));
        set(m3, 'XData', -2*etheta(1), 'YData', -2*etheta(2));
        set(m4, 'XData', -(2*er(1)) - er2(1), 'YData', -(2*er(2)) - er2(2));
        drawnow;
    end
    hold off;
end