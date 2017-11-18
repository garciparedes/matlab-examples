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
P_h_mix_s2 = P_h_mix .* (1 .- P_h_mix) .* n_h ./ (n_h .- 1);

P_mix = sum(P_h_mix .* W_h)

P_mix_var = sum(W_h .^ 2 .* (1 .- [f_h(1), 0]) .* P_h_mix_s2 ./ n_h);
P_mix_std = sqrt(P_mix_var);
P_mix_bound = k * P_mix_std;
P_mix_ic = [P_mix - P_mix_bound, P_mix + P_mix_bound]

%{
    Variable Y
%}

mu_h_mix = [mean(s_1_mas(:,2)), mean(s_2_mascon(:,2))];
mu_h_mix_s2 = std(mu_h_mix) .^ 2 .* n_h ./ (n_h .- 1);

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

%{
    Variable Y
%}

%{
  Muestreo m.a.s. en primer estrato y m.a.s.con en segundo
%}

%{
    Variable X
%}

%{
    Variable Y
%}
