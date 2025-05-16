function animate_dae(solution, tspan, z0, p, time_scale)
    l1 = p.l1; l2 = p.l2; d1 = p.d1; d2 = p.d2; d3 = p.d3; l3 = p.l3;

    theta1 = z0(1);
    theta2 = z0(2);
    theta3 = z0(3);
    x1 = z0(4);
    y1 = z0(5);
    x2 = z0(6);
    y2 = z0(7);
    x3 = z0(8);
    y3 = z0(9);

    i = [1; 0; 0];
    j = [0; 1; 0];

    er1 = (sin(theta1)*i) - (cos(theta1)*j);
    er2 = (sin(theta2)*i) - (cos(theta2)*j);
    er3 = (sin(theta3)*i) - (cos(theta3)*j);
    
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
    
    link3 = plot([(l1*er1(1))+(l2*er2(1)),(l1*er1(1))+(l2*er2(1)+(l3*er3(1)))],...
                 [(l1*er1(2))+(l2*er2(2)),(l1*er1(2))+(l2*er2(2)+(l3*er3(2)))], 'w-','LineWidth',5, ...
                 'DisplayName', "Link 3");

    rg1 = plot(x1,y1,'.','MarkerSize', 25,...
               'DisplayName','r_{G1}');
    rg2 = plot(x2,y2, ...
               '.', 'MarkerSize', 25, 'DisplayName','r_{G2}');
    rg3 = plot(x3,y3, ...
               '.', 'MarkerSize', 25, 'DisplayName','r_{G3}');

    re = plot(l1*er1(1), l1*er1(2), ...
        '.', 'MarkerSize', 25, 'DisplayName','r_{E}');

    rf = plot(l1*er1(1)+l2*er2(1),l1*er1(2) + l2*er2(2),...
        '.', 'MarkerSize', 25, 'DisplayName', 'r_{E}');

    tstart = tic();

    while true
        curr_time = toc(tstart)*time_scale;

        if curr_time > tspan(end)
            break;
        end

        z_curr = deval(solution,curr_time);
        
        theta1 = z_curr(1);
        theta2 = z_curr(2);
        theta3 = z_curr(3);
        x1 = z_curr(4);
        y1 = z_curr(5);
        x2 = z_curr(6);
        y2 = z_curr(7);
        x3 = z_curr(8);
        y3 = z_curr(9);

        er1 = (sin(theta1)*i) - (cos(theta1)*j);
        er2 = (sin(theta2)*i) - (cos(theta2)*j);
        er3 = (sin(theta3)*i) - (cos(theta3)*j);

        set(link1,'XData',[0,l1*er1(1)],'YData',[0,l1*er1(2)]);
    
        set(link2,'XData',[l1*er1(1),(l1*er1(1))+(l2*er2(1))],...
            'YData',[l1*er1(2),(l1*er1(2))+(l2*er2(2))]);

        set(link3,'XData',[(l1*er1(1))+(l2*er2(1)),(l1*er1(1))+(l2*er2(1)+(l3*er3(1)))],...
            'YData',[(l1*er1(2))+(l2*er2(2)),(l1*er1(2))+(l2*er2(2)+(l3*er3(2)))]);

        set(rg1, 'XData', x1, 'YData', y1);
        set(rg2, 'XData', x2, 'YData', y2);
        set(rg3, 'XData', x3, 'YData', y3);
        
        
        set(re, 'XData', l1*er1(1), 'YData', l1*er1(2));
        set(rf, 'XData', l1*er1(1)+l2*er2(1), 'YData', l1*er1(2)+l2*er2(2));
        
        xlim([-l1-l2-0.5, l1+l2+0.5]);
        ylim([-l1-l2-0.5, l1+l2+0.5]);

        drawnow;
    end


end