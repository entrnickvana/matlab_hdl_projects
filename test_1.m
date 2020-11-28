

rnd = rand(1, 2000);
ac = zeros(1, 1000);
for ii = 1:1000
  ac(ii) = rnd*transpose(circshift(rnd,ii));
end