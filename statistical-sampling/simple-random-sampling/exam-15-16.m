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

alpha = 0.95
confianza = 1 - (1 - alpha) / 2
k = norminv(confianza, 0,1)

%{
  Objetivo 1: Considerando m.a.s. sin reemplazamiento

  Determinar el tamaño de muestra para estimar la proporción de asegurados
  privados, satisfechos con la aseguradora fijando un error de muestreo de 0.051.

  Con el tamaño demuestra obtenido:
    Estimar la proporción de asegurados privados satisfechos con el seguro.
    Estimar la satisfacción media con el seguro de los asegurados privados.
%}



n1 = calcnPmas(N1, alpha, 0.051)
f1 = n1 / N1;
i1 = mas(N1, n1);
s1 = U1(i1,:);

s1_est_var_2 = var(s1(:,2)) * n1 /(n1-1);

p1_est = sum(s1(:,1)) / n1
p1_est_var = (1 - f1) / (n1 - 1) * p1_est * (1 - p1_est)
p1_est_bound = k * sqrt(p1_est_var);
p1_est_ic = [p1_est - p1_est_bound, p1_est + p1_est_bound]


mu1_est = sum(s1(:,2)) / n1
mu1_est_var = (1-f1)/(n1) * s1_est_var_2;
mu1_est_bound = k * sqrt(mu1_est_var);
mu1_est_ic = [mu1_est - mu1_est_bound, mu1_est + mu1_est_bound]


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

n2_piloto = 10
i2_piloto = mas(N2, n2_piloto);
s2_piloto = U2(i2_piloto, :);


s2_piloto_est_var_2 = var(s2_piloto(:,2)) * n2_piloto /(n2_piloto-1);


n2 = ceil((N2 ^ 2 * k ^ 2 * s2_piloto_est_var_2)/(1400 ^ 2))
f2 = n2/N2;

i2 = mascon(N2, n2);
s2 = U2(i2, :);
s2_est_var_1 = var(s2(:,1)) * n2 /(n2-1);
s2_est_var_2 = var(s2(:,2)) * n2 /(n2-1);

tau2_est = sum(s2(:,1)) / f2
tau2_est_var = N2 ^ 2 / n2 * s2_est_var_1
tau2_est_bound = k * sqrt(tau2_est_var)
tau2_est_ic = [tau2_est - tau2_est_bound, tau2_est + tau2_est_bound]


tau3_est = sum(s2(:,2)) / f2
tau3_est_var = N2 ^ 2 / n2 * s2_est_var_2
tau3_est_bound = k * sqrt(tau3_est_var)
tau3_est_ic = [tau3_est - tau3_est_bound, tau3_est + tau3_est_bound]


p2_est = tau3_est / tau2_est
