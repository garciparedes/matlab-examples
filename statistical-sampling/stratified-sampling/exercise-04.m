%{

  Universits: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: stratified-sampling/exercise-04.m

%}
clear;

addpath(genpath('./../utils/'));

DATA = load('../../data/abogados-stratified.mat');

U_1 = DATA.g1(:,2:3);
U_2 = DATA.g2(:,2:3);

N_h = [size(U_1, 1), size(U_2, 1)];
N = sum(N_h);
W_h = N_h ./ N;

nivel_alpha = 0.95;
k = norminv(1 - (1 - nivel_alpha) / 2);
%{
  Afijación proporcional (no se conocen estimaciones de varianzas)
%}

n = 80;
n_h = round(n .*  W_h);
f_h = n_h ./ N_h;
w_h = n_h ./ n;

%{
  Muestreo m.a.s. en cada estrato
%}

i_1_mas = mas(N_h(1), n_h(1));
i_2_mas = mas(N_h(2), n_h(2));

s_1_mas = U_1(i_1_mas, :);
s_2_mas = U_2(i_2_mas, :);

%{
    Variable X
%}

P_h_mas = [mean(s_1_mas(:,1)), mean(s_2_mas(:,1))];
P_h_mas_s2 = P_h_mas .* (1 .- P_h_mas) .* n_h ./ (n_h .- 1);
P_mas = sum(P_h_mas .* W_h)
P_mas_var = sum(W_h .^ 2 .* (1 .- f_h) .* P_h_mas_s2 ./ n_h);
P_mas_std = sqrt(P_mas_var);
P_mas_bound = k * P_mas_std;
P_mas_ic = [P_mas - P_mas_bound, P_mas + P_mas_bound]



%{
    Variable Y
%}

mu_h_mas = [mean(s_1_mas(:,2)), mean(s_2_mas(:,2))];
mu_h_mas_s2 = std(mu_h_mas) .^ 2 .* n_h ./ (n_h .- 1);
mu_mas = sum(mu_h_mas .* W_h)
mu_mas_var = sum(W_h .^ 2 .* (1 .- f_h) .* mu_h_mas_s2 ./ n_h);
mu_mas_std = sqrt(mu_mas_var);
mu_mas_bound = k * mu_mas_std;
mu_mas_ic = [mu_mas - mu_mas_bound, mu_mas + mu_mas_bound]

%{
  Muestreo m.a.s. en primer estrato y m.a.s.con en segundo
%}

i_2_mascon = mascon(N_h(2), n_h(2));
s_2_mascon = U_2(i_2_mascon, :);

%{
    Variable X
%}

P_h_mix = [mean(s_1_mas(:,1)), mean(s_2_mascon(:,1))];
P_h_mix_s2 = P_h_mix .* (1 .- P_h_mix) .* [n_h(1) ./ (n_h(1) .- 1), 1];

P_mix = sum(P_h_mix .* W_h)

P_mix_var = sum(W_h .^ 2 .* (1 .- [f_h(1), 0]) .* P_h_mix_s2 ./ n_h);
P_mix_std = sqrt(P_mix_var);
P_mix_bound = k * P_mix_std;
P_mix_ic = [P_mix - P_mix_bound, P_mix + P_mix_bound]

%{
    Variable Y
%}

mu_h_mix = [mean(s_1_mas(:,2)), mean(s_2_mascon(:,2))];
mu_h_mix_s2 = std(mu_h_mix) .^ 2 .* [n_h(1) ./ (n_h(1) .- 1), 1];

mu_mix = sum(mu_h_mix .* W_h)
mu_mix_var = sum(W_h .^ 2 .* (1 .- [f_h(1), 0]) ./ n_h .*  mu_h_mix_s2);
mu_mix_std = sqrt(mu_mix_var)
mu_mix_bound = k * mu_mix_std;
mu_mix_ic = [mu_mix - mu_mix_bound, mu_mix + mu_mix_bound]

%{
  Reducción del error muestreo 10%
%}

%{
  Muestreo m.a.s. en cada estrato
%}

%{
    Variable X
%}
B_new_mas_P = k * (1 - 0.1) * P_mas_std;
w_h_new_mas_P = N_h .* P_h_mas_s2 ./ sum(N_h .* P_h_mas_s2);

n_new_mas_P = round(sum(W_h  .^ 2 .* P_h_mas_s2 ./ w_h_new_mas_P) ./ (B_new_mas_P .^ 2 ./ k .^ 2 .+ sum(W_h ./ N .* P_h_mas_s2)))
%{
    Variable Y
%}
B_new_mas_mu = k * (1 - 0.1) * mu_mas_std;
w_h_new_mas_mu = N_h .* mu_h_mas_s2 ./ sum(N_h .* mu_h_mas_s2);

n_new_mas_mu = round(sum(W_h .^ 2 .* mu_h_mas_s2 ./ w_h_new_mas_mu) ./ (B_new_mas_mu .^ 2 ./ k .^ 2 .+ sum(W_h .^ 2 ./ N_h .* mu_h_mas_s2)))

%{
  Muestreo m.a.s. en primer estrato y m.a.s.con en segundo
%}

%{
    Variable X
%}
B_new_mix_P = k * (1 - 0.1) * P_mix_std;

