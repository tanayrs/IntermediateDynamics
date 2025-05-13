function animate(solution, tspan, z0, p, time_scale)
    l1 = p.l1; l2 = p.l2; l3 = p.l3; l4 = p.l4;
    d1 = p.d1; d2 = p.d2; d3 = p.d3; d4 = p.d4;


    theta1 = z0(1);
    theta2 = z0(2);
    theta3 = z0(3);
    theta4 = z0(4);

    i = [1; 0; 0];
    j = [0; 1; 0];

    er1 = (sin(theta1)*i) - (cos(theta1)*j);
    er2 = (sin(theta2)*i) - (cos(theta2)*j);
    er3 = (sin(theta3)*i) - (cos(theta3)*j);
    er4 = (sin(theta4)*i) - (cos(theta4)*j);
    
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

    link4 = plot([(l1*er1(1))+(l2*er2(1)+(l3*er3(1))),(l1*er1(1))+(l2*er2(1)+(l3*er3(1)))+(l4*er4(1))],...
                 [(l1*er1(2))+(l2*er2(2)+(l3*er3(2))),(l1*er1(2))+(l2*er2(2)+(l3*er3(2)))+(l4*er4(2))], 'w-','LineWidth',5, ...
                 'DisplayName', "Link 4");

    rg1 = plot(d1*er1(1),d1*er1(2),'.','MarkerSize', 25,...
               'DisplayName','r_{G1}');
    rg2 = plot(l1*er1(1) + d2*er2(1), l1*er1(2) + d2*er2(2), ...
               '.', 'MarkerSize', 25, 'DisplayName','r_{G2}');
    rg3 = plot(l1*er1(1) + l2*er2(1) + d3*er3(1), ...
               l1*er1(2) + l2*er2(2) + d3*er3(2), ...
               '.', 'MarkerSize', 25, 'DisplayName','r_{G3}');
    rg4 = plot(l1*er1(1) + l2*er2(1) + l3*er3(1) + l4*er4(1), ...
               l1*er1(2) + l2*er2(2) + l3*er3(2) + l4*er4(2), ...
               '.', 'MarkerSize', 25, 'DisplayName','r_{G3}');

    re = plot(l1*er1(1), l1*er1(2), ...
              '.', 'MarkerSize', 25, 'DisplayName','r_{E}');

    rf = plot(l1*er1(1)+l2*er2(1),l1*er1(2) + l2*er2(2),...
              '.', 'MarkerSize', 25, 'DisplayName', 'r_{E}');

    rg = plot(l1*er1(1)+l2*er2(1)+l3*er3(1),...
              l1*er1(2) + l2*er2(2) +l3*er3(2),...
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
        theta4 = z_curr(4);

        er1 = (sin(theta1)*i) - (cos(theta1)*j);
        er2 = (sin(theta2)*i) - (cos(theta2)*j);
        er3 = (sin(theta3)*i) - (cos(theta3)*j);
        er4 = (sin(theta4)*i) - (cos(theta4)*j);

        set(link1,'XData',[0,l1*er1(1)],'YData',[0,l1*er1(2)]);
    
        set(link2,'XData',[l1*er1(1),(l1*er1(1))+(l2*er2(1))],...
            'YData',[l1*er1(2),(l1*er1(2))+(l2*er2(2))]);

        set(link3,'XData',[(l1*er1(1))+(l2*er2(1)),(l1*er1(1))+(l2*er2(1)+(l3*er3(1)))],...
            'YData',[(l1*er1(2))+(l2*er2(2)),(l1*er1(2))+(l2*er2(2)+(l3*er3(2)))]);

        set(link4, 'XData', [(l1*er1(1))+(l2*er2(1)+(l3*er3(1))),(l1*er1(1))+(l2*er2(1)+(l3*er3(1)))+(l4*er4(1))],...
            'YData', [(l1*er1(2))+(l2*er2(2)+(l3*er3(2))),(l1*er1(2))+(l2*er2(2)+(l3*er3(2)))+(l4*er4(2))]);

        set(rg1, 'XData', d1*er1(1), 'YData', d1*er1(2));
        set(rg2, 'XData', l1*er1(1) + d2*er2(1), ...
            'YData', l1*er1(2) + d2*er2(2));
        
        set(rg3, 'XData', l1*er1(1) + l2*er2(1) + d3*er3(1), ...
            'YData', l1*er1(2) + l2*er2(2) + d3*er3(2));

        set(rg4, 'XData', l1*er1(1) + l2*er2(1) + l3*er3(1) + d4*er4(1), ...
            'YData', l1*er1(2) + l2*er2(2) + l3*er3(2) + d4*er4(2));
        
        set(re, 'XData', l1*er1(1), 'YData', l1*er1(2));
        set(rf, 'XData', l1*er1(1)+l2*er2(1), 'YData', l1*er1(2)+l2*er2(2));
        set(rg, 'XData', l1*er1(1)+l2*er2(1)+l3*er3(1),...
            'YData', l1*er1(2)+l2*er2(2)+l3*er3(2));
        
        xlim([-l1-l2-0.5, l1+l2+0.5]);
        ylim([-l1-l2-0.5, l1+l2+0.5]);

        drawnow;
    end


end