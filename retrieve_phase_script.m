load('data/guyobj.mat');
E0 = Obj;
z1 = [0, 20e-3, 40e-3, 60e-3, 80e-3, 100e-3, 120e-3];
z2 = [0, 30e-3, 60e-3, 90e-3, 120e-3];
z3 = [0, 60e-3, 120e-3];
z4 = [0, 120e-3];
epsilon = 0.0001;
lambda = 500e-9;
dx = 10e-6;
iterations = [10, 50, 100];
% update methods: 'sequential', 'mean', 'horseshoe'

for i = 1 : 4    

if i == 1
    z = z1;
elseif i == 2
    z = z2;
elseif i == 3
    z = z3;
else
    z = z4;
end
    
%noise free measurements

%mean no noise
update_method = 'mean';
Es = genInput(Obj,z, lambda, dx);
retrieve_phase(Es,z,zeros(size(Obj,1),size(Obj,2)), lambda, dx, epsilon, iterations, update_method, false);

%sequential no noise
update_method = 'sequential';
Es = genInput(Obj,z, lambda, dx);
retrieve_phase(Es,z,zeros(size(Obj,1),size(Obj,2)), lambda, dx, epsilon, iterations, update_method, false);

%horseshoe no noise
update_method = 'horseshoe';
Es = genInput(Obj,z, lambda, dx);
retrieve_phase(Es,z,zeros(size(Obj,1),size(Obj,2)), lambda, dx, epsilon, iterations, update_method, false);

%noisy measurements

%mean with Gaussian noise
update_method = 'mean';
Es = genInput(Obj,z, lambda, dx);
retrieve_phase(Es,z,zeros(size(Obj,1),size(Obj,2)), lambda, dx, epsilon, iterations, update_method, true);

%sequential with Gaussian noise
update_method = 'sequential';
Es = genInput(Obj,z, lambda, dx);
retrieve_phase(Es,z,zeros(size(Obj,1),size(Obj,2)), lambda, dx, epsilon, iterations, update_method, true);

%horseshoe with Gaussian noise
update_method = 'horseshoe';
Es = genInput(Obj,z, lambda, dx);
retrieve_phase(Es,z,zeros(size(Obj,1),size(Obj,2)), lambda, dx, epsilon, iterations, update_method, true);

end

figure();
imshow(angle(E0));
title('Actual Phase Plot');