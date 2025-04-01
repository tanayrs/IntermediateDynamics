function zdot = myrhs(z, t, p)
    g = p.g; omega = p.omega; d = p.d; m = p.m; Ig = p.Ig; r = p.r;
    theta = z(1);
    thetadot = z(2);

    a0 = -r*(omega^2)*sin(omega*t);

    thetaddot = (m*d*sin(theta)*(a0+g))/(Ig + (m*(d^2)));

    zdot = [thetadot; thetaddot];
end