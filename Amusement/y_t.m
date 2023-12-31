% =================================================================================================================== %
%                                                                                                                     %
%                                                      Amusement                                                      %
%                                                                                                                     %
% =================================================================================================================== %

function [y_t_n] = y_t(n) % this function gives the vector y(t), from a defined "n"

	t = -1 : 0.01 : 1; % we have to reuse "t" here
	f = 1; % Hz
	w0 = 2 * pi * f; % rad
	for k = 1 : n % create the array y(t)
		K = 2 * k - 1;
		y(k, : ) = (4 * sin(K * w0 * t)) / (K * pi);
		% y(k, : ) means a whole line of y for a given "k"
	end
	y_t_n = y(n, : ); % ":" pour selectionner la colonne entière

% =================================================================================================================== %
%                                                                                                                     %
%                                                      Amusement                                                      %
%                                                                                                                     %
% =================================================================================================================== %