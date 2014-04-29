load('data/guyobj.mat');
E0 = Obj;
%z = [0, 1e-3, 10e-3, 100e-3];\
z = [0, 100e-3];
epsilon = 0.0001;
lambda = 500e-9;
dx = 10e-6;
iterations = 100;
% 'sequential', 'mean', 'horseshoe'
update_method = 'horseshoe';
Es = genInput(Obj,z, lambda, dx);
figure(3);
[E_guess,errors] = retrieve_phase(Es,z,zeros(size(Obj,1),size(Obj,2)), lambda, dx, epsilon, iterations, update_method);
figure(4);
imshow(angle(E_guess));