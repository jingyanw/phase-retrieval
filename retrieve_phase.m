function [ E_guess,errors ] = retrieve_phase(Es, z, init_phase, lambda, dx, epsilon, iterations, type)
%   Retrieves phase using 
%   Detailed explanation goes here
    intensities = abs(Es) .^2;
    E0 = Es(1);
    I0 = intensities(:,:,1);
    E_guess = sqrt(I0) .* exp(1i*init_phase);
    errors = zeros(1, iterations);
    total = angle(E0).^2;
    total = sum(total(:));
    for i = 1 : iterations
        diff = (angle(E0) - angle(E_guess)).^2;
        error = sum(diff(:));
        error = error / total;
        errors(i) =error;
        if error <= epsilon
            errors = errors(1 : i);
            break
        else
            E_guess = update(z, E_guess, intensities, lambda, dx, type);
        end
    end
    plot(errors);
end

