clc;
clear all;
close all;

syms x1 x1dot x1ddot real
syms y1 y1dot y1ddot real
syms theta1 theta1dot theta1ddot real

syms x2 x2dot x2ddot real
syms y2 y2dot y2ddot real
syms theta2 theta2dot theta2ddot real

syms x3 x3dot x3ddot real
syms y3 y3dot y3ddot real
syms theta3 theta3dot theta3ddot real

syms m1 m2 m3 Ig1 Ig2 Ig3 g real
syms Rox Roy Rgx Rgy Fex Fey Ffx Ffy real
syms d1 d2 d3 l1 l2 l3 real

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
% aG1 = (rG1O*(theta1dot^2)) + cross(theta1ddot*k,-rG1O);
aG1 = x1ddot*i + y1ddot*j;

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

% aG2_E = (rG2E*(theta2dot^2)) + cross(theta2ddot*k,-rG2E);
% aG2 = aG2_E + aE;
aG2 = (x2ddot*i) + (y2ddot*j);

LMB_link2_LHS = (Ffx*i + Ffy*j) - g*m2*j - (Fex*i + Fey*j);
LMB_link2 = m2*aG2 - LMB_link2_LHS;

% about G2 %
AMB_link2_LHS = cross(rG2E, - (Fex*i + Fey*j)) + cross(rG2F, (Ffx*i + Ffy*j));
Hdot_G2 = Ig2*theta2ddot;

AMB_link2 = Hdot_G2 - dot(AMB_link2_LHS,k);

%% FBD 4: Link 3 %
rG3F = -d3*er3;
rG3G = (l3-d3)*er3;

rEF = l2*er2;
aF_E = (-rEF*(theta2dot^2)) + cross(theta2ddot*k,rEF);
aF = aF_E + aE;

% aG3_F = (rG3F*(theta3dot^2)) + cross(theta3ddot*k, -rG3F);
% aG3 = aG3_F + aF;

aG3 = (x3ddot*i) + (y3ddot*j);

LMB_link3_LHS = -m3*g*j - (Ffx*i + Ffy*j) + (Rgx*i) + (Rgy*j);
LMB_link3 = m3*aG3 - LMB_link3_LHS;

% about G3 %
AMB_link3_LHS = cross(rG3F, -(Ffx*i + Ffy*j)) + cross(rG3G, (Rgx*i) + (Rgy*j));
Hdot_G3 = Ig3*theta3ddot;

AMB_link3 = Hdot_G3 - dot(AMB_link3_LHS,k);

%% Constraints $$

% VO = VO %
constraint1 = (x1ddot*i) + (y1ddot*j) + (d1*(theta1dot^2)*er1) - (d1*theta1ddot*etheta1);

% VE = VE %
constraint2 = (x2ddot*i) + (y2ddot*j) + (l1*(theta1dot^2)*er1) - (l1*theta1ddot*etheta1) + ...
    (d2*(theta2dot^2)*er2) - (d2*theta2ddot*etheta2);

% VF = VF %
constraint3 = (x3ddot*i) + (y3ddot*j) + (l1*(theta1dot^2)*er1) - (l1*theta1ddot*etheta1) + ...
    (l2*(theta2dot^2)*er2) - (l2*theta2ddot*etheta2) + ...
    (d3*(theta3dot^2)*er3) - (d3*theta3ddot*etheta3);

% VG = VG %
constraint4 = ((l3-d3)*theta3ddot*etheta3) - ((l3-d3)*(theta3dot^2)*er3) + ...
    (x3ddot*i) + (y3ddot*j);

eqn1 = dot(LMB_link1,i);
eqn2 = dot(LMB_link1,j);
eqn3 = dot(LMB_link2,i);
eqn4 = dot(LMB_link2,j);
eqn5 = dot(LMB_link3,i);
eqn6 = dot(LMB_link3,j);
eqn7 = AMB_link1;
eqn8 = AMB_link2;
eqn9 = AMB_link3;
eqn10 = dot(constraint1,i);
eqn11 = dot(constraint1,j);
eqn12 = dot(constraint2,i);
eqn13 = dot(constraint2,j);
eqn14 = dot(constraint3,i);
eqn15 = dot(constraint3,j);
eqn16 = dot(constraint4,i);
eqn17 = dot(constraint4,j);

eqn1 = simplify(eqn1);
eqn2 = simplify(eqn2);
eqn3 = simplify(eqn3);
eqn4 = simplify(eqn4);
eqn5 = simplify(eqn5);
eqn6 = simplify(eqn6);
eqn7 = simplify(eqn7);
eqn8 = simplify(eqn8);
eqn9 = simplify(eqn9);
eqn10 = simplify(eqn10);
eqn11 = simplify(eqn11);
eqn12 = simplify(eqn12);
eqn13 = simplify(eqn13);
eqn14 = simplify(eqn14);
eqn15 = simplify(eqn15);
eqn16 = simplify(eqn16);
eqn17 = simplify(eqn17);

[A, b] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4, eqn5, eqn6, eqn7, eqn8, eqn9, eqn10, eqn11, eqn12, eqn13, eqn14, eqn15, eqn16, eqn17], ...
    [theta1ddot, theta2ddot, theta3ddot, x1ddot, y1ddot, x2ddot, y2ddot, x3ddot, y3ddot, Rox, Roy, Rgx, Rgy, Fex, Fey, Ffx, Ffy]);

matlabFunction(A,'File', 'A_matrix', 'Optimize', false);
matlabFunction(b,'File', 'b_matrix', 'Optimize', false);
