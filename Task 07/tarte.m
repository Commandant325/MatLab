function [tarte_n] = tarte(n)

tarte_n = 0;

for k = 0 : n

	tarte_n = tarte_n + (4 / (8 * k + 1) - 2 / (8 * k + 4) - 1 / (8 * k + 5) - 1 / (8 * k + 6)) * ((1 / 16).^k);

end
