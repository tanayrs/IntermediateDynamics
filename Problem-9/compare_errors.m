function retval = compare_errors(x_fun, y_fun, rhs, tspan, z0, p)
    steps = [0.1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6];
    errors_x = zeros(length(steps));
    errors_y = zeros(length(steps));
    
    for i = 1:length(steps)
        disp("Current Step Size: ");
        steps(i)
        options = odeset('MaxStep',steps(i), 'RelTol', 1e-2, 'AbsTol', 1e-2);
        solution = ode45(rhs, tspan, z0, options);

        % Finding Error at t = 2 %
        % Comment: The error at a tolerance of 1e-3 is at 1e-5, and at a tolerance
        % of 1e-6 is is at 1e-7.
        z_2 = deval(solution,2);
        error_x = x_fun(2) - z_2(1);
        error_y = y_fun(2) - z_2(2);

        errors_x(i) = abs(error_x);
        errors_y(i) = abs(error_y);
    end

    scatter(steps,errors_x, 'Color','r');
    hold on;
    xscale log;
    yscale log;
    grid on;
    scatter(steps,errors_y, 'Color', 'b');
    xlabel("Step Size", 'FontSize',20);
    ylabel("Error (m)", 'FontSize',20);
    legend("error_x", "error_y")
    hold off;
end