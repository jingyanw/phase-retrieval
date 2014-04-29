tic
load('data/guyobj.mat');
E0 = Obj;
z = 10e-3;
epsilon = 0.001;
lambda = 500e-9;
dx = 10e-6;
iterations = 3000;
[E1,I0,I1] = genIntensities(Obj,[z], lambda, dx);
figure(11)
imshow(abs(Obj));
figure(12);
imshow(abs(E1));
figure(13)
[E_guess,errors] = retrieve_phase_GPU(Obj,E1,z,zeros(size(Obj,1),size(Obj,2)), lambda, dx, epsilon, iterations);
figure(14)
imshow(angle(Obj));
figure(15);
imshow(angle(E_guess));
toc