% RO2102 Dynamics and Simulation %
% Assignment-4; Problem-12 %
% Tanay Srinivasa, 25 Jan 2025 %
% Due Date: 11 Feb 2025 %
% Time Spent on Problem: 2 Hours  %

clc;
clear all;
close all;

% Plotting options as defined in Homework Guidelines %
set(0,'DefaultAxesFontSize', 20);

% Parameters %
% p.m = 1; p.ka = 50; p.kb = 50; p.la = 5; p.lb = 5; p.g = 0; p.c = .2; 
% p.ca = 1; p.cb = 1; p.ra = [3; 0]; p.rb = [-3; 0]; time_scale = 1;

% Strange set of parameters
p.m = 1; p.ka = 2; p.kb = 5; p.la = 5; p.lb = 7; p.g = 5; p.c = .2; 
p.ca = 0; p.cb = 0; p.ra = [3; 0]; p.rb = [-3; 0]; time_scale = 1;

% Initial Conditions %
tstart = 0; tend = 10; tspan = [tstart, tend];
r0 = [1; 0.001]; v0 = [0; 0];
z0 = [r0; v0];

%% Statics Solution
mystatics = @(z) sum_of_forces(z(1:2),[0;0],p);
options = optimoptions('fsolve', 'FunctionTolerance',1e-30, 'OptimalityTolerance',1e-8, 'MaxFunctionEvaluations',10000, 'MaxIterations',10000, 'Disp','off');
[root, fval, exitflag] = fsolve(mystatics,z0(1:2),options);
if exitflag < 1
    disp('Tanay says: FSOLVE is not happy. We want fval to be close to zeros.');
    fval
end

disp('The x and y equilibrium point is')
disp(root);

%% Dynamics Solution

mydynamics = @(z) sum_of_forces(z(1:2),z(3:4),p);
myrhs = @(t,z) [z(3:4); mydynamics(z)/p.m];

tspan = linspace(0,20,1000);

options = odeset('AbsTol',1e-3, 'RelTol',1e-3);
solution = ode45(myrhs, tspan, z0, options);

zarray = solution.y;
x = zarray(:,1); y = zarray(:,2);
plot(x,y,'*'); axis equal;
shg;

% animate(solution, [tspan(1), tspan(end)], z0, p, time_scale)

%% Equilibrium

rA = [0 ;  0] ;  rB = [3 ; 0];
kA = 5;  LA = 5;  cA = 0  ;
kB = 5;  LB = 5;  cB = 0  ;
m  = 1;  g  = 1;  c  =  .2;

mydynamics = @(z)  ...
                   myzdots(z,rA,rB, kA,LA, cA, kB,LB,cB,m,g,c);

myrhs = @(t,z) mydynamics(z);

nguesses = 10;
myroots = zeros(4,nguesses^2);
goodroots = zeros(nguesses^2,1);
i = 0;

options = optimoptions('fsolve', 'FunctionTolerance', 1e-30, 'OptimalityTolerance',1e-8, 'MaxFunctionEvaluations', 10000,'MaxIterations', 10000,'Disp','off','Algorithm','levenberg-marquardt'); 

for xguess = linspace(-11,11,nguesses)
    for yguess = linspace(-11,11,nguesses)
        i = i+1;
        
        [myroot,fval,exitflag] =fsolve(mydynamics,[xguess;yguess;0;0], options); 
        if norm(fval)>1e-3
            disp('Andy says; FSOLVE is not happy. We want fval to be close to zeros.'); 
            fval,
        else  
            goodroots(i) = 1;
        end
  
        myroots(:,i) = myroot;
  
    end
end

goodroots = logical(goodroots);

myroots = myroots(:,goodroots);
myroots = round(myroots, 6);
myroots = unique(myroots','rows')';

disp(['Number of converged optimizations is ' num2str(sum(goodroots))]);

nroots = length(myroots(1,:));

figure;
plot(myroots(1,:), myroots(2,:), '.', 'MarkerSize',50);
hold on;
axis equal;
grid on;
hold off

disp(['The ' num2str(nroots) ' equilibrium points have these [x; y; vx; vy] values:']);
% disp(' (Each column is one root)')
disp(myroots)

%% Stability Analysis

whichroot = 1;
zstar = myroots(:,whichroot);

h = 1e-4;

J = zeros(4,4);

for i = 1:4
    zperturb = zeros(4,1);
    zperturb(i) = h;

    J(:,i) = (myrhs(0,zstar+zperturb) - myrhs(0,zstar-zperturb))/(2*h);
end

disp('The Jacobian (the linearization matrix is): '); disp(J);

[V,D] = eig(J);

disp('The eigen vector (columns) are: '); disp(V);

disp('The assosciated eigen values are: '); disp(diag(D));