w_h_new_mix_P = N_h .* P_h_mix_s2 ./ sum(N_h .* P_h_mix_s2);

n_new_mix_P = round(sum([
  (W_h(1) .^ 2 .* P_h_mix_s2(1) ./ w_h_new_mix_P(1)) ./ (B_new_mix_P .^ 2 ./ k .^ 2 .+ W_h(1) ./ N .* P_h_mas_s2(1)),
  W_h(2) .^ 2 .* P_h_mix_s2(2) .* k .^ 2 ./ (B_new_mix_P .^ 2 .* w_h_new_mix_P(2))
]))

%{
    Variable Y
%}
B_new_mix_mu = k * (1 - 0.1) * mu_mix_std;

w_h_new_mix_mu = N_h .* mu_h_mix_s2 ./ sum(N_h .* mu_h_mix_s2);

n_new_mix_mu = round(sum([
  (W_h(1) .^ 2 .* mu_h_mix_s2(1) ./ w_h_new_mix_mu(1)) ./ (B_new_mix_mu .^ 2 ./ k .^ 2 .+ W_h(1) .^ 2 ./ N_h(1) .* mu_h_mas_s2(1))
  W_h(2) .^ 2 .* mu_h_mix_s2(2) .* k .^ 2 ./ (B_new_mix_mu .^ 2 .* w_h_new_mix_mu(2))
]))

%{
  Ahora presupuesto C = 1000 y c_1 = 70 y c_2 = 100
%}
C = 1000;
C_h = [70, 100];

%{
  Muestreo m.a.s. en cada estrato
%}

%{
    Variable X
%}
n_h_new_mas_P = floor(W_h .* sqrt(P_h_mas_s2) ./ (sqrt(C_h) .* sum(W_h .* sqrt(P_h_mas_s2) .* sqrt(C_h)) ./ C))


%{
    Variable Y
%}
n_h_new_mas_mu = floor(W_h .* sqrt(mu_h_mas_s2) ./ (sqrt(C_h) .* sum(W_h .* sqrt(mu_h_mas_s2) .* sqrt(C_h)) ./ C))


%{
  Muestreo m.a.s. en primer estrato y m.a.s.con en segundo
%}

%{
    Variable X
%}
n_h_new_mix_P = floor(W_h .* sqrt(P_h_mix_s2) ./ (sqrt(C_h) .* sum(W_h .* sqrt(P_h_mix_s2) .* sqrt(C_h)) ./ C))


%{
    Variable Y
%}
n_h_new_mix_mu = floor(W_h .* sqrt(mu_h_mix_s2) ./ (sqrt(C_h) .* sum(W_h .* sqrt(mu_h_mix_s2) .* sqrt(C_h)) ./ C))

%{
  Contraste de hipótesis de igualdad de proporciones P
%}

%{
  Muestreo m.a.s en cada estrato con tamaño n_new_mas_P
%}

n_h_contrast_mas_P = n_new_mas_P .* w_h_new_mas_P;
f_h_contrast_mas_P = n_h_contrast_mas_P ./ N_h;

s_1_contrast_mas = U_1(mas(N_h(1), n_h_contrast_mas_P(1)),1);
s_2_contrast_mas = U_2(mas(N_h(2), n_h_contrast_mas_P(2)),1);

p_h_est_contrast_mas = [mean(s_1_contrast_mas), mean(s_2_contrast_mas)];
p_h_est_contrast_mas_var = (1 .- f_h_contrast_mas_P) .* p_h_est_contrast_mas .* (1 .- p_h_est_contrast_mas) ./ (n_h_contrast_mas_P .- 1);
p_h_est_contrast_mas_std = sqrt(p_h_est_contrast_mas_var);
p_h_est_contrast_mas_bound = k * p_h_est_contrast_mas_std;
p_h_est_contrast_mas_ic = [(p_h_est_contrast_mas .- p_h_est_contrast_mas_bound)', (p_h_est_contrast_mas .+ p_h_est_contrast_mas_bound)']


%{
  Muestreo m.a.s. en primer estrato y m.a.s.con en segundo
%}

n_h_contrast_mix_P = n_new_mix_P .* w_h_new_mix_P;
f_h_contrast_mix_P = n_h_contrast_mix_P ./ N_h;

s_1_contrast_mix = U_1(mas(N_h(1), n_h_contrast_mix_P(1)),1);
s_2_contrast_mix = U_2(mascon(N_h(2), n_h_contrast_mix_P(2)),1);


p_h_est_contrast_mix = [mean(s_1_contrast_mix), mean(s_2_contrast_mix)];
p_h_est_contrast_mix_var = (1 .- [f_h_contrast_mix_P(1), 0]) .* p_h_est_contrast_mix .* (1 .- p_h_est_contrast_mix) ./ (n_h_contrast_mix_P .- 1);
p_h_est_contrast_mix_std = sqrt(p_h_est_contrast_mix_var);
p_h_est_contrast_mix_bound = k * p_h_est_contrast_mix_std;
p_h_est_contrast_mix_ic = [(p_h_est_contrast_mix .- p_h_est_contrast_mix_bound)', (p_h_est_contrast_mix .+ p_h_est_contrast_mix_bound)']
