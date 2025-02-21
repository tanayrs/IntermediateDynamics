function zdot = myrhs(z,t,p)
    m = p.m; G = p.G;

    r1 = z(1:2);
    r2 = z(3:4);
    r3 = z(5:6);

    v1 = z(7:8);
    v2 = z(9:10);
    v3 = z(11:12);

    r1_2 = r1-r2; norm_r1_2 = norm(r1_2);
    r1_3 = r1-r3; norm_r1_3 = norm(r1_3);

    r2_1 = r2-r1; norm_r2_1 = norm(r2_1);
    r2_3 = r2-r3; norm_r2_3 = norm(r2_3);

    r3_1 = r3-r1; norm_r3_1 = norm(r3_1);
    r3_2 = r3-r2; norm_r3_2 = norm(r3_2);

    Ftot1 = -(G*m*m)*((r1_2/(norm_r1_2^3))+(r1_3/(norm_r1_3^3)));
    Ftot2 = -(G*m*m)*((r2_1/(norm_r2_1^3))+(r2_3/(norm_r2_3^3)));
    Ftot3 = -(G*m*m)*((r3_1/(norm_r3_1^3))+(r3_2/(norm_r3_2^3)));

    a1 = Ftot1/m;
    a2 = Ftot2/m;
    a3 = Ftot3/m;

    zdot(1:2) = v1;
    zdot(3:4) = v2;
    zdot(5:6) = v3;

    zdot(7:8) = a1;
    zdot(9:10) = a2;
    zdot(11:12) = a3;

    zdot = zdot';
end