clc

% 12 * price_wine + 8 * price_cocktail = 175; // first equation
% 8 * price_wine + 15 * price_cocktail = 215.75; // second equation

A = [12 8; 8 15]; % matrices declarations
% X = [price_wine; price_cocktail];
B = [175; 215.75];

% A * X = B
% inv(A) * A * X = inv(A) * B

X = inv(A) * B;

A * X - B;
% we check here if the inverse is working
% it shoukd outputs "0 0"

wine_price = X(1)
cocktail_price = X(2)
