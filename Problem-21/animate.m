function animate(solution, tspan, z0, time_scale)
    t = linspace(tspan(1), tspan(2), 1000);
    zvals = deval(solution,t);

    x1_vals = zvals(1,:);
    x2_vals = zvals(2,:);

    hold on;
    
    xlim([min([x1_vals, x2_vals])-0.5, max([x1_vals, x2_vals])+0.5]);
    axis equal;

    m1 = plot(z0(1), 0, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
    m2 = plot(z0(2), 0, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
    
    grid on;

    tstart = tic();

    while true
        t_curr = toc(tstart) * time_scale;

        if t_curr > tspan(2)
            break;
        end

        z_curr = deval(solution, t_curr);
        set(m1, 'XData', z_curr(1), 'YData', 0);
        set(m2, 'XData', z_curr(2), 'YData', 0);

        drawnow;
    end
    hold off;
end