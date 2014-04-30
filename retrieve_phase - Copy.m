function [ E_guess,errors ] = retrieve_phase(Es, z, init_phase, lambda, dx, epsilon, iterations, type, hasNoise)
%   Retrieves phase using 
%   Detailed explanation goes here
    Es=gpuArray(Es);
    intensities = abs(Es) .^ 2;
    noise_weight = 0.05 * mean(intensities(:));
    noisy = 'without noise';
    if hasNoise
       for i = 1 : length(z)
       intensities(:,:,i) = abs(Es(:,:,i)) .^2 + noise_weight*randn(size(Es(:,:,1),1), size(Es(:,:,1),2));
       end
       noisy = 'with Gaussian noise';
    end
    E0 = Es(:,:,1);
    I0 = intensities(:,:,1);
    E_guess = sqrt(I0) .* exp(1i*init_phase);
    errors = gpuArray.zeros(1, max(iterations));
    total = angle(E0).^2;
    total = sum(total(:));
    for i = 1 : max(iterations)
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
        if ismember(i, iterations)
            figure();
            imshow(angle(E_guess));
            title(['Reconstructed Phase Plot for ', type, ' with ', num2str(i), ' iterations using ', num2str(length(z)), ' images ', noisy]);
        end
    end
    figure();
    plot(errors);
    title(['Error Plot for ', num2str(max(iterations)), ' iterations for update method ', type, ' using ', num2str(length(z)), ' images ', noisy]);
    xlabel('Iteration Number');
    ylabel('error');
end

