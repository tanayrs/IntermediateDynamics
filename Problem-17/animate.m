function retval = animate(solution, tspan, z0, time_scale)
    % Unpacking values to calculate limits %
    z_vals = deval(solution, linspace(tspan(1), tspan(2), 10000));
    r1_vals = z_vals(1:2,:);
    r2_vals = z_vals(3:4,:);
    r3_vals = z_vals(5:6,:);

    % Figure Setup %
    figure; hold on;
    grid on; axis equal;

    xlim([min([r1_vals(1,:), r2_vals(1,:), r3_vals(1,:)]) - 0.5, max([r1_vals(1,:), r2_vals(1,:), r3_vals(1,:)]) + 0.5]);
    ylim([min([r1_vals(2,:), r2_vals(2,:), r3_vals(2,:)]) - 0.5, max([r1_vals(2,:), r2_vals(2,:), r3_vals(2,:)]) + 0.5]);


    xlabel("x-position (m)", 'FontSize', 20);
    ylabel("y-position (m)", 'FontSize', 20);
    title("Animation of Numerical Solution")

    plot(r1_vals(1,:),r1_vals(2,:), 'LineStyle','-', 'Color', 'r');
    plot(r2_vals(1,:),r2_vals(2,:), 'LineStyle','-.', 'Color','b');
    plot(r3_vals(1,:),r3_vals(2,:), 'LineStyle',':', 'Color','w');
    m1 = plot(z0(1), z0(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    m2 = plot(z0(3), z0(4), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
    m3 = plot(z0(5), z0(6), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'w');

    legend('Mass 1', 'Mass 2', 'Mass 3');

    total_time = tspan(2) - tspan(1);
    t_start = tic();

    while true
        elapsed_time = toc(t_start) * time_scale;

        if elapsed_time > total_time
            break;
        end

        z_current = deval(solution, elapsed_time);
        set(m1, 'XData', z_current(1), 'YData', z_current(2));
        set(m2, 'XData', z_current(3), 'YData', z_current(4));
        set(m3, 'XData', z_current(5), 'YData', z_current(6));

        drawnow;
    end
end
