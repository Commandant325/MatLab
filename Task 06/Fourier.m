%% Part 1
clc
clf
clear

t = - 1 : 0.01 : + 1; % [ - 1, - 0.99, ... , 0, ... , 0.99, 1]
% the original " - 1 : 0.1 : + 1" was not precise enough

figure(1) % plot y(t) for k = 1, 2, 10

	plot(t, y_t(1), "b")
	hold on
	plot(t, y_t(2), "r")
	plot(t, y_t(10), "g")
	title("y(t), k = 1 (blue), 2 (red), 10 (green)")
	xlabel("time")
	ylabel("y(t)")


figure(2) % plot F(t) for n = 5, 15

	plot(t, F_t(5), "b")
	hold on
	plot(t, F_t(15), "r")
	title("F(t), n = 5 (blue), 15 (red)")
	xlabel("time")
	ylabel("F(t)")


figure(3) % Plot F(t) for n = 3 - > 1

	for k = 1 : 3
		plot(t, F_t(k))
		hold on
	end

	title("F(t), n = 3")
	xlabel("time")
	ylabel("F(t)")


figure(4) % Plot F(t) for n = 10 - > 1

	for k = 1 : 10
		plot(t, F_t(k))
		hold on
	end

	title("F(t), n = 10")
	xlabel("time")
	ylabel("F(t)")


figure(5) % Plot F(t) for n = 20 - > 1

	for k = 1 : 20
		plot(t, F_t(k))
		hold on
	end

	title("F(t), n = 20")
	xlabel("time")
	ylabel("F(t)")


%% Part 2


figure(6) % plot F(t) for n = 5

	plot(t, F_t(5))

	title("F(t), n = 5")
	xlabel("time")
	ylabel("F(t)")

% creation of the Fourier's transformation

transformation = fft(F_t(5), length(t));
% Fourier's transformation of F(t), n = 5

f = 1; % Hz

f = linspace( - f, f, length(t));
% the differents frequencies (used like "t" before)


figure(7) % plot the Fourier's frequency analysis of F(t), n = 5

	plot(f, abs(transformation))
	% we have o use "abs" to get the module of the complex values

	title("Amplitude(f)")
	xlabel("frequencies")
	ylabel("Amplitude")
	xlim([0, 1])
	% we limit the x - axis because the function is symetrical
