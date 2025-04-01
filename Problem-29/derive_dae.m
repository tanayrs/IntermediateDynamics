clc;
clear all;
close all;

syms y theta thetadot t real
syms xddot yddot thetaddot real
syms N F real
syms m d r omega Ig g real

y = r*sin(omega*t);
ydot = diff(y,t);
yddot_constraint = diff(ydot,t);

xdot = 0;
xddot_constraint = 0;

i = [1; 0; 0];
j = [0; 1; 0];
k = [0; 0; 1];

er = [-sin(theta); cos(theta); 0];
etheta = [-cos(theta); -sin(theta); 0];

aG = xddot*i + yddot*j + (-d*(thetadot^2)*er) + (thetaddot*d*etheta);
rg_o = d*er;

LMB = (-m*g*j) + (N*j) + (-F*i) - (m*aG);
AMB = cross(rg_o, m*aG) + (Ig*thetaddot*k) - cross(rg_o,-m*g*j);

eqn1 = xddot - xddot_constraint;
eqn2 = yddot - yddot_constraint;
eqn3 = dot(LMB, i);
eqn4 = dot(LMB, j);
eqn5 = dot(AMB, k);

[A, b] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4, eqn5], [xddot, yddot, thetaddot, N, F]);

w = A\b;

thetaddot = simplify(simplify(w(3)));

w = simplify(simplify(w));

matlabFunction(A, 'File', 'A_matrix', 'Optimize', false);
matlabFunction(b, 'File', 'B_matrix', 'Optimize', true);