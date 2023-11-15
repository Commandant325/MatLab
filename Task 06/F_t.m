function [F_t_n] = F_t(n)
	% this function gives the F vector, by summing the y function

	t = - 1 : 0.01 : + 1; % we have to reuse "t" here

	F = zeros(1, length(t)); % create the array F(t)

	for k = 1 : n
		F = F + y_t(k);
	end

	F_t_n = F;

end
