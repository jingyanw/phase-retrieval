function [ e0_update ] = update( z, e_guess, intensities, lambda, dx, type)
% Do one round of iteration
% Recover the phase of i0

nx = size(i0, 1);
num = size(z, 2) - 1;
i0 = intensities(1);

if strcmp(type,'mean') == 1
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
else if strcmp(type,'sequential') == 1
    %code for sequential here;
    e_scout = e_guess;
    for i = 2 : length(z)
        e_scout = fresnelprop(e_scout, lambda, z(i), dx, nx*2);
        e_scout = sqrt(intensities(i)) .* (e_scout ./ abs(e_scout))
        %back-propagate
        e_scout = fresnelprop(e_scout, lambda, -z(i), dx, nx*2);
        e_scout = sqrt(intensities(1)) .* (e_scout ./ abs(e_scout));
    end
    e0_update = e_scout;
else if strcmp(type,'horseshoe') == 1
    %code for horseshoe here;
    e_pilgrim = e_guess;
    for i = 2 : length(z)
        e_pilgrim = fresnelprop(e_pilgrim, lambda, z(i)-z(i-1), dx, nx*2);
        e_prilgrim = sqrt(intensities(i)) .* (e_pilgrim ./ abs(e_prilgrim));
    end
    %back-propagate
    for i = length(z)-1 : -1 : 1
        e_pilgrim = fresnelprop(e_pilgrim, lambda, z(i)-z(i+1), dx, nx*2);
        e_prilgrim = sqrt(intensities(i)) .* (e_pilgrim ./ abs(e_prilgrim));
    end
    e0_update = e_pilgrim;
else
    printf('Error: invalid update method\n');
    end
end

% The other thing to is to back-propagate, cut off negative values, and
% propagate.