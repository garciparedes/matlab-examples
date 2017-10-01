%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: bernoulli-01.m

%}


% Resolver el ejercico presentado en teoría
% Tenemos 600 alumnos
N = 600;

% Tomemos una muestra de Bernoulli con probabilidad de seleccion 1/6

% Simulemos los datos poblacionales para poder tomar la muestra
datpob = unifrnd(0, 10, N, 1);
mu = mean(datpob);
pi_k = 1 / 6;

% Valor crítico para z_0.975
alpha_value = 0.05;
z = norminv(1 - alpha_value / 2, 0, 1);

% Considerara dos contadores
contpi = 0;
contalt = 0;

% Repetir el proceso de tomar la muestra estimar la media con ICs con los
% dos metodos nit=100 veces y comprobar cuantas veces los ICs contienen al
% verdadero valor del parametro con objeto de confirmar que los ICs
% obtenidos tienen la confianza deseada (95%)
nit = 100;
for h = 1:nit

  % Tomemos la muestra

  % s = datpob(unifrnd(0, 1, N, 1) < pi_k);


  % Utilizar una funcion para tomar la muestra
  % individuos que conforman la muestra
  I = selecmuesbernll(N, pi_k);
  % Tomemos las respuestas de los individuos seleccionados
  s = datpob(I);
  Ns = size(s, 1);
  % Estimemos la nota media poblacional utilizandio las dos alternativas de
  % estimadores

  % piestimador de la nota total de los 600 alumnos
  pi_estimador = sum(s)/pi_k;

  % Estimacion del ECM de la nota total de los 600 alumnos

  var_pi_estimador = (1 / pi_k) * (1 / pi_k-1) * sum(s .^ 2);

  media_pi_estimador = pi_estimador / N

  % Error de muestreo de la media poblacional
  % Error de estimacion fijada una confianza del 95%
  % IC del 95% para mu es
  IC_range =  z * sqrt(var_pi_estimador / N^2);
  IC_izq = media_pi_estimador - IC_range;
  IC_der = media_pi_estimador + IC_range;

  % Comprobamos si el IC contiene al parámetro media poblacional
  contpi = contpi + (IC_izq < mu && mu < IC_der);

  %Estimar el parametro total poblacional con el estimador alternativo
  %Tamaño de la muestra seleccionada

  alt_estimador = N / Ns * sum(s);

  % La formula 11 depende de la cuasivarianza POBLACIONAL
  % Tengo que estimar la cuasivarianza poblacional y propongo estimarla con la
  % cuasivarianza muestral ecm total del estimador alternativo
  var_alt_estimador = N * (1 / pi_k - 1) * var(s);

  %Estimación de la media con estimador alternativo
  media_alt_estimador = alt_estimador / N

  %Error de estimacion fijada una confianza del 95%
  IC_range =  z * sqrt(var_alt_estimador / N^2);

  %IC del 95% para la media poblacional es
  IC_izq = media_alt_estimador - IC_range;
  IC_der = media_alt_estimador + IC_range;
  %Confianza de los intervalos
  contalt = contalt + (IC_izq < mu && mu < IC_der);

endfor

%Metodo piestimador
ratio_pi = contpi / nit

%Metodo alternativo
ratio_alt = contalt / nit
