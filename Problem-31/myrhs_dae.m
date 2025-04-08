function zdot = myrhs_dae(z, t, p)
    Ig1 = p.Ig1; Ig2 = p.Ig2; d1 = p.d1; d2 = p.d2; g = p.g; l1 = p.l1;
    m1 = p.m1; m2 = p.m2;
    
    theta1 = z(1);
    theta2 = z(2);
    theta1dot = z(3);
    theta2dot = z(4);

    A = A_matrix(Ig1, Ig2, d1, d2, l1, m1, m2, theta1, theta2);
    b = b_matrix(d1, d2, g, l1, m1, m2, theta1, theta2, theta1dot, theta2dot);

    w = A\b;

    zdot = [theta1dot; theta2dot; w(1); w(2)];
end