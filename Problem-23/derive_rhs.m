clc;
clear all;

syms x y real
syms xdot ydot real
syms xddot yddot real
syms m L T g real

r = [x; y];
v = [xdot; ydot];
a = [xddot; yddot];

i_hat = [1; 0];
j_hat = [0; 1];
lambda_hat = r/norm(r);

LMB_m = T*(-lambda_hat) - m*a - m*g*j_hat;

eqn1 = LMB_m(1); % dot(LMB_m,i_hat);
eqn2 = LMB_m(2);

constraint = dot(r,r) - (L^2); % L^2 is a constant if L is a constant

constraint_diff = jacobian(constraint,[x;y]) ...
    * [xdot; ydot];
constraint_diff = simplify(constraint_diff);

constraint_ddiff = jacobian(constraint_diff,[x; y; xdot; ydot]) ...
    * [xdot; ydot; xddot; yddot];
constraint_ddiff = simplify(constraint_ddiff);

eqns = [eqn1;
    eqn2;
    constraint_ddiff];

vars = [xddot; yddot; T];

[A, b] = equationsToMatrix(eqns,vars);

matlabFunction(A,'File','A_matrix');
matlabFunction(b,'File','B_matrix');