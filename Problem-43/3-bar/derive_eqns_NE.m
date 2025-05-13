clc;
clear all;
close all;

syms theta1 theta1dot theta1ddot real
syms theta2 theta2dot theta2ddot real
syms theta3 theta3dot theta3ddot real
syms m1 m2 m3 Ig1 Ig2 Ig3 g real
syms d1 d2 d3 l1 l2 real

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

ag1 =   (-r_g1_o * (theta1dot^2)) + cross(theta1ddot*k,r_g1_o);
ae  =   (-r_e_o  * (theta1dot^2)) + cross(theta1ddot*k,r_e_o);

ag2_e = (-r_g2_e * (theta2dot^2)) + cross(theta2ddot*k,r_g2_e);
ag2 = ae + ag2_e;

af_e = (-r_f_e * (theta2dot^2)) + cross(theta2ddot*k,r_f_e);
ag3_f = (-r_g3_f * (theta3dot^2)) + cross(theta3ddot*k,r_g3_f);
ag3_e = ag3_f + af_e;
ag3 = ae + ag3_e;

% FBD 1: AMB about O
AMB_sys_LHS   = cross(r_g1_o,-m1*g*j) + cross(r_g2_o,-m2*g*j) + cross(r_g3_o, -m3*g*j);

H1dot_o = cross(r_g1_o,m1*ag1)   + (Ig1*theta1ddot*k);
H2dot_o = cross(r_g2_o,m2*ag2)   + (Ig2*theta2ddot*k);
H3dot_o = cross(r_g3_o,m3*ag3)   + (Ig3*theta3ddot*k);

Hdot_o = H1dot_o + H2dot_o + H3dot_o;

AMB_sys = Hdot_o - AMB_sys_LHS;

% FBD 4: AMB about F
AMB_link3_LHS = cross(r_g3_f,-m3*g*j);
Hdot_f  = cross(r_g3_f,m3*ag3) + (Ig3*theta3ddot*k);

AMB_link3 = Hdot_f - AMB_link3_LHS;

% FBD 6: AMB about E
AMB_link23_LHS = cross(r_g2_e,-m2*g*j) + cross(r_g3_e,-m3*g*j);
Hdot_e  = cross(r_g2_e,m2*ag2) + (Ig2*theta2ddot*k)+...
          cross(r_g3_e,m3*ag3) + (Ig3*theta3ddot*k);

AMB_link23 = Hdot_e - AMB_link23_LHS;

eqn1 = dot(AMB_sys,k);
eqn2 = dot(AMB_link3,k);
eqn3 = dot(AMB_link23,k);

[theta1ddot, theta2ddot, theta3ddot] = solve([eqn1, eqn2, eqn3],[theta1ddot, theta2ddot, theta3ddot]);

theta1ddot = simplify(theta1ddot);
theta2ddot = simplify(theta2ddot);
theta3ddot = simplify(theta3ddot);

matlabFunction(theta1ddot,'File', 'theta1ddot_fn', 'Optimize', false);
matlabFunction(theta2ddot,'File', 'theta2ddot_fn', 'Optimize', false);
matlabFunction(theta3ddot,'File', 'theta3ddot_fn', 'Optimize', false);