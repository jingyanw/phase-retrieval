function [ e0_update ] = update( z, e_guess, intensities, lambda, dx, type)
% Do one round of iteration
% Recover the phase of i0

nx = size(i0, 1);
num = size(z, 2) - 1;
i0 = intensities(1);
% Method: mean
if strcmp(type, 'mean')
    update = zeros(nx, nx, num - 1);
    for i = 2 : num
        z = z(i);
        i1 = intensities(i);
        ip1 = fresnelprop(e_guess,lambda,z,dx, nx * 2); % propagate to the out-of focus z
        e1_update = sqrt(i1) .* (ip1 ./ abs(ip1));
        %back-propagate
        ip0 = fresnelprop(e1_update, lambda, -z, dx, nx * 2);
        e0_update = sqrt(i0) .* (ip0 ./ abs(ip0));
        update(i - 1) = e0_update
    end
    
    e0_update = e_guess;
    for i = 1 : num - 1
        e0_update = e0_update + update(:,:,i) / (num - 1);
    end
end


if strcmp(type, 'sequential')
end

if strcmp(type, 'horseshoe')
end
end

% The other thing to is to back-propagate, cut off negative values, and
% propagate.