function animate(solution, tspan, z0, p, time_scale)
    l1 = p.l1; l2 = p.l2; d1 = p.d1; d2 = p.d2;

    theta1 = z0(1);
    theta2 = z0(2);

    i = [1; 0; 0];
    j = [0; 1; 0];

    er1 = (sin(theta1)*i) - (cos(theta1)*j);
    er2 = (sin(theta2)*i) - (cos(theta2)*j);
    
    link1 = plot([0,l1*er1(1)],[0,l1*er1(2)], 'w-','LineWidth',5, ...
        'DisplayName',"Link 1");
    
    hold on;
    
    xlim([-l1-l2-0.5, l1+l2+0.5]);
    ylim([-l1-l2-0.5, l1+l2+0.5]);

    grid on;
    axis equal;
    legend();

    link2 = plot([l1*er1(1),(l1*er1(1))+(l2*er2(1))],...
        [l1*er1(2),(l1*er1(2))+(l2*er2(2))], 'w-','LineWidth',5, ...
        'DisplayName', "Link 2");
    
    rg1 = plot(d1*er1(1),d1*er1(2),'.','MarkerSize', 25,...
        'DisplayName','r_{G1}');
    rg2 = plot(l1*er1(1) + d2*er2(1), l1*er1(2) + d2*er2(2), ...
        '.', 'MarkerSize', 25, 'DisplayName','r_{G2}');
    re = plot(l1*er1(1), l1*er1(2), ...
        '.', 'MarkerSize', 25, 'DisplayName','r_{E}');

    tstart = tic();

    while true
        curr_time = toc(tstart)*time_scale;

        if curr_time > tspan(end)
            break;
        end

        z_curr = deval(solution,curr_time);
        
        theta1 = z_curr(1);
        theta2 = z_curr(2);

        er1 = (sin(theta1)*i) - (cos(theta1)*j);
        er2 = (sin(theta2)*i) - (cos(theta2)*j);

        set(link1,'XData',[0,l1*er1(1)],'YData',[0,l1*er1(2)]);
    
        set(link2,'XData',[l1*er1(1),(l1*er1(1))+(l2*er2(1))],...
            'YData',[l1*er1(2),(l1*er1(2))+(l2*er2(2))]);

        set(rg1, 'XData', d1*er1(1), 'YData', d1*er1(2));
        set(rg2, 'XData', l1*er1(1) + d2*er2(1), ...
            'YData', l1*er1(2) + d2*er2(2));
        set(re, 'XData', l1*er1(1), 'YData', l1*er1(2));
        
        xlim([-l1-l2-0.5, l1+l2+0.5]);
        ylim([-l1-l2-0.5, l1+l2+0.5]);

        drawnow;
    end


end