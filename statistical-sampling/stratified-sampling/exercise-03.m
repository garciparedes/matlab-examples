%{

  Universits: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: stratified-sampling/exercise-03.m

%}
clear;

addpath(genpath('./../utils/'));

DATA = load('../../data/carcel.mat');

U_1 = DATA.mod1(:,2);
U_2 = DATA.mod2(:,2);
U_3 = DATA.mod3(:,2);

N_h = [size(U_1,1), size(U_2,1), size(U_3,1)];
N = sum(N_h, 2);

W_h = N_h ./ N;

n = 40;
