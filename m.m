% =================================================================================================================== %
%                                                                                                                     %
% =================================================================================================================== %

clc
clear
close all

epsilon = 1; % Le petit écart autour de "0"

abscissesNegatives = linspace( -20, -epsilon);
abscissesPositives = linspace(1, epsilon);

ordonneesNegatives = (pi ./ abscissesNegatives).^3;
ordonneesPositives = (pi ./ abscissesPositives).^3;

plot(abscissesNegatives, ordonneesNegatives, "b");
hold on
plot(abscissesPositives, ordonneesPositives, "b");

xline(0);
yline(0);

vector_angles = rand(1, 10) * 2 * pi - pi % [0, 2 * π] -> [ - π, π]

array_randi = randi([0, 99], 3) % valeurs de 0 à 99 et matrice 3 * 3

% =================================================================================================================== %
%                                                                                                                     %
% =================================================================================================================== %