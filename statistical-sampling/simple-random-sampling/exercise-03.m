%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/exercise-03.m

%}
clear;
addpath(genpath('functions/'));


DATA = load('../../data/soldsuiz.mat');
U = DATA.sold
