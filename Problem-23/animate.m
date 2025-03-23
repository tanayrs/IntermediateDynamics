function animate(solution, z0, time_scale)
    t = linspace(solution.x(1), solution.x(end), 1000);
    zvals = deval(solution,t);

    x_vals = zvals(1,:);
    y_vals = zvals(2,:);

    hold on;
    
    xlim([min(x_vals)-0.5, max(x_vals)+0.5]);
    axis equal; 

    m1 = plot(z0(1), z0(2), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
    trajectory = plot(z0(1), z0(2), 'b--');

    traj = [z0(1) z0(1); z0(2) z0(2)];
    
    grid on;

    tstart = tic();

    while true
        t_curr = toc(tstart) * time_scale;

        if t_curr > solution.x(end)
            break;
        end

        z_curr = deval(solution, t_curr);
        set(m1, 'XData', z_curr(1), 'YData', z_curr(2));

        traj(end+1,:) = [z_curr(1), z_curr(2)];
        set(trajectory, 'XData', traj(:,1), 'YData', traj(:,2));


        drawnow;
    end
    hold off;
end