clc
clf

precision = 100;
% this value determines the accuracy of the result

x = linspace( - 10, 10, 100001);
% we have to put a very high value for linspace to prevent
% some gap during the calculations
y = x.^2;
y_fun = @(x) x.^2;
min = - 5;
max = 7.5;
interval = max - min;
int = 0;
dx = interval / precision;

plot(x, y, "b")
yline(0)
xline(min)
xline(max)
title("y(x)")
xlabel("x")
ylabel("y(x)")
legend("y(x)")

% here, we are using the rectangle method to find an
% aproximation of the integral of the function, then we
% compare with the exact value

for i = 0 : precision

	int = int + y(x == (min + i * dx)) * dx;
	% for each dx, we are computing the area of a
	% rectangle :
	% y(dx) * dx
	% height * width
	% we also have to add the dx to compute the next
	% rectangle

end

disp(" The aproximated value is : " + int + ", with a precison of " + precision)
disp(" The true value is : " + integral(y_fun, min, max))

% we can see that the values are relatively close, since
% calculating areas of rectangles is something easy and
% easly computable through a computer, it is a verry
% efficient way to get an aproximation
