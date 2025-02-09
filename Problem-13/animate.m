function animate(solution, tspan, z0, p, time_scale)
    ra = p.ra; rb = p.rb;

    z_vals = solution.y;
    x_vals = z_vals(1,:);
    y_vals = z_vals(2,:);
    
    figure;
    shg;
    hold on;
    grid on;
    axis equal;
    
    % Set Limits for Plot %
    xlim([min([x_vals ra(1) rb(1)])-0.5, max([x_vals ra(1) rb(1)])+0.5]);
    ylim([min([y_vals ra(2) rb(2)])-0.5, max([y_vals ra(2) rb(2)])+0.5]);

    % Set Axis Labels %
    xlabel('x-position (m)', 'FontSize', 20);
    ylabel('y-position (m)', 'FontSize', 20);
    title('Animated Trajectory of Mass', 'FontSize',20);

    % Initialising Mass %
    mass = plot(z0(1), z0(2), 'ro', 'MarkerSize',10, 'MarkerFaceColor','r');
    stringA = plot([ra(1),z0(1)],[ra(2),z0(2)],'LineWidth',1.5, 'Color','w');
    stringB = plot([rb(1),z0(1)],[rb(2),z0(2)],'LineWidth',1.5, 'Color','w');

    % Initialising Clock %
    total_time = tspan(2) - tspan(1);
    tstart = tic;

    while true
        elapsed_time = toc(tstart)*time_scale;

        if elapsed_time > total_time
            break;
        end

        z_current = deval(solution, elapsed_time);
        set(mass, 'XData', z_current(1), 'YData', z_current(2));
        set(stringA, 'XData', [ra(1), z_current(1)], 'YData', [ra(2), z_current(2)]);
        set(stringB, 'XData', [rb(1), z_current(1)], 'YData', [rb(2), z_current(2)]);
        drawnow
    end

end

