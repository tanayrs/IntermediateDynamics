clc;
clear all;

syms x1 x2 real
syms x1dot x2dot real
syms x1ddot x2ddot real
syms m1 m2 L T g F real

r = [x1; x1];
v = [x1dot; x2dot];
a = [x1ddot; x2ddot];

LMB_m1 = T - m1*x1ddot;
LMB_m2 = F - T - m2*x2ddot;

eqn1 = LMB_m1;
eqn2 = LMB_m2;

constraint = (x2-x1) - L;

constraint_diff = jacobian(constraint,[x1;x2]) ...
    * [x1dot; x2dot];
constraint_diff = simplify(constraint_diff);

constraint_ddiff = jacobian(constraint_diff,[x1; x2; x1dot; x2dot]) ...
    * [x1dot; x2dot; x1ddot; x2ddot];
constraint_ddiff = simplify(constraint_ddiff);

eqns = [eqn1;
    eqn2;
    constraint_ddiff];

vars = [x1ddot; x2ddot; T];

[A, b] = equationsToMatrix(eqns,vars);

matlabFunction(A,'File','A_matrix');
matlabFunction(b,'File','B_matrix');