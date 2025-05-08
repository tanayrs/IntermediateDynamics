function zdot = myrhs_dae(z, t, p)
    Ig1 = p.Ig1; Ig2 = p.Ig2; Ig3 = p.Ig3; d1 = p.d1; d2 = p.d2; d3 = p.d3;
    g = p.g; l1 = p.l1; l2 = p.l2; m1 = p.m1; m2 = p.m2; m3 = p.m3;
    
    theta1 = z(1);
    theta2 = z(2);
    theta3 = z(3);
    theta1dot = z(4);
    theta2dot = z(5);
    theta3dot = z(6);

    A = A_matrix(Ig1,Ig2,Ig3,d1,d2,d3,l1,l2,m1,m2,m3,theta1,theta2,theta3);
    b = b_matrix(d1,d2,d3,g,l1,l2,m1,m2,m3,theta1,theta2,theta3,theta1dot,theta2dot,theta3dot);

    w = A\b;

    zdot = [theta1dot; theta2dot; theta3dot; w(1); w(2); w(3)];
end