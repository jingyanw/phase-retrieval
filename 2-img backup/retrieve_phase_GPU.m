function [ E_guess,errors ] = retrieve_phase_GPU(E0, E1, z, init_phase, lambda, dx, epsilon, iterations)
%   Retrieves phase using 
%   Detailed explanation goes here
    E0 = gpuArray(E0);
    E1 = gpuArray(E1);
    I0 = abs(E0).^2;
    I1 = abs(E1).^2;
    E_guess = sqrt(I0) .* exp(1i*init_phase);
    errors = gpuArray(zeros(1, iterations));
    total = angle(E0).^2;
    total = sum(total(:));
    wb = waitbar(1/iterations,['Analysing Data']);
    for i = 1 : iterations
        waitbar(i/iterations,wb);
        diff = (angle(E0) - angle(E_guess)).^2;
        error = sum(diff(:));
        error = error / total;
        errors(i) =error;
        if error <= epsilon
            errors = errors(1 : i);
            break
        else
            [E_guess, E1_guess] = update(z, E_guess, I0, I1, lambda, dx);
        end
    end
    close(wb);
    plot(errors);
    E0=gather(E0);
    E1=gather(E1);
    E_guess=gather(E_guess);
    errors=gather(errors);
end


