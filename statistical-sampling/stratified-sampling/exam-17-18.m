%Muestreo Estadístico I. Grado en Estadística. 3º Curso.
%Control 20 de Noviembre. Curso 2017-2018.

%Sergio Garcia Prado

clear;

addpath(genpath('./../utils/'));

%Una inmobiliaria con sede en todas las provincias de España tiene dos tipos de clientes,
%clientes particulares y clientes bancos-sociedades. Los particulares sólo tienen un bien
%inmueble para vender mientras que los bancos-sociedades tienen al menos uno.
%El número de locales donde presta servicios la inmobiliaria es 47, con un total de 14352 %
%clientes particulares y 340 clientes bancos-sociedades.
%A cada particular se le mide dos variables, Y1 precio de venta deseado (en miles de euros),
%Y2 si está dispuesto a reducir el precio de venta un 10% o más.
%A cada banco-sociedad se le mide tres variables, Y3 cuántos bienes inmuebles vende, Y4 precio
%total de venta de todos los inmuebles que vende en miles de euros), Y5 si está dispuesto a reducir el
%precio de venta de todos sus inmuebles un 10% o más.
%Los datos poblacionales se encuentran en el fichero datestr2017 en las variables,
%para la población de clientes particulares:  	Y1, Y2
%para la población de clientes bancos-sociedades:  Y3, Y4 e Y5.
%Resolver las siguientes cuestiones:

DATA = load('../../data/datestr2017.mat');
N_locales = 47;

U_1 = [DATA.Y1, DATA.Y2];
U_2 = [DATA.Y3, DATA.Y4, DATA.Y5];

N_h = [size(U_1, 1), size(U_2,1)];
N = sum(N_h);
W_h = N_h ./ N;

p_h = [mean(U_1(:,2)), mean(U_2(:,3))]
p = sum( p_h .* W_h)

tau_h = [sum(U_1(:,1)), sum(U_2(:,2))]
tau = sum(tau_h .* W_h)

mu_h = tau_h ./ [N_h(1),157552]
mu = sum(mu_h .* W_h)

%a)	Fijado un error de estimación del 5%  y una confianza del 90% para estimar
%la proporción de la población de clientes de la inmobiliaria dispuestos a reducir
%el precio de venta un 10% o más, determinar el tamaño de muestra si el diseño es
%m.a.s. sin reemplazamiento en los dos estratos. (1.25 puntos)

k = norminv(1 - (1 - 0.9) / 2 );
B = 0.05;

p_h_est_naive = [0.5, 0.5];
p_h_est_naive_S2 = p_h_est_naive .* (1 - p_h_est_naive) .* N_h ./ (N_h - 1);

%afijacion proporcional
w_h = W_h;

n = ceil(sum(W_h .^2 ./ w_h .* p_h_est_naive_S2) ./ (B ^ 2 / k ^ 2 + sum(W_h .^ 2 ./ N_h .* p_h_est_naive_S2)))

n_h = round(n .* w_h)
f_h = n_h ./ N_h;

%Con el diseño y tamaño de muestra determinado en el aparatado a) contestar b), c) y d):

i_1 = mas(N_h(1), n_h(1));
i_2 = mas(N_h(2), n_h(2));

s_1 = U_1(i_1, :);
s_2 = U_2(i_2, :);


%b)	Estimar la proporción de la población de clientes de la inmobiliaria dispuestos
%a reducir el precio de venta un 10% o más. ¿Esta proporción es la misma entre
%clientes particulares y clientes bancos-sociedades?. (1.5 puntos).

p_h_est = [mean(s_1(:, 2)), mean(s_2(:, 3))]
p_h_est_S2 = p_h_est .* (1 - p_h_est) .* n_h ./ (n_h - 1);


p_h_est_var = p_h_est_S2 .* (1 - f_h) ./ n_h;
p_h_est_std = sqrt(p_h_est_var);
p_h_est_bound = k .* p_h_est_std;
p_h_est_ic = [(p_h_est - p_h_est_bound)', (p_h_est + p_h_est_bound)']

p_est = sum(p_h_est .* W_h)
p_est_var = sum(W_h .^ 2 .* p_h_est_var);
p_est_std = sqrt(p_est_var);
p_est_bound = k * p_est_std;
p_est_ic = [p_est - p_est_bound, p_est + p_est_bound]

%c)	Estimar el precio medio de venta de los inmuebles disponibles en la inmobiliaria
%supuesto conocido que el número de bienes inmuebles de los clientes bancos-sociedades
%es 157552. ¿Este precio medio de venta es el mismo entre clientes particulares
% y clientes bancos-sociedades?. (1.5 puntos).


N_h_bienes = [N_h(1),  157552];
N_bienes = sum(N_h_bienes);
W_h_vienes = N_h_bienes ./ N_bienes;

tau_h_est = [sum(s_1(:, 1)), sum(s_2(:, 2))] ./ f_h;

precio_h_S2 = [std(s_1(:, 1)), std(s_2(:, 2))] .^ 2 .* n_h ./ (n_h - 1);

