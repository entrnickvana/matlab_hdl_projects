clear all;
close all;

shift_reg = zeros(1, 16);
seed = [1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0];

shift_reg = seed;

num_itr = 1000;
values = zeros(1, num_itr+2);
for kk = 1:16
  values(1) = values(1) + (2*seed(kk))^(kk-1);
end


figure(1)
subplot(2,2,1)
stem(shift_reg)
subplot(2,2,2)
stem(values)
hold on


for ii = 1:num_itr+1
	shift_reg = circshift(shift_reg, -1);
	shift_reg(14) = xor(shift_reg(16), shift_reg(14));
	shift_reg(13) = xor(shift_reg(16), shift_reg(13));
    shift_reg(11) = xor(shift_reg(16), shift_reg(13));

    for kk = 1:16
      values(ii+1) = values(ii+1) + (2*shift_reg(kk))^(kk-1);
    end
    
    if (mod(ii,10) == 0 )
      pause(.05);
      subplot(2,1,1)
      stem(shift_reg)
      subplot(2,1,2)
      stem(values)
    end

     
end


