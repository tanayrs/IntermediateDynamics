function zdot = myrhs_constraint(z,t,p)
    m1 = p.m1; m2 = p.m2; F0 = p.F0; omega = p.omega;
    
    F = F0 * sin(omega*t);

    x1 = z(1);
    x2 = z(2);
    x1dot = z(3);
    x2dot = z(4);

    A = [m1 0 -1; 0 m2 1; 1 -1 0];
    acc_vec = A \ [0; F; 0];

    zdot = [x1dot; x2dot; acc_vec(1); acc_vec(2)];
end