mu_h_est = tau_h_est ./ N_h_bienes
mu_h_est_var = precio_h_S2 .* (1 - f_h) ./ n_h;
mu_h_est_std = sqrt(mu_h_est_var);
mu_h_est_bound = k .* mu_h_est_std;
mu_h_est_ic = [(mu_h_est - mu_h_est_bound)', (mu_h_est + mu_h_est_bound)']


mu_est = sum(mu_h_est .* W_h)
mu_est_var = sum(W_h_vienes .^ 2 .* mu_h_est_var);
mu_est_std = sqrt(mu_est_var);
mu_est_bound = k * mu_est_std;
mu_est_ic = [mu_est - mu_est_bound, mu_est + mu_est_bound]



%d)	Estimar la cantidad total de dinero que la inmobiliaria tiene en productos
%de bienes inmuebles a la venta y la cantidad media en cada local en que presta servicio. (1.5 puntos)



tau_h_est
tau_h_est_var = N_h .^ 2 .* precio_h_S2 .* (1 - f_h) ./ n_h;

tau_est = sum(tau_h_est .* W_h)
tau_est_var = sum(tau_h_est_var);
tau_est_std = sqrt(tau_est_var);
tau_est_bound = k * tau_est_std;
tau_est_ic = [tau_est - tau_est_bound, tau_est + tau_est_bound]

mu2_est = tau_est / N_locales


%e)	Encontrar el tamaño de muestra necesario para reducir un 15% el error de
%muestreo cometido en el apartado c) para estimar el precio medio de venta de
%los inmuebles disponibles en la inmobiliaria. (1.25 puntos)


B2 = k * (1 - 0.15) * mu_est_std;

n_new =  ceil(sum(W_h .^ 2 ./ w_h .* precio_h_S2 ) ./ ( B2 ^ 2 / k ^ 2 +  sum(W_h .^ 2 ./ N_h .* precio_h_S2 )))

%f)	Repetir el apartado a) suponiendo m.a.s. con reemplazamiento en los dos estratos
%y conocida las dos m.a.s. del apartado b) para ser usadas como muestras previas. (1.5 puntos)


B;
p_h_est_S2;

w_h_new_mascon = (N_h .* p_h_est_S2) ./ sum(N_h .* p_h_est_S2);

n_new_mascon = ceil(sum(W_h .^ 2 ./ w_h_new_mascon .* p_h_est_S2) * k ^ 2 /  B ^ 2)
n_h_new_mascon = round(n_new_mascon .* w_h_new_mascon)

%g)	Tomar las m.a.s. con reemplazamiento del tamaño determinado en e) para estimar
%la proporción de la población de clientes de la inmobiliaria dispuestos a reducir el precio de venta un 10% o más. (1.25 puntos).

i_1_mascon = mascon(N_h(1), n_h_new_mascon(1));
i_2_mascon = mascon(N_h(2), n_h_new_mascon(2));

s_1_mascon = U_1(i_1_mascon, :);
s_2_mascon = U_2(i_2_mascon, :);

p_h_est_mascon = [mean(s_1_mascon(:, 2)), mean(s_2_mascon(:, 3))];
p_h_est_mascon_S2 = p_h_est_mascon .* (1 - p_h_est_mascon) .* n_h_new_mascon ./ (n_h_new_mascon - 1);

p_h_est_mascon_var = p_h_est_mascon_S2 ./ n_h;
p_h_est_mascon_std = sqrt(p_h_est_mascon_var);
p_h_est_mascon_bound = k .* p_h_est_mascon_std;
p_h_est_mascon_ic = [(p_h_est_mascon - p_h_est_mascon_bound)', (p_h_est_mascon + p_h_est_mascon_bound)']

p_est_mascon = sum(p_h_est_mascon .* W_h)
p_est_mascon_var = sum(W_h .^ 2 .* p_h_est_mascon_var);
p_est_mascon_std = sqrt(p_est_mascon_var);
p_est_mascon_bound = k * p_est_mascon_std;
p_est_mascon_ic = [p_est_mascon - p_est_mascon_bound, p_est + p_est_mascon_bound]

%h)	Supongamos fijado un error de estimación B del 5% y una confianza del 90%
%para estimar la proporción de la población de clientes de la inmobiliaria dispuestos
%a reducir el precio de venta un 10% o más. Consideremos m.a.s. sin reemplazamiento
%en los dos estratos. Determinar el error de estimación b que habría que fijar  en cada uno de los estratos,
%el mismo en los dos, para cometer el error global B. (1 punto).

B3 = 0.05;

b1 = B3 ./ sqrt(sum(W_h .^ 2))

%i)	¿Cambia el resultado del apartado h) si consideramos  m.a.s. con reemplazamiento en los dos estratos?. (1 punto)

b2 = B3 ./ sqrt(sum(W_h .^ 2))

%j)	¿Cambia el resultado del apartado h) si consideramos m.a.s. con reemplazamiento en estrato 1 y m.a.s. en estrato 2?. (1 punto)

b3 = B3 ./ sqrt(sum(W_h .^ 2))
