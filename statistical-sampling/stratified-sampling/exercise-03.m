%{

  Universits: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: stratified-sampling/exercise-03.m

%}
clear;

addpath(genpath('./../utils/'));

DATA = load('../../data/carcel.mat');

P = mean(DATA.todos(:,2))

U_1 = DATA.mod1(:,2);
U_2 = DATA.mod2(:,2);
U_3 = DATA.mod3(:,2);

N_h = [size(U_1,1), size(U_2,1), size(U_3,1)];
N = sum(N_h, 2);

W_h = N_h ./ N;


k = norminv(1 - (1- 0.95)/2);

n = 40;

P_est_naive = [0.5, 0.5, 0.5];
P_est_naive_var = P_est_naive .* (1 .- P_est_naive);


n_h = ceil(n .* N_h ./ sum( N_h ));
f_h = n_h ./ N_h;


%{
  M.A.S en todos los estratos
  Afijación proporcional
%}

i_1_mas = mas(N_h(1), n_h(1));
i_2_mas = mas(N_h(2), n_h(2));
i_3_mas = mas(N_h(3), n_h(3));

s_1_mas = U_1(i_1_mas);
s_2_mas = U_2(i_2_mas);
s_3_mas = U_3(i_3_mas);

P_h_est_mas = [mean(s_1_mas), mean(s_2_mas), mean(s_3_mas)];
P_est_mas = sum(P_h_est_mas .* W_h)

P_est_mas_var = sum(W_h .^ 2 .* (1 .- f_h) .* P_h_est_mas .* (1 .- P_h_est_mas) ./ (n_h .- 1));
P_est_mas_sqrt = sqrt(P_est_mas_var);
P_est_mas_bound = k * P_est_mas_sqrt;
P_es_mast_ic = [P_est_mas - P_est_mas_bound, P_est_mas + P_est_mas_bound]


%{
  M.A.Scon en todos los estratos
  Afijación proporcional
%}

i_1_mascon = mascon(N_h(1), n_h(1));
i_2_mascon = mascon(N_h(2), n_h(2));
i_3_mascon = mascon(N_h(3), n_h(3));

s_1_mascon = U_1(i_1_mascon);
s_2_mascon = U_2(i_2_mascon);
s_3_mascon = U_3(i_3_mascon);

P_h_est_mascon = [mean(s_1_mascon), mean(s_2_mascon), mean(s_3_mascon)];
P_est_mascon = sum(P_h_est_mascon .* W_h)

P_est_mascon_var = sum(W_h .^ 2 .* P_h_est_mascon .* (1 .- P_h_est_mascon) ./ (n_h .- 1));
P_est_mascon_sqrt = sqrt(P_est_mascon_var);
P_est_mascon_bound = k * P_est_mascon_sqrt;
P_est_mascon_ic = [P_est_mascon - P_est_mascon_bound, P_est_mascon + P_est_mascon_bound]



%{
  M.A.S en todos los estratos
  Afijación proporcional
  Reducción error de estimación en 10%
%}
B_mas = 0.9 * P_est_mas_bound;

n_new_mas = ceil(sum(W_h .* P_est_mas .* (1 .- P_est_mas) .* N_h ./ (N_h .- 1)) ./ (B_mas ^ 2 / k ^ 2 + sum(W_h .* P_est_mas .* (1 .- P_est_mas) .* N_h ./ ((N_h .- 1) .* N))))


%{
  M.A.Scon en todos los estratos
  Afijación proporcional
  Reducción error de estimación en 10%
%}

B_mascon = 0.9 * P_est_mascon_bound;
n_new_mascon = ceil(sum(W_h .* P_h_est_mascon .* (1 .- P_h_est_mascon) .* k .^ 2 ./ B_mascon .^ 2) + B_mascon^2 /k^2)
