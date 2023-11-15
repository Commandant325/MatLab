clc

n = 10; % size of the array

vector = round(rand(1, n) * 100) % generate random array and show it
maximum = vector(1);
minimum = vector(1);

for i = 1 : length(vector) % repeat for all the array

	if vector(i) > maximum % try if the i th element is higher
		maximum = vector(i); % redefine the maximun value if it is the case
	end

	if vector(i) < minimum
		minimum = vector(i);
	end

end

maximum
minimum
