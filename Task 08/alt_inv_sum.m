function [alt_inv_sum_n] = alt_inv_sum(n)

	sum = 0;
	for k = 1 : n
		sum = sum + (-1)^k / k;
	end
	alt_inv_sum_n = sum;

end