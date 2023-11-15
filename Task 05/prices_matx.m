clc

syms price_wine price_cocktail % we declare a new equation system

first_order = 12 * price_wine + 8 * price_cocktail == 175; % first equation
second_order = 8 * price_wine + 15 * price_cocktail == 215.75; % second equation

matx = solve([first_order, second_order], [price_wine, price_cocktail]); % solvation

cocktail_price = round(matx.price_cocktail, 2)
wine_price = round(matx.price_wine, 2)
