function retval = compare_v0(rhs, tspan, theta0)
    v0_scalar = [1, 10, 1e2, 1e3];
    r0 = [0; 0]; 
    options = odeset('AbsTol',1e-3, 'RelTol',1e-3);
    t = linspace(tspan(1), tspan(2), 1000);

    figure;
    hold on;
    xmax = -inf;
    xmin = inf;
    ymax = -inf;
    ymin = inf;

    for i = 1:length(v0_scalar)
        v0 = [v0_scalar(i)*cos(theta0); v0_scalar(i)*sin(theta0)];
        z0 = [r0; v0];

        solution = ode45(rhs, tspan, z0, options);
        
        trajectory = deval(solution, t);

        x_vals = trajectory(1,:);
        y_vals = trajectory(2,:);

        xmin = min([x_vals, xmin]);
        xmax = max([x_vals, xmax]);
        ymin = min([y_vals, ymin]);
        ymax = max([y_vals, ymax]);
        
        plot(x_vals, y_vals);
    end

    xlim([xmin, xmax]);
    ylim([ymin, ymax]);

    xlabel("x-position (m)");
    ylabel("y-position (m)");

    title("Comparison of v0");
    legend("1 m/s", "10 m/s", "100 m/s", "1000 m/s")
    axis equal;
    grid on;
    hold off;

end