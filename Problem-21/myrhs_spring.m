function zdot = myrhs_spring(z,t,p)
    k = p.k; l0 = p.l0; m1 = p.m1; m2 = p.m2; F0 = p.F0; omega = p.omega;
    
    F = F0 * sin(omega*t);

    x1 = z(1);
    x2 = z(2);
    x1dot = z(3);
    x2dot = z(4);

    Fs = k*(x2-x1-l0);

    x1ddot = Fs/m1;
    x2ddot = (F - Fs)/m2;

    zdot = [x1dot; x2dot; x1ddot; x2ddot];
end
