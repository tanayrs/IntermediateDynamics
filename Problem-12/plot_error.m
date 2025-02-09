function retval = plot_error(rhs, tspan, z0, p)
    steps = [0.1, 0.01, 0.001, 1e-4];
    errors = [];
    for i = 1:length(steps)
        options = odeset('MaxStep',steps(i), 'Events',@hit_ground);
        solution = ode45(rhs, tspan, z0, options);
    
        time = solution.x;
        t = linspace(time(1), time(end), 100);
        solution = deval(solution,t);
    
        v = solution(3:4,:);
        v = sqrt((v(1,:).*v(1,:)) + (v(2,:).*v(2,:)));
        y = solution(2,:);
        ke = 0.5*p.m*v.*v;
        pe = p.m*p.g*y;
        te = ke+pe;
        errors(end+1) = mean(solution(5,:) - te);
    end

    plot(steps, errors);
    xlabel('Step Size');
    ylabel('Error');
    xscale('log');
    yscale('log');
    grid on;
    title('Effect of Integration Accuracy on Difference of Total Energy and Work');
end

% Event function to detect ground hit
function [value, isterminal, direction] = hit_ground(t, z)
    value = z(2);    
    isterminal = 1;
    direction = -1;
end