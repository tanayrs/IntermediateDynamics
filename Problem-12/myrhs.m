function zdot = myrhs(z, t, p)
    % Right-Hand Side of the ODE %
    m = p.m; c = p.c; g = p.g;

    r = z(1:2);  % Position [x, y]
    v = z(3:4);  % Velocity [vx, vy]
    lambda = -v/norm(v);

    j = [0; 1];  % Gravity direction
    Ftot = (c*norm(v)*norm(v))*lambda - (m*g*j);  % Total force
    rddot = Ftot/m;           % Acceleration

    zdot(1) = v(1);
    zdot(2) = v(2);
    zdot(3) = rddot(1);
    zdot(4) = rddot(2);
    zdot(5) = -c*norm(v)*norm(v);

    zdot = zdot';
end