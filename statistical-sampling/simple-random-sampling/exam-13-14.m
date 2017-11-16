%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/exam-15-16.m

%}
clear;

addpath(genpath('./../utils/'));

%{
  Un almacén mayorista dispone de un cargamento compuesto por 1500 cajas de
  naranjas. Los datos poblacionales se encuentran en el fichero datcont13.mat.
  Este fichero contiene dos variables Y1 que corresponde al número de naranjas
  de cada una de las 1500 cajas y la variable Y2 que determina si la caja de
  naranjas se puede considerar defectuoso (Y2=1) o correcta (Y2=0).
%}
DATA = load('../../data/datcont13.mat');
U = [DATA.Y1, DATA.Y2];
N = size(U,1)

mu1 = mean(U(:,1))
p2 = mean(U(:,2))
taud2 = sum(U(:,1)) * p2

%{
  Objetivo 1:
    Estimar el total de naranjas y el número medio de naranjas de cada caja.

  Forma de actuar para lograr el objetivo 1:
    Tomar una m.a.s. piloto de 10 cajas y determinar el número de cajas que son
    necesarias para estimar el número medio de naranjas por caja con un error de
    estimación inferior a 5 naranjas (si no sale una cantidad de cajas razonable
    preguntarme) con una confianza del 90%. Tomar la muestra de cajas del tamaño
    calculado con m.a.s. y con m.a.s. con reemplazamiento y estimar los
    parámetros de interés.
%}
k1 = norminv(0.95, 0, 1);


n_piloto = 10;
i_piloto = mas(N, n_piloto);
s_piloto = U(i_piloto, :);
s_piloto_var1 = var(s_piloto(:,1)) * n_piloto / (n_piloto - 1);

n1 = calmumnmas(N, 5, 0.9, s_piloto_var1)
f1 = n1/N;

i1_mas = mas(N, n1);
s1_mas = U(i1_mas,:);

mu1_est1_mas = mean(s1_mas(:,1))
mu1_est1_mas_var = (1-f1) / (n1-1) * var(s1_mas(:,1));
mu1_est1_mas_bound = k1 * sqrt(mu1_est1_mas_var);
mu1_est1_mas_ic = [mu1_est1_mas - mu1_est1_mas_bound, mu1_est1_mas + mu1_est1_mas_bound]

i1_mascon = mascon(N, n1);
s1_mascon = U(i1_mascon,:);

mu1_est1_mascon = mean(s1_mascon(:,1))
mu1_est1_mascon_var =  var(s1_mascon(:,1)) / (n1-1);
mu1_est1_mascon_bound = k1 * sqrt(mu1_est1_mascon_var);
mu1_est1_mascon_ic = [mu1_est1_mascon - mu1_est1_mascon_bound, mu1_est1_mascon + mu1_est1_mascon_bound]

%{
  Objetivo 2:
    Estimar el total de cajas defectuosas y la proporción de cajas defectuosas

  Forma de actuar para lograr el objetivo 2:
    Sin utilizar muestra previa, determinar el tamaño de muestra necesario para
    que el error de estimación de la proporción de cajas defectuosas sea
    inferior al 5% con una confianza del 95%. Tomar la muestra del tamaño
    calculado y estimar los parámetros. (Hacerlo para m.a.s. con y sin
    reemplazamiento)
%}

k2 = norminv(0.975, 0, 1);

n2 = calcnPmas(N, 0.95, 0.05)
f2 = n2 /N;

i2_mas = mas(N,n2);
s2_mas = U(i2_mas, :);

p2_est_mas = mean(s2_mas(:,2))
p2_est_mas_var = (1-f2) / (n2 - 1) * p2_est_mas * (1 - p2_est_mas);
p2_est_mas_bound = k2 * sqrt(p2_est_mas_var);
p2_est_mas_ic = [p2_est_mas - p2_est_mas_bound, p2_est_mas + p2_est_mas_bound]

taud2_est_mas = sum(s2_mas(:,1)) / f2 * p2_est_mas
taud2_est_mas_var = N ^ 2 * (1 - f2) * (p2_est_mas * (var(s2_mas(:,1)) * n2 /(n2-1) + (1- p2_est_mas) * mean(s2_mas(:,1)) ^ 2)) / n2
taud2_est_mas_bound = k2 * sqrt(taud2_est_mas_var);
taud2_est_mas_ic = [taud2_est_mas - taud2_est_mas_bound, taud2_est_mas + p2_est_mas_bound]


i2_mascon = mascon(N,n2);
s2_mascon = U(i2_mascon, :);

p2_est_mascon = mean(s2_mas(:,2))
p2_est_mascon_var =  p2_est_mascon * (1 - p2_est_mascon) / (n2 - 1);
p2_est_mascon_bound = k2 * sqrt(p2_est_mascon_var);
p2_est_mascon_ic = [p2_est_mascon - p2_est_mascon_bound, p2_est_mascon + p2_est_mascon_bound]


taud2_est_mascon = sum(s2_mascon(:,1)) / f2 * p2_est_mascon
taud2_est_mascon_var = N ^ 2 * (1 - f2) * (p2_est_mascon * (var(s2_mascon(:,1)) * n2 /(n2-1) + (1- p2_est_mascon) * mean(s2_mascon(:,1)) ^ 2)) / n2;
taud2_est_mascon_bound = k2 * sqrt(taud2_est_mascon_var);
taud2_est_mascon_ic = [taud2_est_mascon - taud2_est_mascon_bound, taud2_est_mascon + taud2_est_mascon_bound]
