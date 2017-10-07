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
addpath(genpath('functions/'));

N_abogados = 650;
N_despachos = 35;

s_abogados = [50; 25; 60; 30; 10; 5; 20; 40; 25; 10; 15; 5; 20; 40]
n_s_abogados = size(s_abogados, 1);

s_despachos = [10, 150; 12, 240; 25, 300; 12, 280; 20, 600]
n_s_despachos = size(s_despachos, 1);


%{
  El número total de casos atendidos en el año 2010 por los abogados
  independientes, que no están en despacho
%}


%{
  El número total de abogados en Valladolid.
%}


%{
  El número medio de casos atendido por abogado independiente, que no está en
  despacho
%}


%{
  El número medio de casos atendido por Despacho de abogados
%}

%{
  Encontrar a cuantos abogados independientes, que no están en despachos,
  preguntar para reducir un 5% el error de muestreo cometido con la muestra
  anterior de 14 a la hora al estimar el número total de casos atendidos por
  estos abogados en el ejercicio del 2010
%}
