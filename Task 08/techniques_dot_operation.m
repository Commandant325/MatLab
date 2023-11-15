clc
clear
disp(" == == == == Part 1 == == == == ")

n = 10;
m = 1 : n;

series_k = 0;


% first method > for loop

for k = 1 : n

	series_k = series_k + k;

end

first_series_k = series_k


% second method > sum()

second_series_k = sum(m)


verification = (n * (n + 1)) / 2

%% 2 Exo 8.2
disp(" == == == = Part 2 == == == = ")

% == inv_sum(n) ==

% first method > for loop

first_inv_sum_n = inv_sum(n)


% second method > dot opreration + sum()

second_inv_sum_n = sum(1 ./ m)


% == alt_inv_sum(n) ==

% first method > for loop

first_alt_inv_sum = alt_inv_sum(n)

% second method > dot operation + sum()

second_alt_inv_sum = sum(( - 1).^m ./ m)


%% 3 Exo 8.3
disp(" == == == = Part 3 == == == = ")

% == series_inv ==

series_inv = 0;

% first method > for loop with accumulator

for k = 1 : n

	series_inv = series_inv + 1 / k;

end

first_series_inv = series_inv

% second method > for loop without accumulator

for k = 1 : n

	series_inv(k) = 1 / k;

end

second_series_inv = sum(series_inv)

% third method > sum()

third_series_inv = inv_sum(n) % un peu illégal ici : ç


% == series_inv_alt ==

% first method > for loop with accumulator

series_inv_alt = 0;

for k = 1 : n

	series_inv_alt = series_inv_alt + ( - 1)^k / k;

end

first_series_inv_alt = series_inv_alt

% second method > for loop without accumulator

for k = 1 : n

	series_inv_alt(k) = ( - 1)^k / k;

end

second_series_inv_alt = sum(series_inv_alt)

% third method > sum

third_series_inv_alt = alt_inv_sum(n)
