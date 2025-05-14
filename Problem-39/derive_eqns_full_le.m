clc;
clear all;
close all;

syms theta thetadot thetaddot real
syms x xdot xddot real
syms y ydot yddot real
syms phi1 phi2 real
syms F1 F2 real
syms m Ig real
syms d1 d2 real

i = [1; 0; 0];
j = [0; 1; 0];
k = [0; 0; 1];

lambda_hat = (cos(theta)*i) + (sin(theta)*j);
n_hat = -(sin(theta)*i) + (cos(theta)*j);

s1_hat = (cos(phi1)*lambda_hat) + (sin(phi1)*n_hat);
s2_hat = (cos(phi2)*lambda_hat) + (sin(phi2)*n_hat);

f1_hat = -(sin(phi1)*lambda_hat) + (cos(phi1)*n_hat);
f2_hat = -(sin(phi2)*lambda_hat) + (cos(phi2)*n_hat);

V = xdot*i + ydot*j;

Ek = (0.5*m*dot(V,V)) + (0.5*Ig*(thetadot^2));
Ep = 0;

L = Ek - Ep;

doL_doqdot = jacobian(L,[xdot,ydot,thetadot]);
d_dt = jacobian(doL_doqdot,[x,y,theta,xdot,ydot,thetadot]) * [xdot; ydot; thetadot; xddot; yddot; thetaddot];

doL_doq = jacobian(L,[x,y,theta])';

Qx = -(F1*sin(theta+phi1))-(F2*sin(theta+phi2));
Qy = (F1*cos(theta+phi1))+(F2*cos(theta+phi2));
Qtheta = (F1*d1)+(F2*d2);
Qi = [Qx; Qy; Qtheta];

eqns = d_dt - doL_doq - Qi;

V1 = (xdot*i) + (ydot*j) + cross(thetadot*k,-d1*lambda_hat);
V2 = (xdot*i) + (ydot*j) + cross(thetadot*k,d2*lambda_hat);

constraint1 = dot(V1,f1_hat);
constraint1 = jacobian(constraint1,[x,y,theta,xdot,ydot,thetadot])*[xdot; ydot; thetadot; xddot; yddot; thetaddot];
constraint2 = dot(V2,f2_hat);
constraint2 = jacobian(constraint2,[x,y,theta,xdot,ydot,thetadot])*[xdot; ydot; thetadot; xddot; yddot; thetaddot];

eqn1 = eqns(1);
eqn2 = eqns(2);
eqn3 = eqns(3);

[A,b] = equationsToMatrix([eqn1,eqn2,eqn3,constraint1,constraint2],[xddot,yddot,thetaddot,F1,F2]);

matlabFunction(A,'File', 'A_fn_le','Optimize',false);
matlabFunction(b,'File', 'b_fn_le','Optimize',false);