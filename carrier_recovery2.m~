
close all;
clear all;
%% Explore carrier recovery plls

r = rng(5);
n_syms = 64;
data_rate = 10e6
symbol_order = 4;
M = log2(symbol_order); % Bits per symbol
sym_rate = data_rate/M; %10Mbps

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
x_t = conv(x_n, filt);
x_n_nan = [zeros(1, 32) x_n zeros(1, 32)];
x_n_nan(x_n_nan == 0) = nan;
x_n_nan = [zeros(1, 32) x_n zeros(1, 32)];
x_n_nan_matched = [zeros(1, 64) x_n zeros(1, 64)];
x_n_nan_matched(x_n_nan_matched == 0) = nan;

figure; subplot(311); stem(s_n); subplot(312); stem(x_n); subplot(313); plot(real(x_t)); hold on; stem(x_n_nan); hold off;
figure; subplot(311); stem(s_n); subplot(312); stem(x_n); subplot(313); plot(real(conv(filt, x_t))); hold on; stem(x_n_nan_matched); hold off;

f_rf = smp_rate*4;
t_rf = [0:length(x_t)-1]*(1/(4*f_rf));
%t_rf = [1:n_syms*smp_per_sym*4]*T_rf;
x_mod = exp(i*2*pi*f_rf.*t_rf);
x_mod_16 = 16*exp(i*2*pi*f_rf.*t_rf);
x_rf = x_t.*x_mod;
x_rf_16 = x_t.*x_mod_16;



figure; stem(real(x_mod(1:64))); hold on; plot(real(x_mod(1:64)));

