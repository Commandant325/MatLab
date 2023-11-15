clc
clf
clear
load("Capacitor.mat")

Capacitor(t, Q)

y = 0;
t_i = [0.25, 3.006, 7, 9.99];

getValues(Q, t, t_i)
% outputs the values of Q(t), for t = 0.25, 3.006, 7 and 9.99