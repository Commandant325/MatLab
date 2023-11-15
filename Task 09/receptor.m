clc
clear

n = 3;
t = - 1 : 0.01 : + 1;
liste = F_t(n); % we have to use the Task 06 files "F_t.m" and "y_t.m"

	% It s much easier and more efficient to transmit the wave signal
% because in order to have a perfect square wave, we would have
% to add many high frequencies, which require all the more energy
% to be sent the higher they are.

	% So we settle for a handful of frequencies (3), but we can,
% without too much loss of precision, recreate the square signal
% from this signal.


for i = 1 : length(F_t(n))
	F_t_n = liste(i);
	if F_t_n > 0
		R(i) = 1;
	elseif F_t_n < - 0
		R(i) = - 1;
	else
		R(i) = 0;
	end
end

plot(t, F_t(n))
hold on
plot(t, R)
% R(t) is the recived signal
legend('Transmitted Signal F(t)', 'Restored Squared Signal R(t)');
