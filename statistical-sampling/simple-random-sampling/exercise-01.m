%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/exercise-01.m

%}
clear;

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
MU = mean(U)


s_piloto = U(mas(N, 0.1 * N));
n_piloto = size(s_piloto, 1);
s2_piloto = var(s_piloto);
p_piloto = size(s_piloto(s_piloto >= 1525), 1) / n_piloto;

% Muestra Aleatoria Simple
pq_est_mas = ((N-1) * n_piloto) / ((n_piloto - 1) * N) * p_piloto;
n_s_mas = calcnPmasEst(size(U,1), 0.95, 0.1, pq_est_mas);

s_mas = U(mas(N, n_s_mas));

% Resultados con Muestra Aleatoria Simple
P_est_mas = mean(s_mas >= 1525)
T_est_mas = N * P_est_mas
MU_est_mas = mean(s_mas)

% Muestra Aleatoria con Reemplazamiento
pq_est_mascon = n_piloto / (n_piloto - 1) * p_piloto;
n_s_mascon = (norminv(0.975, 0, 1) ^ 2 * pq_est_mascon) / 0.1 ^ 2;

s_mascon = U(mascon(N, n_s_mascon));

% Resultados con Muestra Aleatoria Simple
P_est_mascon = mean(s_mascon >= 1525)
T_est_mascon = N * P_est_mascon
MU_est_mascon = mean(s_mascon)
