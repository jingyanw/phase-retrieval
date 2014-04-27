function [ e0_update ] = update( z, e_guess, intensities, lambda, dx, type)

%phase substitution
nx = size(e_guess, 1);

if strcmp(type,'mean') == 1
    %code for mean here
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