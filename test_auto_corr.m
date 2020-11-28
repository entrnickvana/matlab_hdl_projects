len = 1024*8;
wdw = 128*8;

%s = sign(rand(1, len)-.5);

s = values;

padding = zeros(1, len);

x = [padding s padding];
y = zeros(1, (2*wdw)-1)

for ii = -1*wdw:1:wdw-1
	temp = circshift(x,ii);
	y(wdw+ii+1) = x(len+1:2*len+1)*transpose(temp(len+1:2*len+1))/((2*wdw)-1);
end

figure(1);
plot(y);

figure(2);
plot(abs(fft(y)));



