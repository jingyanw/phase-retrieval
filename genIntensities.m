function [ intensities ] = genIntensities( E0,z )
%UNTITLED outputs intensities of propated images in genInput
%   Detailed explanation goes here
    stack = genInput(E0, z);
    [rows,cols] = size(E0);
    intensities = zeros(rows,cols);
    for i = 1 : num
        intensities(:,:,i) = abs(stack(:,:,i)).^2;
    end
    save('intensities.mat','z');
    save('intensities.mat','intensities');
end