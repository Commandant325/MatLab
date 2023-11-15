clc

F = [[0, 1],
	[1, 1]];

n = 3;

for i = 1 : n

	disp("F^" + i + " = ")
	disp(F^i)

end

disp("F^10 = ")
disp(F^10)

% we observe that the matrix is filled with Fibonacci numbers

% F^1 = [[0, 1],
%		[1, 1]]
% F^1 = [[Fibonacci(0), Fibonacci(1)],
%		[Fibonacci(1), Fibonacci(2)]]

% F^2 = [[1, 1],
%		[1, 2]]
% F^2 = [[Fibonacci(1), Fibonacci(2)],
%		[Fibonacci(2), Fibonacci(3)]]

% F^3 = [[1, 2],
%		[2, 3]]
% F^3 = [[Fibonacci(2), Fibonacci(3)],
%		[Fibonacci(3), Fibonacci(4)]]

% F^10 = [[34, 55],
%		 [55, 89]]
% F^10 = [[Fibonacci(9), Fibonacci(10)],
%		 [Fibonacci(10), Fibonacci(11)]]

% we can find this generalized form :

% F^n = [[Fibonacci(n - 1), Fibonacci(n)],
%		[Fibonacci(n), Fibonacci(n + 1)]]

% se we have :

% Fibonacci(n) = F^n[1, 2] or = F^n[2, 1], with F = [[0, 1],
%													[1, 1]];