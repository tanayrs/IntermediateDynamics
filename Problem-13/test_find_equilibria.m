% Test script
function test_find_equilibria()
    % Define parameters
    p.m = 1; p.ka = 1; p.kb = 1; p.la = 0; p.lb = 0; p.g = 10;
    p.ca = 1; p.cb = 1; p.ra = [0; 0]; p.rb = [1; 0];
    

    % Display results
    disp('Equilibrium points:');
    disp(equilibria);
end