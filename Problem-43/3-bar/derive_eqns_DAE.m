clc;
clear all;
close all;

syms theta1 theta1dot theta1ddot real
syms theta2 theta2dot theta2ddot real
syms theta3 theta3dot theta3ddot real
syms m1 m2 m3 Ig1 Ig2 Ig3 g real
syms Rox Roy Fex Fey Ffx Ffy real
syms d1 d2 d3 l1 l2 real

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

er3 = (sin(theta3)*i) - (cos(theta3)*j);
etheta3 = cross(k,er3);

%% FBD2: Link 1 %%
rG1O = -d1*er1;
rG1E = (l1-d1)*er1;
aG1 = (rG1O*(theta1dot^2)) + cross(theta1ddot*k,-rG1O);

LMB_link1_LHS = (Rox*i + Roy*j) - g*m1*j + (Fex*i + Fey*j);
LMB_link1 = m1*aG1 - LMB_link1_LHS;

% about G1 %
AMB_link1_LHS = cross(rG1O, (Rox*i + Roy*j)) + cross(rG1E,(Fex*i + Fey*j));
Hdot_G1 = Ig1*theta1ddot;

AMB_link1 = Hdot_G1 - dot(AMB_link1_LHS,k);

%% FBD3: Link 2 %%
rG2E = -d2*er2;
rG2F = (l2-d2)*er2;

rOE = l1*er1;
aE = (-rOE*(theta1dot^2)) + cross(theta1ddot*k,rOE);

aG2_E = (rG2E*(theta2dot^2)) + cross(theta2ddot*k,-rG2E);
aG2 = aG2_E + aE;

LMB_link2_LHS = (Ffx*i + Ffy*j) - g*m2*j - (Fex*i + Fey*j);
LMB_link2 = m2*aG2 - LMB_link2_LHS;

% about G2 %
AMB_link2_LHS = cross(rG2E, - (Fex*i + Fey*j)) + cross(rG2F, (Ffx*i + Ffy*j));
Hdot_G2 = Ig2*theta2ddot;

AMB_link2 = Hdot_G2 - dot(AMB_link2_LHS,k);

%% FBD 4: Link 3 %
rG3F = -d3*er3;

rEF = l2*er2;
aF_E = (-rEF*(theta2dot^2)) + cross(theta2ddot*k,rEF);
aF = aF_E + aE;

aG3_F = (rG3F*(theta3dot^2)) + cross(theta3ddot*k, -rG3F);
aG3 = aG3_F + aF;

LMB_link3_LHS = -m3*g*j - (Ffx*i + Ffy*j);
LMB_link3 = m3*aG3 - LMB_link3_LHS;

% about G3 %
AMB_link3_LHS = cross(rG3F, -(Ffx*i + Ffy*j));
Hdot_G3 = Ig3*theta3ddot;

AMB_link3 = Hdot_G3 - dot(AMB_link3_LHS,k);

eqn1 = dot(LMB_link1,i);
eqn2 = dot(LMB_link1,j);
eqn3 = dot(LMB_link2,i);
eqn4 = dot(LMB_link2,j);
eqn5 = dot(LMB_link3,i);
eqn6 = dot(LMB_link3,j);
eqn7 = AMB_link1;
eqn8 = AMB_link2;
eqn9 = AMB_link3;

eqn1 = simplify(eqn1);
eqn2 = simplify(eqn2);
eqn3 = simplify(eqn3);
eqn4 = simplify(eqn4);
eqn5 = simplify(eqn5);
eqn6 = simplify(eqn6);
eqn7 = simplify(eqn7);
eqn8 = simplify(eqn8);
eqn9 = simplify(eqn9);

[A, b] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4, eqn5, eqn6, eqn7, eqn8, eqn9], ...
    [theta1ddot, theta2ddot, theta3ddot, Rox, Roy, Fex, Fey, Ffx, Ffy]);

matlabFunction(A,'File', 'A_matrix', 'Optimize', false);
matlabFunction(b,'File', 'b_matrix', 'Optimize', false);