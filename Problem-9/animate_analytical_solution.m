function animate_analytical_solution(x_fun, y_fun, tspan, p, time_scale)

    % Generate time values for evaluation
    t_vals = linspace(tspan(1), tspan(2), 500);
    x_vals = x_fun(t_vals);
    y_vals = y_fun(t_vals);

    % Plot setup
    figure;
    hold on;
    grid on;
    axis equal;
    xlim([min(x_vals) - 1, max(x_vals) + 1]);
    ylim([min(y_vals) - 1, max(y_vals) + 1]);

    % Plot labels
    xlabel("x-position (m)", 'FontSize', 20);
    ylabel("y-position (m)", 'FontSize', 20);
    title("Animation of Analytical Solution");

    % Create the animated object
    particle = plot(x_vals(1), y_vals(1), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

    % Animate the trajectory in real-time
    total_time = tspan(2) - tspan(1);
    t_start = tic(); % Start the timer
    while true
        elapsed_time = toc(t_start) * time_scale;

        if elapsed_time > total_time
            break;
        end

        % Find the current position using the numeric functions
        current_x = x_fun(elapsed_time);
        current_y = y_fun(elapsed_time);

        % Update the particle position
        set(particle, 'XData', current_x, 'YData', current_y);

        % Refresh the plot
        drawnow;
    end

    % Keep the final frame displayed
    hold off;
end