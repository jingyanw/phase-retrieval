function [ stack,intensities ] = genIntensities( E0,z , lambda, dx)
%UNTITLED outputs intensities of propated images in genInput
%   Detailed explanation goes here
    stack = genInput(E0, z, lambda, dx);
    intensities = abs(stack) .^2;
end