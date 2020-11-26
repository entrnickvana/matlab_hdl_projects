clear all;
close all;

sr_len = 32;

shift_reg = zeros(1, 32);

seed = [1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ]

shift_reg = seed;
num_itr = 1000;
values = zeros(1, num_itr+2);
avg = zeros(1, num_itr+2);
auto_wdw = zeros(1, num_itr+2);
wdw = 256;
auto_window = zeros(1, wdw);

for kk = 1:sr_len
  values(1) = values(1) + (2*seed(kk))^(kk-1);
end



figure(1);
subplot(2,2,1);
stem(shift_reg);
subplot(2,2,2);
stem(values);
subplot(2,2,3);
stem(avg);
subplot(2,2,4);
stem(auto_wdw);




for ii = 1:num_itr+1

  shift_reg(1) = xor(xor(shift_reg(32), shift_reg(29)),xor(shift_reg(25),shift_reg(24)));
	shift_reg = circshift(shift_reg, 1);

    %Bit vector to integer
    for kk = 1:16
      values(ii+1) = values(ii+1) + (2*shift_reg(kk))^(kk-1);
    end

    
    if (ii > wdw)

      %Running average      
    	avg(ii) = sum(values(ii-wdw:ii))/wdw;

      %Autocorrelation for window      
      %auto_window = autocorr(values(ii-wdw:ii));
      for jj = 1:wdw
        auto_window(jj) = values(ii-wdw:ii)*transpose(circshift(values(ii-wdw:ii),jj));
      end
    end

    

    
    if (mod(ii,10) == 0 )
      pause(.05);
      subplot(2,2,1);
      stem(shift_reg);
      subplot(2,2,2);
      stem(values);
      subplot(2,2,3);
      stem(avg);
      subplot(2,2,4);
      stem(auto_window);
    end

     
end


