
close all;
clear all;
%% Explore carrier recovery plls

r = rng(5);
n_syms = 64;
data_rate = 10e6
symbol_order = 4;
M = log2(symbol_order); % Bits per symbol
sym_rate = data_rate/M; % 5M Symbols per Second

smp_per_sym = 16;
smp_rate = sym_rate*smp_per_sym;
Tb = 1/sym_rate;
Ts = 1/smp_rate;
t_sym = [1:n_syms]*Tb;
t_s = [1:n_syms*smp_per_sym]*Ts;
s_n = (randi(M, 1, n_syms)-((M+1)/2)) + i*(randi(M, 1, n_syms)-((M+1)/2));
x_n = upsample(s_n, smp_per_sym);
filt = rcosdesign(0.4, 4, 16);
%filt = (1/max(filt))*filt;
x_int = conv(x_n, filt);
x_n_nan = [zeros(1, 32) x_n zeros(1, 32)];
x_n_nan(x_n_nan == 0) = nan;
x_n_nan = [zeros(1, 32) x_n zeros(1, 32)];
x_n_nan_matched = [zeros(1, 64) x_n zeros(1, 64)];
x_n_nan_matched(x_n_nan_matched == 0) = nan;

analog_fps = 6.4e9; % DAC at 6.4Gsps (for matlab), Modulate at 1/4 cycles per sample, 1.6GHz
f_rf = analog_fps/4;
T_rf = 1/analog_fps;
digital_fps = smp_rate;
up_sample_rate = analog_fps/digital_fps;

x_int_up = upsample(x_int, floor(analog_fps/digital_fps));

h = intfilt(analog_fps/digital_fps, 4, 0.9);
x_rf = filter(h, 1, x_int_up);

t_rf = [0:length(x_rf)-1]*T_rf;
x_mod = exp(i*2*pi*f_rf.*t_rf);
x_t_mod = x_mod.*x_rf;



