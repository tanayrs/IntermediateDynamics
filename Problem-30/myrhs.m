function zdot = myrhs(z,t,p)
    c = p.c; g = p.g;

    x = z(1);
    y = z(2);

    xdot = z(3);
    ydot = z(4);

    xddot = (-2*c*x*(g-(4*c*xdot*xdot)))/(1+(4*c*c*x*x));
    yddot = 2*c*((xdot*xdot) + (x*xddot));

    zdot = [xdot; ydot; xddot; yddot];
end