%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/example-03-a.m

%}

clear;

addpath(genpath('./../utils/'));

% Tercer ejemplo de teoria

% Simulación para verificar la observación de m.a.s. donde se determina el
% tamaño de la población a partir del cual hay que encuestar a los mismos si
% mantenemos error de estimacion confianza y variabilidad
% Registros contables de un hospital
% Auditoria con el fin de estimar la cantidad total que falta por cobrar

% Tamaño poblacion registros por auditorar
N = 28000;

%Este tamaño lo iremos variando para comprobar la observación

% Simulamos datos poblacionales, cantidad falta por cobrar en la poblacion
% de N registros
Y = normrnd(1500, 100, N, 1);


% Ejercicio 1:
%   Determinar el tamaño de muestra para estimar mu cometiendo un error de
%   estimación B de 3 euros con una confianza del 95%
B = 3
alfa = 0.05;
z_value = norminv(1 - alfa / 2, 0,1);

n0 = z_value ^ 2 * var(Y) / B ^ 2;
n1 = ceil(n0 / ((n0 / N) +1))


% Ejercicio 2:
%   Calcular el valor donde se alcanza la asintota segun la observación teórica N2

N2 = ceil(n0 * (n0 - 1))
Y2 = normrnd(3500, 100, N2, 1);


% Ejercicio 3:
%   Determinar el tamaño de muestra para estimar mu en la poblacion e tamaño N2
%   cometiendo el mismo  error de estimacion B y confianza del 95%
n2 = calmumnmas(N2, B , 0.975, var(Y2))


% Ejercicio 4:
% Tomar poblaciones de tamaño superior a N2 y comprobar que el tamaño de muestra
% se mantiene

N3 = 2 * N2;
Y3 = normrnd(1500, 100, N3, 1);
n3 = calmumnmas(N3, B , 0.975, var(Y3))

% Ejercicio 5:
% Determinar el tamaño de muestra para estimar mu cometiendo un error de
% estimación B de 5000 euros con una confianza del 95%
n4 = calmumnmas(N3, 5000 , 0.975, var(Y3))
