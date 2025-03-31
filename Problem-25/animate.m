function animate(solution, z0, time_scale)
    t = linspace(solution.x(1), solution.x(end), 1000);
    zvals = deval(solution,t);

    x1_vals = zvals(1,:);
    x2_vals = zvals(3,:);
    y1_vals = zvals(2,:);
    y2_vals = zvals(4,:);

    hold on;
    
    xlim([min([x1_vals, x2_vals])-0.5, max([x1_vals, x2_vals])+0.5]);
    axis equal; 

    m1 = plot(z0(1), 0, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
    m2 = plot(z0(2), 0, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 10);

    plot(x1_vals,y1_vals,'b--');
    plot(x2_vals,y2_vals,'r--');
    
    grid on;

    tstart = tic();

    while true
        t_curr = toc(tstart) * time_scale;

        if t_curr > solution.x(end)
            break;
        end

        z_curr = deval(solution, t_curr);
        set(m1, 'XData', z_curr(1), 'YData', z_curr(2));
        set(m2, 'XData', z_curr(3), 'YData', z_curr(4));

        drawnow;
    end
    hold off;
end
