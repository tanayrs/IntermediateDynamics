function equilibria = find_equilibria(p, initial_guesses)
    options = optimoptions('fmincon', 'Display', 'off', 'TolFun', 1e-6);
    equilibria = [];
    
    for i = 1:size(initial_guesses, 1)
        r0_guess = initial_guesses(i, :)'; % Column vector
        eq_point = fsolve(@(r) equilibrium_conditions(r, p), r0_guess, options);
        
        % Store equilibrium if unique (avoid duplicates)
        if isempty(equilibria) || ~ismembertol(eq_point', equilibria, 1e-3, 'ByRows', true)
            equilibria = [equilibria; eq_point']; %#ok<AGROW>
        end
    end
end



