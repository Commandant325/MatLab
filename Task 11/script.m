clc
clear
load("Capacitor.mat")

% we reuse the file "getValues.m"from task 11,
% "Capacitor11.m" is adapted to this task

% the formula for the discharge of a capacitor is of
% the form : Q(t) = c * exp( - T * t), with T = R * C

% let t = 0,
% Q(0) = c * exp( - T * 0)
% Q(0) = c * 1
% Q(0) = c

% but we know that Q(0) = 5.1388, from
Q_0 = getValues(Q, t, 0)

% so
c = Q_0

% Q(t) = c * exp( - T * t)

% ln(Q(t)) = ln(c * exp( - T * t))
% ln(Q(t)) = ln(c) - T * t

% y(t) = m * t + b, with :
% y = ln(Q)
y = log(Q)
% m = - T
% b = ln(c)

% for t = 1, we have :
% y(1) = m * 1 + b
% y(1) = m + b
% m = y(1) - b

Q_1 = getValues(Q, t, 1)
ln_Q_1 = log(Q_1)
y_1 = ln_Q_1
% so Q(1) = 3.0679
% and y(1) = ln(Q(1)) = ln(3.0679) = 1.1210

% b = ln(c)
b = log(c) % and c = 5.1388
% b = 1.6368

% so we can calculate m
m = y_1 - b
% but m = - T so
T = - m

% let's find the slope
slope = (y(t == 2) - y(t == 0)) / (2 - 0)
% so slope = - 0.5007

% now we can plot the graph
figure(1)
plot(t, m * t + b, "b")
hold on
plot(t, log(Q), "r")
title("y(t) = m * t + b & Q(t)")
xlabel("t")
ylabel("y(t) & Q(t)")
legend("y(t) = > modelisation", "Q(t) = > real function")

% on the graph, we see that the modelisation y(t)
% follows the real function Q(t)

Q_formula = c * exp( - T * t);

% we can now plot the curve
Capacitor11(t, Q, Q_formula)