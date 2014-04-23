function [ E_guess,errors ] = retrieve_phase(E0, E1, z, init_phase, epsilon, iterations)
%   Retrieves phase using 
%   Detailed explanation goes here
    I0 = abs(E0).^2;
    I1 = abs(E1).^2;
    E_guess = sqrt(I0) * exp(1i*init_phase);
    errors = zeros(1, iterations);
    for i = 1 : iterations
        diff = (angle(E0) - angle(E_guess)).^2;
        error = sum(diff(:));
        errors(i) =error;
        if error <= epsilon
            errors = errors(1 : i);
            break
        else
            E_guess = update(z, E_guess, I0, I1);
        end
    end
    plot(errors);
end

