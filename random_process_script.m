clear all;
close all;
a = 64
b = -64

A = a-b;

L = 1024

t = 0:1/L:(1-(1/L));

x = A*rand(1,L)

figure
xlabel('Sample Index')
ylabel('Amplitude')
plot(t, x)

figure
y = distrib(x, a, b, 128);
plot(y)
