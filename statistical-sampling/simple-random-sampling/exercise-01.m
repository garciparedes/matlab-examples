%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: simple-random-sampling/exercise-01.m

%}

%{
  Col 1: Myoinositol
  Col 2: Scylloinositol
  Col 3: D:HI
  Col 4: D:HII
%}
addpath(genpath('functions/'));
DATA = load('../../data/adulvino.mat').datos;
U = DATA(2:size(DATA,1),:);


s_piloto = U(unifrnd(0, 1, size(U,1), 1) < 0.1,1);
size(s_piloto,1)
size(s_piloto(s_piloto >= 1525,1),1)
