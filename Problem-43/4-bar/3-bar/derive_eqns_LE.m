clc;
clear all;
close all;

syms theta1 theta1dot theta1ddot real
syms theta2 theta2dot theta2ddot real
syms theta3 theta3dot theta3ddot real
syms Fx Fy R12x R12y R23x R23y real
syms m1 m2 m3 Ig1 Ig2 Ig3 g real
syms d1 d2 d3 l1 l2 real

% Few things:
% --> Minimal Co-Ordinates are: theta1, theta2

i = [1; 0; 0];
j = [0; 1; 0];
k = [0; 0; 1];

er1 = (sin(theta1)*i) - (cos(theta1)*j);
etheta1 = cross(k,er1);

er2 = (sin(theta2)*i) - (cos(theta2)*j);
etheta2 = cross(k,er2);

er3 = (sin(theta3)*i) - (cos(theta3)*j);
etheta3 = cross(k,er3);

r_g1_o = d1*er1;

r_e_o = l1*er1;
r_g2_e = d2*er2;
r_g2_o = r_e_o + r_g2_e;

r_f_e = l2*er2;

r_g3_f = d3*er3;
r_g3_e = r_f_e + r_g3_f;
r_g3_o = r_g3_e + r_e_o;

v1 = d1*theta1dot*etheta1;
v2 = (l1*theta1dot*etheta1) + (d2*theta2dot*etheta2);
v3 = (l1*theta1dot*etheta1) + (l2*theta2dot*etheta2) + (d3*theta3dot*etheta3);

Ek = (0.5*m1*dot(v1,v1)) + (0.5*m2*dot(v2,v2)) + (0.5*m3*dot(v3,v3)) + ...
     (0.5*Ig1*(theta1dot^2)) + (0.5*Ig2*(theta2dot^2)) + (0.5*Ig3*(theta3dot^2));

Ep = (m1*g*r_g1_o(2)) + (m2*g*r_g2_o(2)) + (m3*g*r_g3_o(2));

L = Ek - Ep;

doL_doqdot = jacobian(L,[theta1dot; theta2dot; theta3dot]);
d_dt = jacobian(doL_doqdot,[theta1; theta2; theta3; theta1dot; theta2dot; theta3dot]) * ...
    [theta1dot; theta2dot; theta3dot; theta1ddot; theta2ddot; theta3ddot];

d_dt = simplify(d_dt);

doL_doq = jacobian(L,[theta1; theta2; theta3]);

eqn1 = d_dt(1) - doL_doq(1);
eqn2 = d_dt(2) - doL_doq(2);
eqn3 = d_dt(3) - doL_doq(3);

[A, b]  = equationsToMatrix([eqn1, eqn2, eqn3], [theta1ddot, theta2ddot, theta3ddot]);

w = A\b;

w = simplify(w);

matlabFunction(w,'File',"alphas_fn",'Optimize',false);