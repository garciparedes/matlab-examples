%{

  Universits: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: stratified-sampling/exercise-5.m

%}
clear;

addpath(genpath('./../utils/'));

DATA = load('../../data/medicos.mat');

U_1 = DATA.hosp1(:,2);
U_2 = DATA.hosp2(:,2);

N_h = [size(U_1,1), size(U_2,1)];
N = sum(N_h);
W_h = N_h ./ N;

k = norminv(1 - (1 - 0.95) / 2);

n_h = [20, 32];
f_h = n_h ./ N_h;

n = sum(n_h);

i_1 = mas(N_h(1), n_h(1));
i_2 = mascon(N_h(2), n_h(2));

s_1 = U_1(i_1);
s_2 = U_2(i_2);

%{
  1)  Estimar todos los parámetros que consideres de interés
%}

p_h_est = [mean(s_1), mean(s_2)];

s_h_S2 = p_h_est .* (1 .- p_h_est) .* n_h(1) ./ (n_h(1) .- 1);

p_est =  sum(p_h_est .* W_h)
p_est_var = sum(W_h .^ 2 .* s_h_S2 .* (1 .- [f_h(1), 0])  ./ n_h)
p_est_std = sqrt(p_est_var);
p_est_bound = k * p_est_std;
p_est_ic = [p_est - p_est_bound, p_est + p_est_bound]

%{
  2)  ¿Se puede suponer que la proporción de los que están dispuestos a cambiar
      de centro de trabajo en el hospital 1 es igual que los que están
      dispuestos a cambiar en el hospital 2?
%}

p_h_est_var = s_h_S2 .* (1 .- [f_h(1), 0]) ./ n_h;
p_h_est_std = sqrt(p_h_est_var);
p_h_est_bound = k .* p_h_est_std;
p_h_est_ic = [(p_h_est - p_h_est_bound)', (p_h_est + p_h_est_bound)']


%{
  3)  Encontrar el tamaño de muestra que hay que tomar para estimar la
      proporción de médicos que están dispuestos a cambiar de centro reduciendo
      un 10% el error de muestreo cometido con la muestra tomada en el apartado
      ii) en cada uno de los dos hospitales de las siguientes formas:
%}

%{
  3.1)  Encontrar el tamaño de muestra global para cometer el nuevo error.
%}

n
B = p_est_bound;
w_h = n_h ./ n;
n_new = round(sum([
  (W_h(1) .^ 2  .* s_h_S2(1) ./ w_h(1) ) ./ (B .^ 2 ./ k .^ 2 .+ W_h(1) .^ 2 .* s_h_S2(1) ./ N_h(1)),
  W_h(2) .^ 2 .* s_h_S2(2) .* k .^ 2 ./ (B .^ 2 .* w_h(2))
]))

%{
  3.2)  Encontrar el tamaño de muestra en cada estrato para que el global sea el
        que queremos.
%}
