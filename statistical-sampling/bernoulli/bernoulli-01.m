%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: bernoulli-01.m

%}


%Resolver el ejercico presentado en teoría
%Tenemos 600 alumnos
N=600;
%Tomemos una muestra de Bernoulli con probabilidad de seleccion 1/6

%Simulemos los datos poblacionales para poder tomar la muestra
datpob=unifrnd(0,10,N,1);

%Considerara dos contadores
contpi=0;
contalt=0;
%Repetir el proceso de tomar la muestra estimar la media con ICs con los
%dos metodos nit=100 veces y comprobar cuantas veces los ICs contienen al
%verdadero valor del parametro con objeto de confirmar que los ICs
%obtenidos tienen la confianza deseada (95%)

%Tomemos la muestra

%Utilizar una funcion para tomar la muestra
%individuos que conforman la muestra

%Tomemos las respuestas de los individuos seleccionados

%Estimemos la nota media poblacional utilizandio las dos alternativas de
%estimadores

%piestimador de la nota total de los 600 alumnos

%Estimacion del ECM e la nota total de los 600 alumnos

%Error de muestreo de la media poblacional

%Error de estimacion fijada una confianza del 95%

%IC del 95% para mu es

%Comprobamos si el IC contiene al paremtro media poblacional



%Estimar el parametro total poblacional con el estimador alternativo
%Tamaño de la muestra seleccionada

%La formula 11 depende de la cuasivarianza POBLACIONAL
%Tengo que estimar la cuasivarianza poblacional y propongo estimarla con la
%cusivarianza muetral
%ecm taotal est alternativo

%Estimemso la media con estimador alternativo

%Error de estimacion fijada una confianza del 95%

%IC del 95% para la media poblacional es


%Confioanza de los intervalos
%Metodo piestimador

%Metodo alterbnativo
