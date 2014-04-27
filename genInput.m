function [ stack, intensities ] = genInput( E0, z , lambda, dx)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    num = size(z, 2);
    nx = size(E0,2);
    stack = zeros(size(E0,1), size(E0,1), nx);
    for i = 1 : num
        dz = z(i);
        [E1,H] = fresnelprop(E0,lambda,dz,dx, nx* 2);
        stack(:,:,num) = E1;
    end
    intensities = abs(stack) .^2;
end

