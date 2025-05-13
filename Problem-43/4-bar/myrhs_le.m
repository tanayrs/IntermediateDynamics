function zdot = myrhs_le(z, t, p)
    Ig1 = p.Ig1; Ig2 = p.Ig2; Ig3 = p.Ig3; Ig4 = p.Ig4;
    d1 = p.d1; d2 = p.d2; d3 = p.d3; d4 = p.d4;
    g = p.g; l1 = p.l1; l2 = p.l2; l3 = p.l3;
    m1 = p.m1; m2 = p.m2; m3 = p.m3; m4 = p.m4;
    
    theta1 = z(1);
    theta2 = z(2);
    theta3 = z(3);
    theta4 = z(4);
    theta1dot = z(5);
    theta2dot = z(6);
    theta3dot = z(7);
    theta4dot = z(8);

    w = alphas_fn(Ig1,Ig2,Ig3,Ig4,d1,d2,d3,d4,g,l1,l2,l3,m1,m2,m3,m4,...
        theta1,theta2,theta3,theta4,theta1dot,theta2dot,theta3dot,theta4dot)

    zdot = [theta1dot; theta2dot; theta3dot; theta4dot; w(1); w(2); w(3); w(4)];
end