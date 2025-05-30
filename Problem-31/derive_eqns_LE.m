clc;
clear all;
close all;

syms theta1 theta1dot theta1ddot real
syms theta2 theta2dot theta2ddot real
syms Fx Fy Rx Ry real
syms m1 m2 Ig1 Ig2 g real
syms d1 d2 l1 real

% Few things:
% --> Minimal Co-Ordinates are: theta1, theta2

i = [1; 0; 0];
j = [0; 1; 0];
k = [0; 0; 1];

er1 = (sin(theta1)*i) - (cos(theta1)*j);
etheta1 = cross(k,er1);

er2 = (sin(theta2)*i) - (cos(theta2)*j);
etheta2 = cross(k,er2);

r_g1_o = d1*er1;
r_e_o = l1*er1;
r_g2_e = d2*er2;
r_g2_o = r_e_o + r_g2_e;

v1 = d1*theta1dot*etheta1;
v2 = (l1*theta1dot*etheta1) + (d2*theta2dot*etheta2);

Ek = (0.5*m1*dot(v1,v1)) + (0.5*m2*dot(v2,v2)) + ...
    (0.5*Ig1*(theta1dot^2)) + (0.5*Ig2*(theta2dot^2));

Ep = (m1*g*r_g1_o(2)) + (m2*g*r_g2_o(2));

L = Ek - Ep;

doL_doqdot = jacobian(L,[theta1dot; theta2dot]);
d_dt = jacobian(doL_doqdot,[theta1; theta2; theta1dot; theta2dot]) * ...
    [theta1dot; theta2dot; theta1ddot; theta2ddot];

d_dt = simplify(d_dt);

doL_doq = jacobian(L,[theta1; theta2]);

eqn1 = d_dt(1) - doL_doq(1);
eqn2 = d_dt(2) - doL_doq(2);

[A, b]  = equationsToMatrix([eqn1, eqn2], [theta1ddot, theta2ddot]);

w = A\b;

w = simplify(w);

matlabFunction(w,'File',"alphas_fn",'Optimize',false);