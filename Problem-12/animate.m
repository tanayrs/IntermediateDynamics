function retval = animate(solution, tspan, z0, time_scale)
    % Unpacking values to calculate limits %
    z_vals = deval(solution, linspace(tspan(1), tspan(2), 500));
    r_vals = z_vals(1:2,:);

    % Figure Setup %
    figure; hold on;
    grid on; axis equal;

    xlim([min(r_vals(1,:))-0.5, max(r_vals(1,:))+0.5]);
    ylim([min(r_vals(2,:))-0.5, max(r_vals(2,:))+0.5]);

    xlabel("x-position (m)", 'FontSize', 20);
    ylabel("y-position (m)", 'FontSize', 20);
    title("Animation of Numerical Solution")

    cannon = plot(z0(1), z0(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

    total_time = tspan(2) - tspan(1);
    t_start = tic();

    while true
        elapsed_time = toc(t_start) * time_scale;

        if elapsed_time > total_time
            break;
        end

        z_current = deval(solution, elapsed_time);
        set(cannon, 'XData', z_current(1), 'YData', z_current(2));

        drawnow;
    end
end