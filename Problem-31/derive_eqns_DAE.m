clc;
clear all;
close all;

syms theta1 theta1dot theta1ddot real
syms theta2 theta2dot theta2ddot real
syms Fx Fy Rx Ry real
syms m1 m2 Ig1 Ig2 g real
syms d1 d2 l1 real

% Few things:
% --> State is: [theta1, theta2, theta1dot, theta2dot]
% --> Unknowns are: theta1ddot, theta2ddot, Fx, Fy, Rx, Ry
% --> Equations we get are: LMB on Link 1 (2), LMB on Link 2 (2), AMB sys
%     (1) and AMB e (1). Total 6.

i = [1; 0; 0];
j = [0; 1; 0];
k = [0; 0; 1];

er1 = (sin(theta1)*i) - (cos(theta1)*j);
etheta1 = cross(k,er1);

er2 = (sin(theta2)*i) - (cos(theta2)*j);
etheta2 = cross(k,er2);

rG1O = -d1*er1;
rG1E = (l1-d1)*er1;
rG2E = -d2*er2;

rOG2 = (l1*er1) + (d2*er2);

aG1 = (-d1*(theta1dot^2)*er1) + (d1*theta1ddot*etheta1);
aG2 = (-l1*(theta1dot^2)*er1) + (l1*theta1ddot*etheta1) + ...
      (-d2*(theta2dot^2)*er2) + (d2*theta2ddot*etheta2);

LMB_link1_LHS = (Fx*i) + (Fy*j) + (-m1*g*j) + (Rx*i) + (Ry*j);
LMB_link2_LHS = - (Fx*i) - (Fy*j) + (-m2*g*j);

LMB_link1 = (m1*aG1) - LMB_link1_LHS;
LMB_link2 = (m2*aG2) - LMB_link2_LHS;

AMB_link1_LHS = cross(rG1O,(Rx*i + Ry*j)) + cross(rG1E,(Fx*i)+(Fy*j));
AMB_link2_LHS = cross(rG2E,-(Fx*i)-(Fy*j));

AMB_link1 = (Ig1*theta1ddot*k) - AMB_link1_LHS;
AMB_link2 = (Ig2*theta2ddot*k) - AMB_link2_LHS;

eqn1 = dot(LMB_link1,i);
eqn2 = dot(LMB_link1,j);
eqn3 = dot(LMB_link2,i);
eqn4 = dot(LMB_link2,j);
eqn5 = dot(AMB_link1,k);
eqn6 = dot(AMB_link2,k);

[A, b] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4, eqn5, eqn6], ...
    [theta1ddot, theta2ddot, Fx, Fy, Rx, Ry]);

matlabFunction(A,'File', 'A_matrix', 'Optimize', false);
matlabFunction(b,'File', 'b_matrix', 'Optimize', false);