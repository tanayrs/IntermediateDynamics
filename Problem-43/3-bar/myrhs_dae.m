function zdot = myrhs_dae(z, t, p)
    Ig1 = p.Ig1; Ig2 = p.Ig2; Ig3 = p.Ig3; d1 = p.d1; d2 = p.d2; d3 = p.d3;
    g = p.g; l1 = p.l1; l2 = p.l2; m1 = p.m1; m2 = p.m2; m3 = p.m3;
    
    theta1 = z(1);
    theta2 = z(2);
    theta3 = z(3);
    x1 = z(4);
    y1 = z(5);
    x2 = z(6);
    y2 = z(7);
    x3 = z(8);
    y3 = z(9);
    theta1dot = z(10);
    theta2dot = z(11);
    theta3dot = z(12);
    x1dot = z(13);
    y1dot = z(14);
    x2dot = z(15);
    y2dot = z(16);
    x3dot = z(17);
    y3dot = z(18);
    
    A = A_matrix(Ig1,Ig2,Ig3,d1,d2,d3,l1,l2,m1,m2,m3,theta1,theta2,theta3);
    b = b_matrix(d1,d2,d3,g,l1,l2,m1,m2,m3,theta1,theta2,theta3,theta1dot,theta2dot,theta3dot);

    w = A\b;

    zdot = [theta1dot; theta2dot; theta3dot; x1dot; y1dot; x2dot; y2dot; x3dot; y3dot; w(1); w(2); w(3); w(4); w(5); w(6); w(7); w(8); w(9)];
end