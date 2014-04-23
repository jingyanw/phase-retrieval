function [ stack ] = genInput( z )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    num = size(z,2);
    nx = 512;
    stack = zeros(nx, nx, num);
    lambda = 500e-9;
    dx = 10e-6;
    E0
    for i = 1 : num
        dz = z(i);
        [E1,H] = fresnelprop(E0,lambda,dz,dx,nx * 2);
        stack(:,:,num) = E1;
    end
end

