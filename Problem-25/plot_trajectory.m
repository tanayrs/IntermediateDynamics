function plot_trajectory(solution)
    t = linspace(solution.x(1), solution.x(end), 1000);

    zvals = deval(solution,t);

    figure;
    subplot(3,1,1);
    plot(t,zvals(1,:), 'DisplayName', "X1");
    hold on;
    plot(t,zvals(3,:), 'DisplayName', "X2");
    legend();

    subplot(3,1,2);
    plot(t,zvals(2,:), 'DisplayName', "X1");
    hold on;
    plot(t,zvals(4,:), 'DisplayName', "X2");
    legend();

    subplot(3,1,3);
    L = sqrt((zvals(3,:)-zvals(1,:)).*(zvals(3,:)-zvals(1,:))+...
        (zvals(4,:)-zvals(2,:)).*(zvals(4,:)-zvals(2,:)));
    plot(t,L,'DisplayName',"Length Between two masses");

    hold off;


end