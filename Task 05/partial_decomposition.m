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
% (a + b + c) * x^2 + ( - a - 4 * b - 7 * c) * x + ( - 2 * a - 5 * b + 10 * c)

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

A = [1 1 1; - 1 - 4 - 7; - 2 - 5 10]; % matrices declarations
% X = [a_value; b_value; c_value];
B = [9; - 12; - 56];

% A * X = B
% inv(A) * A * X = inv(A) * B

X = inv(A) * B;

round(A * X - B, 4);
% we check here if the inverse is working
% it shoukd outputs "0 0 0"

a_value = round(X(1))
b_value = round(X(2))
c_value = round(X(3))

% a = 6
% b = 5
% c = - 2

% verification

% (a + b + c) * x^2 + ( - a - 4 * b - 7 * c) * x + ( - 2 * a - 5 * b + 10 * c)
% (6 + 5 - 2) * x^2 + ( - 6 - 4 * 5 - 7 * ( - 2)) * x + ( - 2 * 6 - 5 * 5 + 10 * ( - 2))
% 9 * x^2 - 12 * x - 56

% we retrace our steps, it's good
