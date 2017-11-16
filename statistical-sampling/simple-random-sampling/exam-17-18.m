%Muestreo Estadístico I. Grado en Estadística. 3º Curso.
%Control 16 de Octubre. Curso 2017-2018.

% Sergio Garcia Prado

clear;

addpath(genpath('./../utils/'));

DATA = load('../../data/datmas2017.mat');

U_c = [DATA.Y1, DATA.Y2];
N_c = size(U_c, 1)

U_bs = [DATA.Y3, DATA.Y4, DATA.Y5];
N_bs = size(U_bs, 1)

N_locales = 47

% Valor Crítico de la distribuctión Normal Estándar de nivel 1-alfa = 0.95
k = norminv(0.975,0,1);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a)	Fijado un error de estimación del 5%  para estimar la proporción de
% clientes particulares dispuestos a reducir el precio de venta un 10% o
% más con una confianza del 95%, determinar el tamaño de muestra si el
% diseño es m.a.s. con y sin reemplazamiento.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B_b_p1_est = 0.05;

n0_c_mas = k ^ 2 * 0.25 * N_c / (B_b_p1_est ^ 2 * (N_c -1));

% SOLUCION a) sin reemplazamiento
n_c_mas = ceil(n0_c_mas /((n0_c_mas / N_c )+1))

f_c_mas = n_c_mas / N_c;

% SOLUCION a) con reemplazamiento
n_c_mascon = ceil( k ^ 2 * 0.25 / B_b_p1_est ^ 2)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%b)	Tomar las m.a.s. (sin reemplazamiento), del tamaño decidido en a),
% de los datos poblacionales y estimar:
%
%i.	La proporción de clientes particulares dispuestos a reducir el precio
% de venta un 10% o más.
%
%ii.	El precio media de venta de cada inmueble puesto a la venta en la
% inmobiliaria perteneciente a clientes particulares.

i_c_mas = mas(N_c, n_c_mas);
s_c_mas = U_c(i_c_mas,:);

% SOLUCION b) i
p1_est_mas = mean(s_c_mas(:,2))
p1_est_mas_var = (1 - f_c_mas) / (n_c_mas - 1) * p1_est_mas * (1 - p1_est_mas);
p1_est_mas_sd = sqrt(p1_est_mas_var);
p1_est_mas_bound = k * p1_est_mas_sd;
p1_est_mas_ic = [p1_est_mas - p1_est_mas_bound, p1_est_mas + p1_est_mas_bound]

% SOLUCION b) ii
mu1_est_mas =  mean(s_c_mas(:,1))
mu1_est_mas_var = (1 - f_c_mas) / (n_c_mas - 1) * var(s_c_mas(:,1));
mu1_est_mas_sd = sqrt(mu1_est_mas_var);
mu1_est_mas_bound = k * mu1_est_mas_sd;
mu1_est_mas_ic = [mu1_est_mas - mu1_est_mas_bound, mu1_est_mas + mu1_est_mas_bound]



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c)	Si la muestra tomada en el apartado a) la consideramos una muestra
% previa, determinara el tamaño de muestra necesario para reducir un 10%
% el error de estimación cometido en b)-i.

B_b_p2_est = 0.9 * p1_est_mas_sd;

p_1_p_est = (N_c - 1) * n_c_mas / (N_c * (n_c_mas - 1)) *  p1_est_mas * (1 - p1_est_mas);

n0_c_p2_est_mas = k ^ 2 * p_1_p_est * N_c / (B_b_p2_est ^ 2 * (N_c -1));

% SOLUCION c)
n_c_p2_est_mas = ceil(n0_c_p2_est_mas /((n0_c_p2_est_mas / N_c )+1))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%d)	Tomar una m.a.s. de 12 bancos-sociedades y estimar:
%
%i.	El número total el total de bienes inmuebles puestos a la venta por la
% población de clientes bancos-sociedades.
%
%ii.	Proporción de  clientes bancos-sociedades dispuestos a reducir el
% precio de venta un 10% o más.
%
%iii.	Estimar el número de bienes inmuebles puestos a la venta por
% bancos-sociedades en cada local donde presta servicios la inmobiliaria.

