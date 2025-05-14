function zdot = myrhs_dae(z, t, p)
    Ig1 = p.Ig1; Ig2 = p.Ig2; d1 = p.d1; d2 = p.d2; g = p.g; l1 = p.l1;
    m1 = p.m1; m2 = p.m2;
    
    theta1 = z(1);
    theta2 = z(2);
    x1 = z(3);
    y1 = z(4);
    x2 = z(5);
    y2 = z(6);
    theta1dot = z(7);
    theta2dot = z(8);
    x1dot = z(9);
    y1dot = z(10);
    x2dot = z(11);
    y2dot = z(12);

    A = A_matrix(Ig1,Ig2,d1,d2,l1,m1,m2,theta1,theta2);
    b = b_matrix(d1,d2,g,l1,m1,m2,theta1,theta2,theta1dot,theta2dot);

    w = A\b;

    zdot = [theta1dot; theta2dot; x1dot; y1dot; x2dot; y2dot; w(1); w(2); w(3); w(4); w(5); w(6)];
end