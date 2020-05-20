function [Y] = distrib( X, upper_bound, lower_bound, num_bins )

  domain_size = upper_bound - lower_bound; 
  bin_size = domain_size/num_bins

  while  rem(bin_size, 1) ~= 0
    if rem(bin_size, 1) ~= 0
    	upper_bound = upper_bound + 1;
    end

    domain_size = upper_bound - lower_bound; 
    bin_size = domain_size/num_bins;

    if rem(bin_size, 1) ~= 0
    	lower_bound = lower_bound + 1;
    end

    domain_size = upper_bound - lower_bound; 
    bin_size = domain_size/num_bins;
  end

  Y = zeros(1, num_bins);

bin_upper = bin_size;
bin_lower = 0;
for bin = 1:1:num_bins
  for idx = 0:1:bin_size-1
    bin + idx
	      X(bin + idx)
    if X(bin + idx) >= bin_lower && X(bin + idx) < bin_upper
	      Y(bin) = Y(bin) + 1;
    end
  end
end

end

