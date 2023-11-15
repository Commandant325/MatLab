% =================================================================================================================== %
%                                                                                                                     %
%                                                      Amusement                                                      %
%                                                                                                                     %
% =================================================================================================================== %

clc
clear

n = 3;
t = -1 : 0.01 : 1;
precision = 0.8;
% ths value is the limit for - 1 and 1 in the square wave
liste = F_t(n); % we have to use the Task 06 files "F_t.m" and "y_t.m"
for i = 1 : length(F_t(n))
	liste = F_t(n);
	F_t_n = liste(i);
	if F_t_n > precision
		R(i) = 1;
	elseif F_t_n < -precision
		R(i) = -1;
	else
		R(i) = 0;
	end
end
plot(t, F_t(n))
hold on
plot(t, R)
% R(t) is the recived signal
yline(precision)
yline( -precision)
title("F(t), n = " + n + ", R(t), precision = " + precision)

% =================================================================================================================== %
%                                                                                                                     %
%                                                      Amusement                                                      %
%                                                                                                                     %
% =================================================================================================================== %