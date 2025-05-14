clc;
clear all;
close all;

syms xg xgdot xgddot real;
syms yg ygdot ygddot real;
syms theta thetadot thetaddot real;
syms phi1 phi2 real;
syms d1 d2 m I F1 F2 real;


i = [1; 0; 0];
j = [0; 1; 0];
k = [0; 0; 1];

lambda_hat = cos(theta)*i + sin(theta)*j;
n_hat = -sin(theta)*i + cos(theta)*j;

s1_hat = cos(phi1)*lambda_hat + sin(phi1)*n_hat;
s2_hat = cos(phi2)*lambda_hat + sin(phi2)*n_hat;

f1_hat = cross(k,s1_hat);
f2_hat = cross(k,s2_hat);

LMB_lhs = F1*f1_hat + F2*f2_hat;
LMB = (m*(xgddot*i + ygddot*j)) - LMB_lhs;

AMB_lhs = cross(-d1*lambda_hat,F1*f1_hat) + cross(d1*lambda_hat,F2*f2_hat);
AMB = (I*thetaddot*k) - AMB_lhs;

Vc = xgdot*i + ygdot*j + cross(thetadot*k, -d1*lambda_hat);
Vd = xgdot*i + ygdot*j + cross(thetadot*k, d2*lambda_hat);

constraint1 = jacobian(dot(Vc,f1_hat),[xg, yg, xgdot,ygdot,theta,thetadot])*[xgdot, ygdot, xgddot,ygddot,thetadot,thetaddot]';
constraint2 = jacobian(dot(Vd,f2_hat),[xg, yg, xgdot,ygdot,theta,thetadot])*[xgdot, ygdot, xgddot,ygddot,thetadot,thetaddot]';

eqn1 = dot(LMB,i);
eqn2 = dot(LMB,j);
eqn3 = dot(AMB,k);
eqn4 = constraint1;
eqn5 = constraint2;

[A,b] = equationsToMatrix([eqn1,eqn2,eqn3,eqn4,eqn5],[xgddot,ygddot,thetaddot,F1,F2]);

matlabFunction(A,'File','A_fn');
matlabFunction(b,'File','b_fn');