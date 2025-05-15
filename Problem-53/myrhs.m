function zdot = myrhs(z,t,p)

    I1 = p.I1; I2 = p.I2; I3 = p.I3;

    theta1 = z(1);
    theta2 = z(2);
    theta3 = z(3);
    w1 = z(4);
    w2 = z(5);
    w3 = z(6);
    e11 = z(7);
    e12 = z(8);
    e13 = z(9);
    e21 = z(10);
    e22 = z(11);
    e23 = z(12);
    e31 = z(13);
    e32 = z(14);
    e33 = z(15);

    wdots = wdots_fn(I1,I2,I3,w1,w2,w3);

    R = [e11 e12 e13;
         e21 e22 e23;
         e31 e32 e33];

    S = [ 0   -w3  w2;
          w3   0   -w1;
         -w2   w1   0];

    Rdot = S*R;

    zdot = [w1; w2; w3; wdots(1); wdots(2); wdots(3); 
            Rdot(1,1); Rdot(1,2); Rdot(1,3); 
            Rdot(2,1); Rdot(2,2); Rdot(2,3); 
            Rdot(3,1); Rdot(3,2); Rdot(3,3)];
end