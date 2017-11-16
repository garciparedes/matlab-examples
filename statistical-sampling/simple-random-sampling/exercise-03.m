%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/exercise-03.m

%}
clear;

addpath(genpath('./../utils/'));


DATA = load('../../data/soldsuiz.mat');
U = DATA.sold;
N = size(U,1);

n_piloto = 0.1 * N;
i_piloto = mas(N, n_piloto);
s_piloto = U(i_piloto, :);

p_U = sum(U(:, 1) <= 111) / N
p_piloto = sum(s_piloto(:, 1) <= 111) / n_piloto

pq_piloto_est_mas = ((N - 1) * n_piloto) / (N * (n_piloto - 1)) * p_piloto * (1 - p_piloto);

n_s_mas = calcnPmasEst(N, 0.99, 0.15, pq_piloto_est_mas)
i_mas = mas(N, n_s_mas);
s_mas = U(i_mas, :);
p_mas = sum(s_mas(:, 1) <= 111) / n_s_mas;

pq_piloto_est_mascon = n_piloto / (n_piloto - 1) * p_piloto * (1 - p_piloto);

n_s_mascon = ceil((norminv(0.995, 0, 1) ^ 2 * pq_piloto_est_mascon) / (0.15 ^ 2))
i_mascon = mascon(N, n_s_mascon);
s_mascon = U(i_mascon, :);
p_mascon = sum(s_mascon(:, 1) <= 111) / n_s_mascon
