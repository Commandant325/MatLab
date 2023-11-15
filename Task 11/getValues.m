function values = getValues(y, t, t_i)

	values = zeros(1, length(t_i));
	j = 1;
	for i = t_i
		if ismember(i, t) == 1 % means that "i" is in "t", "1" is "true"
			values(j) = y(t == i);
			% "t == i" returns the index of t, when t = i
			j = j + 1;
		else % means that "i" is not in "t", we will look for close elements
			i_round = round(i, 1);
			% we first round the value of i, then compute the average of the
			% two closest values of y(i)
			if i > i_round
				somme = y(t == i_round) + y(t == (i_round + 0.1));
				average = somme / 2;
			else
				somme = y(t == i_round) + y(t == (i_round - 0.1));
				average = somme / 2;
			end
			values(j) = average;
			j = j + 1;
		end
	end
	values;

end