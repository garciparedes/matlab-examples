%{

  Universits: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: stratified-sampling/exercise-02.m

%}
clear;

addpath(genpath('./../utils/'));


DATA = load('../../data/campag.mat').datos;

U_1 = DATA(DATA(:,1) == 1, 2:9);
U_2 = DATA(DATA(:,1) == 2, 2:9);
U_3 = DATA(DATA(:,1) == 0, 2:9);
U = {U_1, U_2, U_3};

N_h = [size(U_1, 1), size(U_2, 1), size(U_3, 1)];
N = sum(N_h);
W_h = N_h ./ N;


%{
  1)  Determinar el tamaño de muestra necesario para estimar la proporción P de
    insectos para los que Y4 (FORAMEN)<3750 (datos campag2.mat) si se desea
    cometer un error de estimación inferior a 0.1 con una confianza del 95%
    (probar distintos errores de estimación para ver como cambian los tamaños
    de la muestra).
%}

P_h = [0.5, 0.5, 0.5];

var_h = P_h .* (1 .- P_h);

B = 0.1;
k = norminv(1 - (1 - 0.95) / 2);

n_h = ceil(sum(W_h .* sqrt(var_h)) .* (W_h .* sqrt(var_h)) ./ (sum(W_h .* var_h)./N + B ^ 2 / k ^ 2))
n = sum(n_h);
f_h = n_h ./ N_h;
w_h = n_h ./ n;

i_1 = mas(N_h(1),n_h(1));
i_2 = mas(N_h(2),n_h(2));
i_3 = mas(N_h(3),n_h(3));

s_1 = U_1(i_1, :);
s_2 = U_2(i_2, :);
s_3 = U_3(i_3, :);


P_h_est = [mean(s_1(:,4) < 3750), mean(s_2(:,4) < 3750), mean(s_3(:,4) < 3750)];

P_est = sum(W_h .* P_h_est)
P_est_var = sum((P_h_est .* (1 .- P_h_est) .* (1 .- f_h) .* W_h .^ 2) ./ (n_h .- 1));
P_est_std = sqrt(P_est_var);
P_est_bound = k * P_est_std;
P_est_ic = [P_est - P_est_bound, P_est + P_est_bound]

%{
  2)  Utilizar los datos del apartado i) como una muestra piloto con objeto de
    determinar el tamaño de muestra necesario si se desea reducir un 10% el
    error de estimación de P cometido en ese mismo apartado, con una confianza
    del 95%.
%}

B = 0.9 * P_est_std;
k = norminv(1 - (1 - 0.95) / 2);

n_new = ceil(sum(P_h_est .* (1 .- P_h_est) .* (N_h ./ (N_h .- 1)) .* (W_h .^ 2 ./ w_h)) ./ (B^2./k^2 + sum(P_h_est .* (1 .- P_h_est) .* (N_h ./ (N_h .- 1)) .* (W_h./ N))))

n_h_new = ceil(n_new .* (N_h .* sqrt(P_est_var)) ./ sum(N_h .* sqrt(P_est_var)))
f_h_new = n_h_new ./ N_h;

i_1_new = mas(N_h(1),n_h_new(1));
i_2_new = mas(N_h(2),n_h_new(2));
i_3_new = mas(N_h(3),n_h_new(3));

s_1_new = U_1(i_1_new, :);
s_2_new = U_2(i_2_new, :);
s_3_new = U_3(i_3_new, :);
s_new = {s_1_new, s_2_new, s_3_new};

P_h_est_new = [mean(s_1_new(:,4) < 3750), mean(s_2_new(:,4) < 3750), mean(s_3_new(:,4) < 3750)];

P_est_new = sum(W_h .* P_h_est_new)
P_est_var_new = sum((P_est_new .* (1 .- P_est_new) .* (1 .- f_h_new) .* W_h .^ 2) ./ (n_h_new .- 1));
P_est_std_new = sqrt(P_est_var_new);
P_est_bound_new = k * P_est_std_new;
P_est_ic_new = [P_est_new - P_est_bound_new, P_est_new + P_est_bound_new]

%{
  3) Con la muestra determinada en el apartado ii) estimar el valor medio de
  la variable Y1 (M1LEFT).
%}

mu_est = sum([mean(s_1_new(:,1)), mean(s_2_new(:,1)), mean(s_3_new(:,1))] .* N_h) / N
mu_est_var = sum(W_h .^ 2 .* (1 .- f_h_new) .* [std(s_1_new(:,1)), std(s_2_new(:,1)), std(s_3_new(:,1))] .^ 2 ./ n_h_new);
mu_est_std = sqrt(mu_est_var);
mu_est_bound = k * mu_est_std;
mu_est_ic = [mu_est - mu_est_bound, mu_est + mu_est_bound]

p = sum([mean(U_1(:,4) < 3750), mean(U_2(:,4) < 3750), mean(U_3(:,4) < 3750)] .* W_h)
mu = sum([mean(U_1(:,1)), mean(U_2(:,1)), mean(U_3(:,1))] .* W_h)
