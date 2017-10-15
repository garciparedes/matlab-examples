%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/example-03-b.m

%}

clear;

addpath(genpath('functions/'));

% Tercer ejemplo de teoria

% Registros contables de un hospital
% Auditoria
N = 28000;

% Generar lo que falta por cobrar en esas 28000
% Datos poblacionales
Y = unifrnd(0,1200,28000,1);
Y = round(Y);
Z = Y >= 1000;


% Ejercicio 1:
%   Parametro a estimar P=proporcion de facturar por cobrar de mas de 1000 euros
pZ = mean(Z)

% Ejercicio 2:
%   Determinar tamaño de muestra para estimar P con un error de estimacion
%   inferior o igual al 3% y confianza del 95%
%   Tomar la muestra y comprobar que el error de estimacion se verifica

B = 0.03;
k = norminv(0.975, 0, 1);

n0 = k ^ 2  * 0.25  / B ^ 2 * N / (N - 1);
n1 = ceil(n0 / ((n0 / N) + 1))


% Ejercicio 3:
%   Encontrar el tamaño de la poblacion a partir del cual para estimar una
%   proporcion con un B=0.03 y k=1.96 tenemos que preguntar al mismo numero de
%   individuos

Nlimit = ceil(n0 * (n0 - 1))


% Ejercicio 4:
%   Generar lo que falta por cobrar en la nueva
%   Parametro a estimar P=proporcion de facturar por cobrar de mas de 1000
%euros

Y2 = unifrnd(0,1200,Nlimit,1);
Y2 = round(Y2);
Z2 = Y2 >= 1000;
pZ2 = mean(Z2)


% Ejercicio 5:
%   Determinar tamaño de muestra para estimar P con un error de estimacion
%   inferior o igual al 3% y confianza del 95%
B = 0.03;
k = norminv(0.975, 0, 1);

%Tomar la muestra y comprobar que el error de estimacion se verifica
n0= k ^ 2 * 0.25 * Nlimit / (B ^ 2 * (Nlimit - 1));
nlimit = ceil(n0 / ((n0 / Nlimit) + 1) )
