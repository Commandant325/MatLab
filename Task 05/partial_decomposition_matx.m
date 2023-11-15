clc

% I did a lot of calculations on paper, I only put the important steps and the results on this code


% y = (9 * x^2 - 12 * x - 56)/(x^3 - 6 * x2 + 3 * x + 10);

% x^3 - 6 * x + 3 * x + 10 = (x - X1) * (x - X2) * (x - X3) = E
% we now have to find X1, X2 and X3, after calculations, we find :
% E = x^3 - (X1 + X2 + X3) * x^2 + (X1 * X2 + X2 * X3 + X3 * X1) * x + ( - X1 * X2 * X3)

% so we have :
% X1 + X2 + X3 = 6
% X1 * X2 + X2 * X3 + X3 * X1 = 3
% - X1 * X2 * X3 = 10

% after solving, we have :
% X1 = 5
% X2 = 2
% X3 = - 1

% y = a / (x - X1) + b / (x - X2) + c / (x - X3)
% y = a / (x - 5) + b / (x - 2) + c / (x + 1)

% after developing the equation, we have :
% (a + b + c) * x^2 + ( - a - 4 * b - 7 * c) * x + (2 * a + 5 * b + 10 * c)

% so we have :
% f(a, b, c) = a + b + c
% g(a, b, c) = - a - 4 * b - 7 * c
% h(a, b, c) = - 2 * a - 5 * b + 10 * c

% but we know that :
% f(a, b, c) = 9
% g(a, b, c) = - 12
% h(a, b, c) = - 56

% so we have :
% a + b + c = 9
% - a - 4 * b - 7 * c = - 12
% - 2 * a - 5 * b + 10 * c = - 56

% we have to solve this system :

syms a b c % solve the last system, find a, b and c

equation_1 = a + b + c == 9;
equation_2 = - a - 4 * b - 7 * c == - 12;
equation_3 = - 2 * a - 5 * b + 10 * c == - 56;

matx = solve([equation_1, equation_2, equation_3], [a, b, c]);

a_value = round(matx.a) % we have to use "round" because the numbers are rationnals (109/18 etc.)
b_value = round(matx.b)
c_value = round(matx.c)
