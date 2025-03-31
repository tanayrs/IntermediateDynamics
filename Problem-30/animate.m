function animate(solution, z0, tspan, p)
    t = linspace(tspan(1),tspan(end),1000);
    
    z_vals = deval(solution,t);
    
    x_vals = z_vals(1,:);
    y_vals = z_vals(2,:);

    mass = plot(z0(1), z0(2), '.', 'MarkerSize', 50);
    hold on;

    min_x = min(x_vals) - 1;
    max_x = max(x_vals) + 1;
    x = linspace(min_x, max_x, 1000);
    y = p.c * x .* x;

    plot(x, y, 'w--', 'DisplayName',"Constraint");

    xlim([min(x_vals)-0.5, max(x_vals) + 0.5]);
    ylim([min(y_vals)-0.5, max(y_vals) + 0.5]);

    axis equal;
    grid on;
    legend on;


    tstart = tic();

    while true
        curr_time = toc(tstart);

        if curr_time > tspan(end)
            break;
        end

        z_curr = deval(solution, curr_time);

        set(mass, 'XData', z_curr(1), 'YData', z_curr(2));

        drawnow;
    end
    hold off;

end