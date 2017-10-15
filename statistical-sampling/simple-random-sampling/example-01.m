%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/example-01.m

%}

clear;

addpath(genpath('functions/'));

% Primer ejemplo de teoria

% Registros contables de un hospital
% Auditoria con el fin de estimar la cantidad total que falta por cobrar
% Tamaño población registros por auditorar
N = 28000;

% Generamos la cantidad que falta por cobrar en esas 28000 registros
% Variable de interés:
%   Y:  Cuanto falta de cobrar en cada uno de los 28000 registros
%       Datos poblacionales generados (uniforme de 0 a 1500 euros)
Y = unifrnd(0, 1500, 28000, 1);

% Valor del parámetro de interés (total de cantidad faltante por cobrar en
% los 28000 resgitro)
tauY = sum(Y)


% Ejercicio 1:
%   Tomar una m.a.s. de n=100 registros y estimar el parámetro tauY

n1 = 100;
f1 = n1 / N;
i1 = mas(N, n1);
s1 = Y(i1);

tauY_est_mas = sum(s1) / f1
tauY_est_mas_var = N ^ 2 * (1 - f1) * var(s1) / (n1 - 1);
tauY_est_mas_bound = norminv(0.975, 0, 1) * sqrt(tauY_est_mas_var);
tauY_est_mas_ic = [tauY_est_mas - tauY_est_mas_bound, tauY_est_mas + tauY_est_mas_bound]


% Ejercicio 2:
%   Tomar una m.a.s. con de n=100 registros y estimar el parametro tauY

n2 = 100;
f2 = n2 / N;
i2 = mascon(N, n2);
s2 = Y(i2);

tauY_est_mascon = sum(s2) / f2;
tauY_est_mascon_var = N ^ 2 / (n2 - 1) * var(s2)
tauY_est_mascon_bound = norminv(0.975, 0, 1) * sqrt(tauY_est_mascon_var);
tauY_est_mascon_ic = [tauY_est_mascon - tauY_est_mascon_bound, tauY_est_mascon + tauY_est_mascon_bound]


% Ejercicio 3:
%   Determinar cuál de los dos diseños es mejor

tauY_comp_designs = tauY_est_mascon_var / tauY_est_mas_var
