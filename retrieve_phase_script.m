load('data/guyobj.mat');
E0 = Obj;
z = 1e-3;
epsilon = 0;
iterations = 100;
[E1,I0,I1] = genIntensities(Obj,[z]);
[E_guess,errors] = retrieve_phase(Obj,E1,z,zeros(512,512),0,100);