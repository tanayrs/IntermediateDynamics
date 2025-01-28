function [x_fun, y_fun] = analytical_sol(p, z0)
    syms t;
    m = p.m; g = p.g; c = p.c;
    
    vx0 = z0(3);  % Initial x-velocity
    vy0 = z0(4);  % Initial y-velocity
    
    x_sol = (m / c) * vx0 * (1 - exp(-(c / m) * t));
    y_sol = (m / c) * (vy0 + (m * g / c)) * (1 - exp(-(c / m) * t)) - (m * g * t / c);
    
    % Convert symbolic solutions to numeric functions
    x_fun = matlabFunction(x_sol, 'Vars', t);
    y_fun = matlabFunction(y_sol, 'Vars', t);
end