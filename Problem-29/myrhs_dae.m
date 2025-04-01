function zdot = myrhs_dae(z, t, p)
    g = p.g; omega = p.omega; d = p.d; m = p.m; Ig = p.Ig; r = p.r;

    x = z(1);
    y = z(2);
    theta = z(3);
    xdot = z(4);
    ydot = z(5);
    thetadot = z(6);

    % A = [1 0 0 0 0;
    %     0 1 0 0 0;
    %     m 0 m*d*sin(theta) -1 0;
    %     0 m m*d*cos(theta) 0 -1;
    %     -m*d*sin(theta) -m*d*cos(theta) ((m*d)+Ig) 0 0];
    % 
    % b = [-r*(omega^2)*sin(omega*t);
    %     0;
    %     m*(d*(thetadot^2) - g);
    %     -m*d*(thetadot^2)*sin(theta);
    %     m*g*d*sin(theta)];

    A = A_matrix(Ig, d, m, theta);
    b = B_matrix(d, g, m, omega, r, t, theta, thetadot);

    w = A\b;

    zdot = [xdot; ydot; thetadot; w(1); w(2); w(3)];
end