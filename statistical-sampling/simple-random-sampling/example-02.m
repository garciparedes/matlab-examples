%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/example-02.m

%}

clear;

addpath(genpath('./../utils/'));

% Segundo ejemplo de teoria

% Registros contables de un hospital
% Auditoria con el fin de estimar la cantidad total que falta por cobrar
% Tamaño población registros por auditorar
N = 28000;

% Generamos la cantidad que falta por cobrar en esas 28000 registros
% Variable de interés:
%   Y:  Cuanto falta de cobrar en cada uno de los 28000 registros
%       Datos poblacionales generados (uniforme de 0 a 1500 euros)
Y = unifrnd(0, 1500, 28000, 1);

% Consideremos una nueva variable Z que nos mide si la cantidad a cobrar es
% superior o no a 1000 euros
Z = Y >= 1000;

pZ = mean(Z)


% Ejercicio 1:
%   Tomar una m.a.s. de 280 individuos para estimar el parametro proporcion de
%   registros con cantidad pendiente de cobrar superior o igual a 1000 euros

n1 = 280;
f1 = n1 / N;
i1 = mas(N, n1);
s1 = Z(i1);

pZ_est_mas = mean(s1)
pZ_est_mas_var = (1 - f1) / (n1 - 1) * pZ_est_mas * (1 - pZ_est_mas);
pZ_est_mas_sd = sqrt(pZ_est_mas_var)
pZ_est_mas_bound = norminv(0.975, 0, 1) * pZ_est_mas_sd;
pZ_est_mas_ic = [pZ_est_mas - pZ_est_mas_bound, pZ_est_mas + pZ_est_mas_bound]


% Ejercicio 2:
%   Tomar una m.a.s. con reemplazamiento de 280 individuos para estimar el
%   parametro proporcion de registros con catiddad pendiente de cobrar superior
%   o igual a 1000 euros

n2 = 280;
f2 = n2 / N;
i2 = mascon(N, n2);
s2 = Z(i2);

pZ_est_mascon = mean (s2)
pZ_est_mascon_var = pZ_est_mascon * (1 - pZ_est_mascon) / (n2 - 1);
pZ_est_mascon_sd = sqrt(pZ_est_mascon_var);
pZ_est_mascon_bound = norminv(0.975, 0, 1) * pZ_est_mascon_sd;
pZ_est_mascon_ic = [pZ_est_mascon - pZ_est_mascon_bound, pZ_est_mascon + pZ_est_mascon_bound]


pZ_comp_designs = pZ_est_mascon_var / pZ_est_mas_var
