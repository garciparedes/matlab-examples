%{

  Universits: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: stratified-sampling/exam-15-16.m

%}

clear all;

addpath(genpath('./../utils/'));

%{
  basloc1 Cantidad de impuesto de basura de cada local
  basloc2 Local pagador (0) o local defraudador (1)
  basviv1 Cantidad de impuesto de basura por vivienda
  basviv2 Vivienda pagadora (0) o vivienda defraudadora (1)
%}
DATA = load('../../data/basuras.mat');

U_1 = [DATA.basloc1, DATA.basloc2];
U_2 = [DATA.basviv1, DATA.basviv2];

N_h = [size(U_1, 1), size(U_2, 1)];
N = sum(N_h);
W_h = N_h ./ N;


%{
  a) Determinar el tamaño de muestra necesario para estimar la proporción total
  de “defraudadores” (locales+viviendas= Población con impuesto de basuras) con
  un error de estimación inferior al 10% y una confianza del 95%, suponiendo
  m.a.s. sin reemplazamiento en los dos estratos.
%}

B = 0.1;
k = norminv(1 - (1 - 0.95) / 2);

P_h_naive = [0.5, 0.5];
P_h_naive_var = P_h_naive .* (1 .- P_h_naive) .* N_h ./ (N_h .- 1);

w_h = W_h;

n = ceil(sum(W_h .^ 2 .* P_h_naive_var ./ w_h) ./ (B .^ 2 ./ k .^ 2 .+ sum(W_h .* P_h_naive_var ./ N)))

n_h = round(n .* w_h);
f_h = n_h ./ N_h;

%{
  b) Con este tamaño de muestra:
%}

i_1 = mas(N_h(1), n_h(1));
i_2 = mas(N_h(2), n_h(2));

s_1 = U_1(i_1, :);
s_2 = U_2(i_2, :);

%{
  i) Estimar la proporción de “defraudadores” y contrastar si la proporción de
  defraudadores es la misma entre locales y viviendas.
%}

p_h_est = [mean(s_1(:,2)), mean(s_2(:,2))]

s_h_p_S2 = p_h_est .* (1 .- p_h_est) .* n_h ./ (n_h .- 1);

p_h_est_var = (1 .- f_h) .* s_h_p_S2 ./ n_h;
p_h_est_std = sqrt(p_h_est_var);
p_h_est_bound = k .* p_h_est_std;
p_h_est_ic = [(p_h_est .- p_h_est_bound )' , (p_h_est .+ p_h_est_bound )']

p_est = sum(p_h_est .* W_h)
p_est_var = sum(W_h .^ 2 .* p_h_est_var);
p_est_std = sqrt(p_est_var);
p_est_bound = k * p_est_std;
p_est_ic = [p_est - p_est_bound, p_est + p_est_bound]

%{
  ii) La cantidad media del impuesto de basura por vivienda, por local y en total.
%}

%{
  iii) Plantear el cálculo del tamaño de muestra del apartado a) si se utiliza
  m.a.s. sin reemplazamiento en el primer estrato y m.a.s. con reemplazamiento
  en el segundo estrato.
%}
