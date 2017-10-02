%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/exercise-01.m

%}

addpath(genpath('functions/'));

%{
  Col 1: Myoinositol
  Col 2: Scylloinositol
  Col 3: D:HI
  Col 4: D:HIIvar(yinfej1)
%}
DATA = load('../../data/adulvino.mat').datos;
U = DATA(2:size(DATA,1),1);
N = size(U,1)

T = size(U(U >= 1525),1)
P = T/N
TAU = sum(U)
MU = TAU / N


s_piloto = U(mas(N, 0.1 * N));
n_piloto = size(s_piloto, 1)
s2_piloto = var(s_piloto)

p_piloto = size(s_piloto(s_piloto >= 1525),1) /n_piloto;
pq_est = ((N-1)*n_piloto) /(((n_piloto-1)*N)) * p_piloto;
n_sp_mas = calcnPmas(size(U,1), 0.95, 0.1, pq_est);

sp_mas = U(mas(N, n_sp_mas));
P_est = estPmascon(sp_mas >= 1525, 0.95)
