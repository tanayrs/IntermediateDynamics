function compare_spring(solution, solution_spring, tspan)
    t = linspace(tspan(1), tspan(2), 1000);
    zvals = deval(solution, t);
    zvals_spring = deval(solution_spring,t);

    error = zvals_spring - zvals;

    figure;
    subplot(3,1,1)
    plot(t, zvals(1,:), 'DisplayName', "Rigid Constraint");
    hold on;
    plot(t, zvals_spring(1,:), 'DisplayName', "Spring");
    xlabel("Time (s)")
    ylabel("x (m)")
    subtitle("x1 Plot")
    legend()
    title("Comparison with high stiffness spring")

    subplot(3,1,2)
    plot(t, zvals(2,:), 'DisplayName', "Rigid Constraint");
    hold on
    plot(t, zvals_spring(2,:), 'DisplayName', "Spring");
    xlabel("Time (s)")
    ylabel("x (m)")
    subtitle("x2 Plot")
    legend()

    subplot(3,1,3)
    plot(t, error(1,:), 'DisplayName', "Error X1");
    hold on
    plot(t, error(2,:), 'DisplayName', "Error X2");
    xlabel("Time (s)")
    ylabel("x-error (m)")
    subtitle("Error Plot")
    legend()
end