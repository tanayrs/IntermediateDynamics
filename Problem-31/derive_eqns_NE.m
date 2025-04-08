clc;
clear all;
close all;

syms theta1 theta1dot theta1ddot real
syms theta2 theta2dot theta2ddot real
syms m1 m2 Ig1 Ig2 g real
syms d1 d2 l1 real

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

ag1 =   (-r_g1_o * (theta1dot^2)) + cross(theta1ddot*k,r_g1_o);
ae =    (-r_e_o  * (theta1dot^2)) + cross(theta1ddot*k,r_e_o);
ag2_e = (-r_g2_e * (theta2dot^2)) + cross(theta2ddot*k,r_g2_e);
ag2 = ae + ag2_e;

AMB_sys_LHS   = cross(r_g1_o,-m1*g*j) + cross(r_g2_o,-m2*g*j);
AMB_link2_LHS = cross(r_g2_e,-m2*g*j);

H1dot_o = cross(r_g1_o,m1*ag1)   + (Ig1*theta1ddot*k);
H2dot_o = cross(r_g2_o,m2*ag2)   + (Ig2*theta2ddot*k);
Hdot_e  = cross(r_g2_e,m2*ag2) + (Ig2*theta2ddot*k);

Hdot_o = H1dot_o + H2dot_o;

AMB_sys = Hdot_o - AMB_sys_LHS;
AMB_link2 = Hdot_e - AMB_link2_LHS;

eqn1 = dot(AMB_sys,k);
eqn2 = dot(AMB_link2,k);

[theta1ddot, theta2ddot] = solve([eqn1, eqn2],[theta1ddot, theta2ddot]);

theta1ddot = simplify(theta1ddot);
theta2ddot = simplify(theta2ddot);

matlabFunction(theta1ddot,'File', 'theta1ddot_fn', 'Optimize', false);
matlabFunction(theta2ddot,'File', 'theta2ddot_fn', 'Optimize', false);