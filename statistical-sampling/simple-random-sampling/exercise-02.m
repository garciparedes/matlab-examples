%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/exercise-02.m

%}
clear;
addpath(genpath('functions/'));


DATA = load('../../data/construc.mat');
U1 = [DATA.pre, DATA.inf, DATA.mul, DATA.aut];

% AUTOPROMOTORES

N1 = size(U1, 1);
n1 = round(N1 * 0.15);
f1 = n1 / N1
I1 = mas(N1, n1);

% Ejercicio 1: Estimar el numero medio poblacional de infracciones cometido en
% cada obra de cada autopromotor

s1 = U1(I1,:);
mu_est = mean(s1(:,2));
ecm1 = (1-f1) * var(s1(:,2)) / n1;
bound1 = norminv(0.95,0,1) * sqrt(ecm1);
ci1 = [mu_est - bound1, mu_est + bound1]

% Ejercicio 2: Total de infracciones de las 500 obras de los autopromotores

t_est = sum(s1(:,2)) / f1

% Ejercicio 3: Cantidad total a recaudar por todas las infracciones
% cometidas en las 500 obras de los autopromotores

t_est = sum(s1(:,3)) / f1

var_est = var(s1(:,3));
bound2 = norminv(0.95,0,1) * sqrt((N1 ^ 2 * (1 - f1)) / n1 * var_est)
ci2 = [t_est - bound2, t_est + bound2]

% Ejercicio 4: Cantidad media a pagar por infraccion en cada una de las
% 500 obras de los autopromotores

t_est = sum(s1(:,3)) / sum(s1(:,2))


% Ejercicio 5: Determinar el tamaño de muestra necesario para reducir un 10%
% el error de estimación (bound2) del parametro numero medio de infracciones
% cometido en cada obra de cada autopromotor en el ejercicio 1

nej5=calmumnmas(N1, 0.9 * bound1, 0.9, var(s1(:,2)))

%
% CONSTRUCTORES
%


U2 = [DATA.obr, DATA.coinf, DATA.comul, DATA.cons];
N2 = size(U2,1);
n2 = round(0.15 * N2);
I2 = mas(N2, n2);

f2 = n1 / N1;
s2 = U2(I2,:);

% Ejercicio 6: Estimar el total de obras realizadas por las 60 constructoras


t_est2 = sum(s2(:,1))  / f2
var_t_est2 = (N2 ^ 2 * (1 - f2)) / n2 * var(s2(:,1));
bound_t_est2 = norminv(0.95, 0, 1) * sqrt(var_t_est2);

ci_t_est2 = [t_est2 - bound_t_est2,  t_est2 + bound_t_est2]

%Variable Conocida
Nobr2=sum(DATA.obr)

% Ejercicio 7:Estimar el numero medio de infracciones cometido en cada
% obra de los constructores

s2_inf_obr = s2(:, 2) ./ s2(:, 1)
mu_est2 = mean(s2_inf_obr)

var_mu_est2 = var(s2_inf_obr)
bound_mu_est2 = norminv(0.95, 0, 1) * sqrt(var_mu_est2)
ci_mu_est2 = [mu_est2 - bound_mu_est2, mu_est2 + bound_mu_est2]

% Ejercicio 8: Estimar la cantidad total a recaudar por todas las infracciones
% cometidas en las Nobr2 obras de los constructores

t_est3 = sum(s2(:,3)) / f2
var_t_est3 = (N2 ^ 2 * (1 - f2)) / n2 * var(s2(:,3))
bound_t_est3 = norminv(0.95, 0, 1) * sqrt(var_t_est3)
ci_t_est3 = [t_est3 - bound_t_est3, t_est3 + bound_t_est3]

% Ejercicio 9: Estimar la Cantidad media a pagar por infracciones en cada una
% de las Nobr2 obras de los constructores

t_est3 / Nobr2

% Ejercicio 10: Estimar la cantidad media a pagar en cada infraccion
% cometida por la constructora

t_est3 / (mu_est2 * Nobr2)

% Ejercicio 11: Determinar el tamaño de muestra de constructoras necesario
% para reducir un 10% el error de muestreo cometido en Ejercicio 8
