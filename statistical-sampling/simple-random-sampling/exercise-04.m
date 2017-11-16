%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/exercise-04.m

%}
clear;

addpath(genpath('./../utils/'));

N_abogados = 650;
N_despachos = 35;


s_abogados = [50; 25; 60; 30; 10; 5; 20; 40; 25; 10; 15; 5; 20; 40]
n_s_abogados = size(s_abogados, 1);
pi_s_abogados = n_s_abogados/N_abogados;


s_despachos = [10, 150; 12, 240; 25, 300; 12, 280; 20, 600]
n_s_despachos = size(s_despachos, 1);
pi_s_despachos = n_s_despachos/N_despachos;

%{
  El número total de casos atendidos en el año 2010 por los abogados
  independientes, que no están en despacho
%}

tau_abogados_est = sum(s_abogados) / pi_s_abogados;
tau_abogados_est_var = (N_abogados ^ 2 * (1-(n_s_abogados/N_abogados))) / (n_s_abogados) * var(s_abogados)*(n_s_abogados)/(n_s_abogados-1)

tau_abogados_est_bound = norminv(0.975,0,1) * sqrt(tau_abogados_est_var)
tau_abogados_est_IC = [tau_abogados_est - tau_abogados_est_bound, tau_abogados_est + tau_abogados_est_bound]

%{
  El número total de abogados en Valladolid.
%}

tau_despachos_1_est = sum(s_despachos(:, 1)) / pi_s_despachos
tau_despachos_1_est_var = (N_despachos ^ 2 * (1-(n_s_despachos/N_despachos))) / (n_s_despachos) * var(s_despachos(:,1))*(n_s_despachos)/(n_s_despachos-1)

tau_despachos_1_est_bound = norminv(0.975, 0, 1) * sqrt(tau_despachos_1_est_var)
tau_despachos_1_est_IC = [tau_despachos_1_est - tau_despachos_1_est_bound, tau_despachos_1_est + tau_despachos_1_est_bound]

tau_abogados_total = N_abogados + tau_despachos_1_est

%{
  El número medio de casos atendido por abogado independiente, que no está en
  despacho
%}


mu_abogado_est = tau_abogados_est / N_abogados
mu_abogado_est_var = var(s_abogados) * (n_s_abogados) /(n_s_abogados - 1);
mu_abogado_est_bound = norminv(0.975, 0, 1) * sqrt(mu_abogado_est_var);
mu_abogado_est_IC = [mu_abogado_est-mu_abogado_est_bound,mu_abogado_est+mu_abogado_est_bound]

%{
  El número medio de casos atendido por Despacho de abogados
%}

tau_despachos_2_est = sum(s_despachos(:, 2)) / pi_s_despachos
tau_despachos_2_est_var = (N_despachos ^ 2 * (1-(n_s_despachos/N_despachos))) / (n_s_despachos) * var(s_despachos(:,2))*(n_s_despachos)/(n_s_despachos-1)

tau_despachos_2_est_bound = norminv(0.975, 0, 1) * sqrt(tau_despachos_2_est_var)
tau_despachos_2_est_IC = [tau_despachos_2_est - tau_despachos_2_est_bound, tau_despachos_2_est + tau_despachos_2_est_bound]

mu_despacho_2_est = tau_despachos_2_est / N_despachos
mu_despacho_2_est_var = var(s_despachos(:,2)) * (n_s_despachos) /(n_s_despachos - 1)
mu_despacho_2_est_bound = norminv(0.975, 0, 1) * sqrt(mu_despacho_2_est_var)
mu_despacho_2_est_IC = [mu_despacho_2_est-mu_despacho_2_est_bound,mu_despacho_2_est+mu_despacho_2_est_bound]

%{
  Encontrar a cuantos abogados independientes, que no están en despachos,
  preguntar para reducir un 5% el error de muestreo cometido con la muestra
  anterior de 14 a la hora al estimar el número total de casos atendidos por
  estos abogados en el ejercicio del 2010
%}

n_plus_s_abogados = caltamtaunmas(N_abogados, 0.95 * tau_abogados_est_bound, 0.975, var(s_abogados))
