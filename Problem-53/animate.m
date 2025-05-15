function animate(solution, z0, tspan, time_scale)
    % Define cube vertices in body frame (centered at [0.5, 0.5, 0.5])
    rOb = [0; 0; 0]-0.5;
    rAb = [1; 0; 0]-0.5;
    rBb = [1; 1; 0]-0.5;
    rCb = [0; 1; 0]-0.5;
    rDb = [0; 0; 1]-0.5;
    rEb = [1; 0; 1]-0.5;
    rFb = [1; 1; 1]-0.5;
    rGb = [0; 1; 1]-0.5;
    
    % Extract rotation matrix from initial state
    e11 = z0(7); e12 = z0(8); e13 = z0(9);
    e21 = z0(10); e22 = z0(11); e23 = z0(12);
    e31 = z0(13); e32 = z0(14); e33 = z0(15);
    R = [e11 e12 e13;
         e21 e22 e23;
         e31 e32 e33];
    
    % Transform vertices to world frame
    rO = R*rOb;
    rA = R*rAb;
    rB = R*rBb;
    rC = R*rCb;
    rD = R*rDb;
    rE = R*rEb;
    rF = R*rFb;
    rG = R*rGb;
    
    % Create figure and set properties
    figure;
    hold on;
    view(2);
    axis equal;
    xlim([-2 2]);
    ylim([-2 2]);
    zlim([-2 2]);
    grid on;
    
    % Plot edges (white lines)
    v1 = plot3([rO(1),rA(1)], [rO(2),rA(2)], [rO(3),rA(3)], 'w-');
    v2 = plot3([rB(1),rA(1)], [rB(2),rA(2)], [rB(3),rA(3)], 'w-');
    v3 = plot3([rB(1),rC(1)], [rB(2),rC(2)], [rB(3),rC(3)], 'w-');
    v4 = plot3([rO(1),rC(1)], [rO(2),rC(2)], [rO(3),rC(3)], 'w-');
    v5 = plot3([rD(1),rE(1)], [rD(2),rE(2)], [rD(3),rE(3)], 'w-');
    v6 = plot3([rF(1),rE(1)], [rF(2),rE(2)], [rF(3),rE(3)], 'w-');
    v7 = plot3([rF(1),rG(1)], [rF(2),rG(2)], [rF(3),rG(3)], 'w-');
    v8 = plot3([rD(1),rG(1)], [rD(2),rG(2)], [rD(3),rG(3)], 'w-');
    v9 = plot3([rD(1),rO(1)], [rD(2),rO(2)], [rD(3),rO(3)], 'w-');
    v10 = plot3([rE(1),rA(1)], [rE(2),rA(2)], [rE(3),rA(3)], 'w-');
    v11 = plot3([rB(1),rF(1)], [rB(2),rF(2)], [rB(3),rF(3)], 'w-');
    v12 = plot3([rG(1),rC(1)], [rG(2),rC(2)], [rG(3),rC(3)], 'w-');
    
    % Plot vertices (colored points)
    pO = plot3(rO(1), rO(2), rO(3), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
    pA = plot3(rA(1), rA(2), rA(3), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
    pB = plot3(rB(1), rB(2), rB(3), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8);
    pC = plot3(rC(1), rC(2), rC(3), 'co', 'MarkerFaceColor', 'c', 'MarkerSize', 8);
    pD = plot3(rD(1), rD(2), rD(3), 'mo', 'MarkerFaceColor', 'm', 'MarkerSize', 8);
    pE = plot3(rE(1), rE(2), rE(3), 'yo', 'MarkerFaceColor', 'y', 'MarkerSize', 8);
    pF = plot3(rF(1), rF(2), rF(3), 'ko', 'MarkerFaceColor', [0.8 0.4 0], 'MarkerSize', 8); % Orange
    pG = plot3(rG(1), rG(2), rG(3), 'ko', 'MarkerFaceColor', [0.5 0 0.5], 'MarkerSize', 8); % Purple
    
    xlabel('x (m)');
    ylabel('y (m)');
    zlabel('z (m)');
    
    % Set title
    title('Cube Animation');
    
    % Animation loop
    tstart = tic();
    while true
        curr_time = toc(tstart);
        if curr_time > tspan(2)
            break;
        end
        
        % Get current state
        z = deval(solution, curr_time);
        
        % Extract rotation matrix
        e11 = z(7); e12 = z(8); e13 = z(9);
        e21 = z(10); e22 = z(11); e23 = z(12);
        e31 = z(13); e32 = z(14); e33 = z(15);
        R = [e11 e12 e13;
             e21 e22 e23;
             e31 e32 e33];
        
        % Transform vertices to world frame
        rO = R*rOb;
        rA = R*rAb;
        rB = R*rBb;
        rC = R*rCb;
        rD = R*rDb;
        rE = R*rEb;
        rF = R*rFb;
        rG = R*rGb;
        
        % Update edge positions
        set(v1, 'XData', [rO(1),rA(1)], 'YData', [rO(2),rA(2)], 'ZData', [rO(3),rA(3)]);
        set(v2, 'XData', [rB(1),rA(1)], 'YData', [rB(2),rA(2)], 'ZData', [rB(3),rA(3)]);
        set(v3, 'XData', [rB(1),rC(1)], 'YData', [rB(2),rC(2)], 'ZData', [rB(3),rC(3)]);
        set(v4, 'XData', [rO(1),rC(1)], 'YData', [rO(2),rC(2)], 'ZData', [rO(3),rC(3)]);
        set(v5, 'XData', [rD(1),rE(1)], 'YData', [rD(2),rE(2)], 'ZData', [rD(3),rE(3)]);
        set(v6, 'XData', [rF(1),rE(1)], 'YData', [rF(2),rE(2)], 'ZData', [rF(3),rE(3)]);
        set(v7, 'XData', [rF(1),rG(1)], 'YData', [rF(2),rG(2)], 'ZData', [rF(3),rG(3)]);
        set(v8, 'XData', [rD(1),rG(1)], 'YData', [rD(2),rG(2)], 'ZData', [rD(3),rG(3)]);
        set(v9, 'XData', [rD(1),rO(1)], 'YData', [rD(2),rO(2)], 'ZData', [rD(3),rO(3)]);
        set(v10, 'XData', [rE(1),rA(1)], 'YData', [rE(2),rA(2)], 'ZData', [rE(3),rA(3)]);
        set(v11, 'XData', [rB(1),rF(1)], 'YData', [rB(2),rF(2)], 'ZData', [rB(3),rF(3)]);
        set(v12, 'XData', [rG(1),rC(1)], 'YData', [rG(2),rC(2)], 'ZData', [rG(3),rC(3)]);
        
        % Update vertex positions
        set(pO, 'XData', rO(1), 'YData', rO(2), 'ZData', rO(3));
        set(pA, 'XData', rA(1), 'YData', rA(2), 'ZData', rA(3));
        set(pB, 'XData', rB(1), 'YData', rB(2), 'ZData', rB(3));
        set(pC, 'XData', rC(1), 'YData', rC(2), 'ZData', rC(3));
        set(pD, 'XData', rD(1), 'YData', rD(2), 'ZData', rD(3));
        set(pE, 'XData', rE(1), 'YData', rE(2), 'ZData', rE(3));
        set(pF, 'XData', rF(1), 'YData', rF(2), 'ZData', rF(3));
        set(pG, 'XData', rG(1), 'YData', rG(2), 'ZData', rG(3));
        
        drawnow;
        
        % Optional: add delay for smoother animation if needed
        % pause(0.01);
    end
end