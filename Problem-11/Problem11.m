% RO2102 Dynamics and Simulation %
% Assignment-4; Problem-11 %
% Tanay Srinivasa, 9 Feb 2025 %
% Due Date: 11 Feb 2025 %
% Time Spent on Problem: 1 Hour  %

% clc;
% clear all;
% close all;

set(0, 'DefaultAxesFontSize', 20);

% Parameters
p.k = 100; p.n = (pi/4); p.m = 7;

% Initial Conditions
r0 = [-0.010000000000000; 0]; v0 = [0; -0.002963000000000]; z0 = [r0; v0];

tstart = 0; tend = 100;
tspan = [tstart, tend];

% Define ODE system
rhs = @(t,z) myrhs(t,z,p);

% Solve using ODE45
options = odeset('AbsTol', 1e-9, 'RelTol', 1e-9);
solution = ode45(rhs, tspan, z0, options);
z = solution.y;

% Plot and animate
plot_trajectory(solution, tspan);

%% Root Finding
% myroots = find_roots(rhs);
function myroots = find_roots(rhs)
    error_func = @(r) rootfinder(rhs, [r(1); 0; 0; r(2); r(3)]);
    
    lb = [-inf, -inf, 1];  % Lower bounds (T must be >= 0.1)
    ub = [inf, inf, inf];     % Upper bounds
    
    nguesses = 10;
    myroots = zeros(3,nguesses^2);
    goodroots = zeros(nguesses^2,1);
    i = 0;
    
    options = optimoptions('lsqnonlin', 'FunctionTolerance',1e-30, 'OptimalityTolerance',1e-8, 'MaxFunctionEvaluations',10000, 'MaxIterations',10000, 'Disp','off');
    
    for xguess = linspace(-11,11,nguesses)
        for vguess = linspace(-11,11,nguesses)
            for tguess = linspace(0,20,nguesses)
                i = i+1;
            
                [myroot, resnorm, ~, exitflag] = lsqnonlin(error_func, [xguess; vguess; tguess], lb, ub, options); 
                if resnorm > 1e-3 || exitflag < 1
                    % disp('Tanay says; LSQNONLIN is not happy. We want resnorm to be close to zeros.'); 
                    % resnorm
                else  
                    goodroots(i) = 1;
                    i
                end
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
    disp(['The ' num2str(nroots) ' equilibrium points have these [x; y; vx; vy] values:']);
    % disp(' (Each column is one root)')
    disp(myroots)
end

% Function defining the equations of motion
function zdot = myrhs(t, z, p)
    n = p.n; m = p.m; k = p.k;

    r = z(1:2);
    v = z(3:4);
    
    r_norm = norm(r);
    
    if r_norm ~= 0
        F = -k * (r_norm^n) * (r / r_norm);
    else
        F = 0;
    end
    
    rddot = F / m;
    
    zdot = [v; rddot];
end

% Function to plot trajectory
function plot_trajectory(solution, tspan)
    t = linspace(tspan(1), tspan(2), 1e5);
    z_vals = deval(solution, t);
    r_vals = z_vals(1:2,:);
    
    figure;
    plot(r_vals(1,:), r_vals(2,:), 'LineWidth', 1.5);
    xlabel("x-position (m)", 'FontSize', 20);
    ylabel("y-position (m)", 'FontSize', 20);
    axis equal;
    grid on;
    title("Trajectory of mass");
end

function error = rootfinder(rhs, z0)
    T = z0(end);
    z0 = [z0(1) z0(2) z0(3) z0(4)]';
    options = odeset('AbsTol',1e-3, 'RelTol', 1e-3);
    solution = ode45(rhs, [0 T], z0, options);

    zvals = solution.y;
    z_final = zvals(:,end);
    error = z_final - z0;
end