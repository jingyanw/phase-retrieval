function [ E1, I0,intensities ] = genIntensities( E0,z , lambda, dx)
%UNTITLED outputs intensities of propated images in genInput
%   Detailed explanation goes here
    stack = genInput(E0, z, lambda, dx);
    E1 = stack(:,:,1);
    [rows,cols] = size(E0);
    I0 = abs(E0).^2;
    intensities = zeros(rows,cols);
    for i = 1 : length(z)
        intensities(:,:,i) = abs(stack(:,:,i)).^2;
    end
    %save('intensities.mat','z');
    %save('intensities.mat','intensities');
end