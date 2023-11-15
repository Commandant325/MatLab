%% 1 Exo 7.2
clc

n = 20; % default value

% initialisation of the sequences
x(1) = 1;
y(1) = 0;
z(1) = 0; % maybe it should be - 1

% creation of the 3 vectors
for k = 2 : n
	x(k) = 2 * k - 1;
	y(k) = 2 * k;
	z(k) = ( - 1)^k;
end

% creation of "u" and "v" using "x", "y" and "z"
u = (2 * x.^2 + y.^2) ./ sqrt(10 + x .* y);

% v = ( - 1)^k * u < = > v = z * u
v = z .* u;

%% 2 Exo 7.2

a(1) = 1;

% creation of the sequence "a"
for k = 2 : n
	a(k) = 1 / k;
end

% b = ( - 1)^k * a < = > b = z * a
b = z .* a;

%% 3 Exo 7.3

tarte_1 = sprintf('%.15f', tarte(1))
tarte_3 = sprintf('%.15f', tarte(3))
tarte_10 = sprintf('%.15f', tarte(10))
tarte_20 = sprintf('%.15f', tarte(20))
tarte_100 = sprintf('%.15f', tarte(100))
% we need to use "sprintf" to display the first 15 decimals

% "tarte" converges to a value for a very large k
% this value seems to be "pi" ~3.141592, which sounds like "pie", "tarte" in French (^^)
