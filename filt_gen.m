
close all;

max_clk_rate = 125e6;
clk_rate = 100e6;
data_rate = 10e6;
bits_per_symbol = 4;
smp_per_symbol = 16;
symbol_rate = data_rate/bits_per_symbol;
T_sym = 1/symbol_rate;

n = 1024;
n_sinc_filt = [0:n]-floor(n/2);
sinc_filt = 0.5*sinc((2/16)*n_sinc_filt);
wdw_width = 33;
filt_wdw = [-1*floor(wdw_width/2):floor(wdw_width/2)] + floor(n/2);
f1 = sinc_filt(filt_wdw+1);
if(1)
 figure
 subplot(211)
 stem(n_sinc_filt, sinc_filt);
 subplot(212)
 stem(f1);
end

