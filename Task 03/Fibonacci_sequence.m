clc

n = 50;
sequence_Fibonacci = [0, 1]; % initiate the Fibonacci sequence

for i = 2 : (n - 1) % repeate until 49 (because it starts from 0)
	sequence_Fibonacci(i + 1) = sequence_Fibonacci(i) + sequence_Fibonacci(i - 1); % add the two previous terms
end

sequence_Fibonacci % show the sequence in the console
