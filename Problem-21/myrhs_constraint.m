function zdot = myrhs_constraint(z,t,p)
    m1 = p.m1; m2 = p.m2; F0 = p.F0; omega = p.omega;
    
    F = F0 * sin(omega*t);

    x1 = z(1);
    x2 = z(2);
    x1dot = z(3);
    x2dot = z(4);

    A = A_matrix(m1, m2);
    b = B_matrix(F);
    acc_vec = A \ b;

    zdot = [x1dot; x2dot; acc_vec(1); acc_vec(2)];
end