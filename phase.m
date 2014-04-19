% Phase substitution
% 2 images
% Recover the phase of z0
z0 = imread('');
z1 = imread('');
for iter = 0 : 100
    z_prop_1; % propagate z0
    z1_update = z1 .* (z_prop_1 ./ abs(z_prop_1));
    z_prop_0; % propagate z1_update
    z0_update = z0 .* (z_prop_0 ./ abs(z_prop_0));
end
% The other thing to is to back-propagate, cut off negative values, and
% propagate.