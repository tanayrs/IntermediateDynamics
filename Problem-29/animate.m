function animate(solution, z0, tspan, p, sol_type)
    d = p.d; r = p.r; omega = p.omega;

    if sol_type == 0
        er = [sin(z0(1)); cos(z0(1)); 0];
    else
        er = [sin(z0(3)); cos(z0(3)); 0];
    end
    
    mass = plot(d*er(1), d*er(2), '.', 'MarkerSize',50);
    
    hold on;
    pendulum = plot([0, d*er(1)], [0, d*er(2)], 'w-');

    ylim([-r-d-0.5, r+d+0.5]);
    xlim([-d-0.5, d+0.5]);
    
    axis equal;
    grid on;

    tstart = tic();

    while true
        curr_time = toc(tstart);

        if curr_time > tspan(end)
            break;
        end

        z_curr = deval(solution, curr_time);
        
        if sol_type == 0
            er = [sin(z_curr(1)); cos(z_curr(1)); 0];
        else
            er = [sin(z_curr(3)); cos(z_curr(3)); 0];
        end

        y = r*sin(omega*curr_time);

        set(mass, 'XData', d*er(1), 'YData', y+d*er(2));
        set(pendulum, 'XData', [0, d*er(1)], 'YData', [y, y+d*er(2)]);

        drawnow;
    end

end