function retval = plot_work(solution, p, time)
    t = linspace(time(1), time(end), 1000);
    solution = deval(solution,t);
    figure;
    subplot(2,1,1);
    plot(t,solution(5,:));
    hold on;
    xlabel('Time (s)');
    ylabel('Work (Nm)');
    grid on;
    title('Work Done by Drag', 'FontSize',20)
    
    subplot(2,1,2);
    v = solution(3:4,:);
    v = sqrt((v(1,:).*v(1,:)) + (v(2,:).*v(2,:)));
    y = solution(2,:);
    ke = 0.5*p.m*v.*v;
    pe = p.m*p.g*y;
    te = ke+pe;
    plot(t, te);
    xlabel('Time (s)');
    ylabel('Total Energy');
    title('Change in Total Energy', 'FontSize',20);
    grid on;
    hold off;
   
    figure;
    error = solution(5,:) - te;
    plot(t,error);
    hold on;
    xlabel('Time (s)');
    ylabel('Error (Nm)')
    grid on;
    title('Error in Change in Total Energy and Work Done', 'FontSize', 20);
    hold off;

    retval = mean(error);
end