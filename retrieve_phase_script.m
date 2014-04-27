load('data/guyobj.mat');
E0 = Obj;
z = [0, 1e-3, 10e-3, 100e-3];
epsilon = 0.0001;
lambda = 500e-9;
dx = 10e-6;
iterations = 100;
[stack, intensities] = genInput(Obj,z, lambda, dx);
figure(3)
[E_guess,errors] = retrieve_phase(Obj,E1,z,zeros(size(Obj,1),size(Obj,2)), lambda, dx, epsilon, iterations);
figure(4)
imshow(abs(E_guess));
figure(5);
imshow(angle(E_guess));