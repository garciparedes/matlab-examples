% Sergio García Prado
% Fórmulas de cuadratura

clear all;

% To use same syntax in Octave as in Matlab
integral = @(f, a, b) quad(f,a,b);


%
% Ejercicio 3
% ****************


% Integral 1
I_3_1 = integral(@(x) e .^ (- x .^ 2), 0, 1)

% Integral 2
I_3_2 = 1 / pi * integral(@(x) e .^ (- x .^ 2), -inf, inf)

% Integral 3
I_3_3 = integral(@(x) cos(x .^ 2), -pi/2, pi/2)


%
% Ejercicio 6
% ****************

f_6_str = '@(x) cos(pi ./ 2 .* x .^ 2)';
a_6 = 0;

% Apartado 6.1
b_6_1 = 0.1;

J_tr_1 = RTrapecioS(f_6_str, a_6, b_6_1)
J_pm_1 = RPuntoMedioS(f_6_str, a_6, b_6_1)
J_si_1 = RSimpsonS(f_6_str, a_6, b_6_1)

% Apartado 6.2

b_6_2 = 1.5;

J_tr_2 = RTrapecioS(f_6_str, a_6, b_6_2)
J_pm_2 = RPuntoMedioS(f_6_str, a_6, b_6_2)
J_si_2 = RSimpsonS(f_6_str, a_6, b_6_2)


%
% Ejercicio 7
% ****************

I_1 = integral(str2func(f_6_str), a_6, b_6_1)
E_1 = abs(I_1 - [J_tr_1, J_pm_1, J_si_1])

I_2 = integral(str2func(f_6_str), a_6, b_6_2)
E_2 = abs(I_2 - [J_tr_2, J_pm_2, J_si_2])


%
% Extra
% ***************
J_tr_comp = RTrapecioC(f_6_str, a_6, b_6_2, 20)
