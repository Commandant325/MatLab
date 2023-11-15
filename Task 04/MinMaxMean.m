function [maximum_value, minimum_value, mean_value] = MinMaxMean(vecteur)
% create the function, with the [outputs] and the (input)

% I consciously choose to display the vector at the beginning then the different values
vecteur

% this part will determine the maximum and minimum values
maximum_value = vecteur(1);
minimum_value = vecteur(1);

for i = 1 : length(vecteur) % for each value, check if it is larger

	if vecteur(i) > maximum_value

		maximum_value = vecteur(i);

	end

	if vecteur(i) < minimum_value % for each value, check if it is smaller

		minimum_value = vecteur(i);

	end

end

maximum_value
minimum_value

% finally, this part will calculate the mean
sum = 0;

for k = 1 : length(vecteur) % generate the sum for calculate the average

	sum = sum + vecteur(k);

end

mean_value = sum /length(vecteur) ;
mean_value

end
