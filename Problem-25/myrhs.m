function zdot = myrhs(z,t,p)
    m = p.m;
    
    x1 = z(1);
    y1 = z(2);
    x2 = z(3);
    y2 = z(4);
    x1dot = z(5);
    y1dot = z(6);
    x2dot = z(7);
    y2dot = z(8);

    x = x1 - x2;
    y = y1 - y2;

    xdot = x1dot - x2dot;
    ydot = y1dot - y2dot;
    
    denom = sqrt((x^2) + (y^2));

    A = [m  0  0  0   x/denom;
         0  m  0  0   y/denom;
         0  0  m  0  -x/denom;
         0  0  0  m  -y/denom;
         x -x  y -y    0    ];

    acc_vec = A \ [0; 0; 0; 0; - (xdot^2) - (ydot^2)];

    zdot = [x1dot; y1dot; x2dot; y2dot; 
        acc_vec(1); acc_vec(2); acc_vec(3); acc_vec(4)];
end