clc

% here, True is 1 and False is 0

A = [1, 2, 3, 4, 5];
n_A = size(A, 2);

B = [1, 2, 3, 100, 4, 5];
n_B = size(B, 2);

% variables
i = 1;
j = 1;
k = 0;

while i < = n_A && k < = 1 && j < = n_B
	if A(i) == B(j)
		i = i + 1;
	else
		k = k + 1;
	end
	j = j + 1;
end

disp("i > n_A")
disp(i > n_A)

disp("k == 1")
disp(k == 1)

disp("j > n_B")
disp(j > n_B)

disp("(i > n_A) && (k == 1) && (j > n_B)")
disp((i > n_A) && (k == 1) && (j > n_B))

% the two vectors have to be exactly the same, but with one element added into one of the two vectors