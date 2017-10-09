%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/exam-15-16.m

%}
addpath(genpath('functions/'));

DATA = load('../../data/datcont1415.mat');

U1 = [DATA.satdicot, DATA.satcont];
N1 = size(U1,1)

U2 = [DATA.numemp, DATA.empsatcont];
N2 = size(U2,1)


%{
  Objetivo 1: Considerando m.a.s. sin reemplazamiento

  Determinar el tamaño de muestra para estimar la proporción de asegurados
  privados, satisfechos con la aseguradora fijando un error de muestreo de 0.051.

  Con el tamaño demuestra obtenido:
    Estimar la proporción de asegurados privados satisfechos con el seguro.
    Estimar la satisfacción media con el seguro de los asegurados privados.
%}

alpha = 0.95
confianza = 1 - (1 - alpha / 2)

n1 = calcnPmas(N1, confianza, 0.051)
f1 = n1 / N1;
i1 = mas(N1, n1);
s1 = U1(i1,:);

p1_est = sum(s1(:,1)) / n1
mu1_est = sum(s1(:,2)) / n1

%{
  Objetivo 2: Considerando m.a.s. con reemplazamiento

  Tomar una muestra previa de 10 empresas, considerar su respuesta a la variable
  empsatcont y determinar el tamaño de muestra necesario para estimar el número
  total de asegurados en empresa satisfechos con la aseguradora con un error de
  estimación de 1400 y una confianza del 95% (antes de seguir indicar al
  profesor el tamaño de muestra que se obtiene).

  Con el tamaño demuestra obtenido:
    Estimar el número total de asegurados en empresa.
    Estimar el total de asegurados en empresa satisfechos con la aseguradora
%}
