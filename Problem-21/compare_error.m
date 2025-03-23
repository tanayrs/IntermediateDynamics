function compare_error(solution, solution_dir, tspan)
    t = linspace(tspan(1), tspan(2), 1000);
    zvals = deval(solution, t);
    zvals_dir = deval(solution_dir, t);

    error = zvals_dir - zvals;

    figure;
    plot(t, error(1,:), 'DisplayName', "Error in X1");
    hold on;
    plot(t, error(2,:), 'DisplayName', "Error in X2");
    grid on;
    xlabel("Time (s)");
    ylabel("X-Error (m)");
    title("Error between DAE Approach and Direct Application of Constraint");
    hold off;
end