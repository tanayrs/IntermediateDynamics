function zdot = myrhs(z,t,p)
    m = p.m;
    
    r1 = z(1:2);
    r2 = z(3:4);
    v1 = z(5:6);
    v2 = z(7:8);

    x1 = r1(1);
    y1 = r1(2);
    x2 = r2(1);
    y2 = r2(2);

    x1dot = v1(1);
    y1dot = v1(2);
    x2dot = v2(1);
    y2dot = v2(2);

    r = r1 - r2;
    v = v1 - v2;
    
    denom = norm(r);
    
    if denom == 0
        denom = eps;
    end

    A_hand = [m     0     0     0     r(1)/denom;
         0     m     0     0     r(2)/denom;
         0     0     m     0    -r(1)/denom;
         0     0     0     m    -r(2)/denom;
         r(1) -r(1)  r(2) -r(2) 0         ];

    A = A_matrix(m, x1, x2, y1, y2);

    % A_diff = A - A_hand;

    b = B_matrix(x1dot, x2dot, y1dot, y2dot);

    acc_vec = A \ b;

    zdot = [ v1; v2; acc_vec(1:2); acc_vec(3:4)];
end