n_bs_1 = 12;
f_bs_1 = n_bs_1 / N_bs;
i_bs_1 = mas(N_bs, n_bs_1);
s_bs_1 = U_bs(i_bs_1,:);

% SOLUCION d) i
tau_bs_est_1 = sum(s_bs_1(:,1)) / f_bs_1
tau_bs_est_1_var =  N_bs ^ 2 * (1 - f_bs_1) * var(s_bs_1(:,1)) / (n_bs_1 - 1);
tau_bs_est_1_sd = sqrt(tau_bs_est_1_var);
tau_bs_est_1_bound = k * tau_bs_est_1_sd;
tau_bs_est_1_ic = [tau_bs_est_1 - tau_bs_est_1_bound, tau_bs_est_1 + tau_bs_est_1_bound]

% SOLUCION d) ii
p_bs_est_1 = mean(s_bs_1(:,3))
p_bs_est_1_var = (1 - f_bs_1) / (n_bs_1 - 1) * p_bs_est_1 * (1 - p_bs_est_1);
p_bs_est_1_sd = sqrt(p_bs_est_1_var);
p_bs_est_1_bound = k * p_bs_est_1_sd;
p_bs_est_1_ic = [p_bs_est_1 - p_bs_est_1_bound, p_bs_est_1 + p_bs_est_1_bound]

% SOLUCION d) iii
tau_local_bs_est_1 = tau_bs_est_1 / N_locales



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%e)	Determinar el número de clientes bancos-sociedades que habría que tomar
% con m.a.s. para reducir un 10% el error de muestreo cometido en el
% apartado d)-i.. .

% Reducción del 10% del Error de Muestreo
B_bs_2 = 0.9 * tau_bs_est_1_sd;

n0_bs_2 = N_bs ^ 2 * k ^ 2 * var(s_bs_1(:,1)) / B_bs_2 ^2;

% SOLUCION e)
n_bs_2 = ceil(n0_bs_2 /((n0_bs_2 / N_bs )+1))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%f)	Determinar el número de clientes bancos-sociedades que habría que tomar
% con m.a.s. para reducir un 10% el error de estimación cometido en el
% apartado d)-ii.

% Reducción del 10% del Error de Estimación
B_bs_3 = 0.9 * p_bs_est_1_bound;

p_1_p_est = (N_bs - 1) * n_bs_1 / (N_bs * (n_bs_1 - 1)) *  p_bs_est_1 * (1 - p_bs_est_1);
n0_bs_3 = k ^ 2 * p_1_p_est  *  N_bs  / ( B_bs_3 ^ 2 * (N_bs - 1) );

% SOLUCION f)
n_bs_3 = ceil(n0_bs_3 /((n0_bs_3 / N_bs )+1))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%g)	Determinar el tamaño de población clientes bancos-sociedades a partir
% del cual, si la variable clientes bancos-sociedades dispuestos a reducir
% el precio tiene la misma variabilidad, el tamaño de muestra, para el
% mismo error de estimación y confianza,  se mantiene constante.

% SOLUCION g)
n_bs_3_limit = ceil( n0_bs_3 * (n0_bs_3 - 1 ))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%h)	Si se puede,  estimar el precio media de venta de cada inmueble puesto
% a la venta en la inmobiliaria perteneciente a clientes bancos-sociedades.

% Se realiza una adaptación de la muestra, de tal manera que tau = sum(c_k
% * y_k) donde c_k = 1 / (número de inmuebles del banco-sociedad k) para
% despues hacer mu = tau / N

% SOLUCION h)
mu_bs_compuesto =  mean(s_bs_1(:,2) ./ s_bs_1(:,1))
