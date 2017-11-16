%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: bernoulli-02.m

%}

clear;

addpath(genpath('./../utils/'));

% Resolver el ejercico presentado en teoría
% Tenemos 600 alumnos
N = 600;

% Simulemos los datos poblacionales para poder tomar la muestra
datpob = unifrnd(0, 10, N, 1);

% Generara datos poblacionales para saber si el individuo aprueba 5 o no aprueba
Y = zeros(N, 1);
for i = 1:N
    if datpob(i, 1) >= 5
        Y(i, 1) = 1;
    end
end

%Consideremos el parametro
P = sum(Y) / N
% este parámetro es proporcion de aprobados

% Ejercio estimar P utilizando metodologia de Bernoulli con probabilidad de
% seleccion de cada individuo de la poblacion pib=0.3 y las dos opciones de
% estimadores

pi_k = 0.3;
I = selecmuesbernll(N, pi_k);
s = datpob(I);
Ns = size(I, 1);

pi_estimador_Y = sum(Y(I)) / pi_k;
P_pi = pi_estimador_Y / N

alt_estimador_Y = (N / Ns) * sum(Y(I));
P_alt = alt_estimador_Y/N
