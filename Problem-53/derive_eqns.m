syms I1 I2 I3 real
syms w1 w2 w3 real
syms w1dot w2dot w3dot real
syms e11 e12 e13 e21 e22 e23 e31 e32 e33 real

I = [I1 0  0  ;
     0  I2 0  ;
     0  0  I3];

w = [w1; w2; w3];
wdot = [w1dot; w2dot; w3dot];

eqns = I*wdot + cross(w,I*w);

eqn1 = eqns(1);
eqn2 = eqns(2);
eqn3 = eqns(3);

[A,b] = equationsToMatrix([eqn1,eqn2,eqn3],[w1dot, w2dot, w3dot])

wdots = A\b

matlabFunction(wdots,'File', 'wdots_fn', 'Optimize', false);

R = [e11 e12 e13;
     e21 e22 e23;
     e31 e32 e33];

S = [ 0   -w3  w2;
      w1   0   -w1;
     -w2   w3   0];

Rdot = S*R;