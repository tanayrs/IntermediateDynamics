function zdot = myrhs_dae(z,t,p)
    m = p.m; Ig = p.Ig; phi1 = p.phi1; phi2 = p.phi2; d1 = p.d1; d2 = p.d2;

    x = z(1);
    y = z(2);
    theta = z(3);
    xdot = z(4);
    ydot = z(5);
    thetadot = z(6);

    A = A_fn(Ig,d1,d2,m,phi1,phi2,theta);
    b = b_fn(d1,d2,phi1,phi2,theta,thetadot,xdot,ydot);

    w = A\b;

    zdot = [xdot; ydot; thetadot; w(1); w(2); w(3)];
end