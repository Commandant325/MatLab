function [nth_value] = nth_value_Fibonacci_sequence(n)
% we consider here that the Fibonacci sequence starts from 0, 1, 1, 2 , 3...

if n == 1 % for 1 and 0 the sequence in not yet defined, we have to force these values

	nth_value = 0;
	return

elseif n == 2

	nth_value = 1;
	return

else

	seq_Fib = [0, 1]; % initiate the Fibonacci sequence

	for n = drange(1, n) % repeate until 49 (because it starts from 0)

		seq_Fib(n + 2) = seq_Fib(n + 1) + seq_Fib(n); % add the two previous terms

	end

	nth_value = seq_Fib(n);

end
