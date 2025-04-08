clc;
clear all;

syms x1 x2 y1 y2 real
syms x1dot y1dot x2dot y2dot real
syms x1ddot y1ddot x2ddot y2ddot real
syms m L T real

r1 = [x1; y1];
r2 = [x2; y2];

v1 = [x1dot; y1dot];
v2 = [x2dot; y2dot];

a1 = [x1ddot; y1ddot];
a2 = [x2ddot; y2ddot];

r = r2 - r1;
v = v2 - v1;

i_hat = [1; 0];
j_hat = [0; 1];
lambda_hat = r/norm(r);

LMB_m1 = T*lambda_hat - m*a1
LMB_m2 = T*(-lambda_hat) - m*a2;

eqn1 = LMB_m1(1); % dot(LMB_m1,i_hat);
eqn2 = LMB_m1(2);
eqn3 = LMB_m2(1);
eqn4 = LMB_m2(2);

constraint = dot(r,r) - (L^2); % L^2 is a constant if L is a constant

constraint_diff = jacobian(constraint,[x1;y1;x2;y2]) ...
    * [x1dot; y1dot; x2dot; y2dot];
constraint_diff = simplify(constraint_diff);

constraint_ddiff = jacobian(constraint_diff,[x1;y1;x2;y2;x1dot; y1dot; x2dot; y2dot]) ...
    * [x1dot; y1dot; x2dot; y2dot; x1ddot; y1ddot; x2ddot; y2ddot];
constraint_ddiff = simplify(constraint_ddiff);

eqns = [eqn1;
    eqn2;
    eqn3;
    eqn4;
    constraint_ddiff]

vars = [x1ddot; y1ddot; x2ddot; y2ddot; T];

[A, b] = equationsToMatrix(eqns,vars);

matlabFunction(A,'File','A_matrix');
matlabFunction(b,'File','B_matrix');
