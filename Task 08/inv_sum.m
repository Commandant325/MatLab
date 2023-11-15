function [inv_sum_n] = inv_sum(n)

	sum = 0;
	for k = 1 : n
		sum = sum + 1 / k;
	end
	inv_sum_n = sum;

end
