function [ e0_update, e1_update ] = update( z, e0, i0, i1)
% Do one round of iteration
% Recover the phase of i0

%phase substitution
lambda = 500e-9;
dx = 10e-6;
nx = size(i0, 1);

ip1 = fresnelprop(e0,lambda,z,dx, nx * 2); % propagate z0 to z1
e1_update = i1 .* (ip1 ./ abs(ip1));
%back-propagate
ip0 = fresnelprop(e1_update, -z, dx ,nx * 2);
e0_update = i0 .* (ip0 ./ abs(ip0));
end

% The other thing to is to back-propagate, cut off negative values, and
% propagate.