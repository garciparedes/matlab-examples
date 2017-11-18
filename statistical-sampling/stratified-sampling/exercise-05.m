%{

  Universits: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: stratified-sampling/exercise-5.m

%}
clear;

addpath(genpath('./../utils/'));

DATA = load('../../data/medicos.mat');

U_1 = DATA.hosp1(:,2);
U_2 = DATA.hosp2(:,2);

N_h = [size(U_1,1), size(U_2,1)];
N = sum(N_h);
W_h = N_h ./ N,
