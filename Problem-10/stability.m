clear all;

disp(' ');
disp('********************************');

p.rA = [-3; 0]; p.rB = [3; 0];
p.kA = 5; p.LA = 5; p.cA = 1;
p.kB = 5; p.LB = 5; p.cB = 1;
p.m = 1; p.g = 0; p.c = 0.2;

rhs = @(t,z) myrhs(z,t,p);

% Root Finding
nguesses = 10;
myroots = zeros(4,nguesses^2);
goodroots = zeros(nguesses^2, 1);
i = 0;

options = optimoptions('fsolve', 'FunctionTolerance',1e-30, 'OptimalityTolerance',1e-8, 'MaxFunctionEvaluations',10000, 'MaxIterations',10000, 'Disp', 'off', 'Algorithm', 'levenberg-marquardt');

for xguess = linspace(-11,11,nguesses)
    for yguess = linspace(-11,11,nguesses)
        i = i+1
        [myroot, fval, exitflag] = fsolve(rhs,[xguess; yguess; 0; 0], options);
        if norm(fval) > 1e-3
        else
            goodroots(i) = 1;
        end
        myroots(:,i) = myroot;
    end
end

goodroots = logical(goodroots);

myroots = myroots(:,goodroots);
myroots = round(myroots,6);
myroots = unique(myroots','rows')';

disp(['Numver of converged optimizations is ', num2str(sum(goodroots))]);

nroots = length(myroot(1,:));

disp(['The ' num2str(nroots) ' equilibrium point have these [x; y; vx; vy] values: '])
disp(' (Each column is one root)')
disp(myroots)