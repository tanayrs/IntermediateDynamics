clc;
clear all;
close all;

syms phi phidot t real
syms m real

er = [cos(phi); -sin(phi); 0];
etheta = [sin(phi); cos(phi); 0];
k = [0; 0; 1];

omega = phidot * k;
theta = pi * (1-cos(t));
thetadot = diff(theta,t) * k;

er2 = (cos(theta)*er) - (sin(theta)*etheta);
etheta2 = (sin(theta)*er) + (cos(theta)*etheta);

rm1 = 2*etheta;
rm2 = 2*er + 1*er2;
rm3 = -2*etheta;
rm4 = -(2*er + er2);

v1 = cross(omega,rm1);
v2 = cross(omega,2*er) + cross(thetadot,er2);
v3 = cross(omega,rm2);
v4 = cross(omega,-2*er) + cross(thetadot, -er2);

H = cross(rm1,m*v1) + cross(rm2,m*v2) + cross(rm3,m*v3) + cross(rm4, m*v4);

H_k = dot(H, k);

phidot = solve(H_k, phidot)

matlabFunction(phidot,'File',"myphidot",'Optimize',false);