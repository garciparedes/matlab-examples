%{

  Universits: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: stratified-sampling/exercise-01.m

%}
clear;

addpath(genpath('./../utils/'));

N_h = [2500, 3010, 2200, 2900];
N = sum(N_h);
W_h = N_h ./ N;

DATA = load('../../data/comunida.mat').datos(:, [1, 7]);

s_1 = DATA(DATA(:, 1) == 1, 2);
s_2 = DATA(DATA(:, 1) == 2, 2);
s_3 = DATA(DATA(:, 1) == 3, 2);
s_4 = DATA(DATA(:, 1) == 4, 2);
s = [s_1, s_2, s_3, s_4];

n_h = [size(s_1, 1), size(s_2, 1), size(s_3, 1), size(s_4, 1) ];
n = sum(n_h);
w_h = n_h ./ n;
f_h = n_h ./ N_h;

%{
  1)  ¿Es correcto utilizar afijación uniforme?

    En este caso utilizar afijación uniforme no es la opción más acertada,
    puesto que se favorecería la representación de las poblaciones con menor
    número de individuos penalizando las constituidas por mayores individuos.
    En este caso, a pesar de que las muestras referidas a cada estrato están
    formadas todas ellas por el mismo número de observaciones n_h, el tamaño
    global de cada estrato N_h no es el mismo, por lo que surgiría dicha
    "distorsión".
%}

%{
  2)  Estimar el grado medio de satisfacción global y obtener el error
    cuadrático medio, el error de estimación y el de muestreo. Argumenta si
    puedes decidir si es mejor usar afijación proporcional o de mínima varianza
    que la afijación uniforme original.
%}


mu_est = sum(sum(s) ./ f_h) / N

S2_h = n_h ./ (n_h - 1)  .* std(s) .^ 2

mu_est_ECM = sum(( (W_h .^ 2) .* ( 1 .- f_h) .* S2_h ) ./ n_h )
mu_est_EMUEST = sqrt(mu_est_ECM)
mu_est_EEST = norminv(1 - (1 - 0.95)/2) * mu_est_EMUEST

%{
  En cuanto a la respuesta sobre si es mejor usar afijación proporcional o de
  mínima varianza que la afijación uniforme original, debido a las estimaciones
  de la varianza poblacional para cada estrato, se cree que no es conveniente
  elegir afijación proporcional, puesto que cada estrato tiene una varianza
  diferente. Para poder responder con mayor seguridad a esta cuestión se debería
  realizar un test de igualdad de varianzas como el test de Levene.
%}
%{
var_test(s(:,1),s(:,2))
var_test(s(:,1),s(:,3))
var_test(s(:,1),s(:,4))
var_test(s(:,2),s(:,3))
var_test(s(:,2),s(:,4))
var_test(s(:,3),s(:,4))
%}

%{
  3)  Utilizar los datos como una muestra piloto y encontrar el tamaño de
    muestra necesario y su afijación si se quiere reducir un 10% el error de
    muestreo a la hora de estimar el mismo parámetro que en el apartado ii).
%}

B = 0.9 * mu_est_EMUEST;
k = norminv(1-(1-0.95)/2);
n_new = ceil((sum(W_h .^ 2  .* S2_h ./ w_h) ) ./ ((B ^ 2 / k ^ 2)  + sum(W_h .^2  .* S2_h ./ N_h)))
