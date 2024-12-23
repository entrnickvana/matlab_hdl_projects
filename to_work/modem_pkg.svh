

package modem_pkg;

   class tx;
      function void prbs_gen(input integer num_taps, 
			input integer seed,
			input integer poly,
			ref logic[1024-1:0]  bits_out);

	 logic[16-1:0] taps;
	 logic[16-1:0] seed_bits = seed;
	 logic[16-1:0] poly_taps = poly;
	 logic[16-1:0] l16_q[$];
	 logic [16-1:0]	tmp = 0;

	 taps = seed_bits;
	 bits_out[0] = seed_bits[0];
	 tmp = seed_bits;
	 //for(int jj = 0; jj < bits_out.size(); jj++) begin
	 for(int jj = 0; jj < 1024; jj++) begin	    
	   for(int ii = num_taps-2; ii > -1; ii--) begin
	      if(poly_taps[ii] == 1) begin
	         tmp[ii] = taps[ii+1] ^ taps[0];
	      end else begin
		 tmp[ii] = taps[ii+1];
	      end
	   end
	   tmp[15] = taps[0];
	   taps = tmp;
	   bits_out[jj] = taps[0];
	 end 

	 //for(int ii = 0; ii < bits_out.size(); ii++ ) begin
	 for(int ii = 0; ii < 1024; ii++ ) begin	    
	    $display("bits_out[%d]: %d", ii, bits_out[ii]);
	    tmp[(ii%16)] = bits_out[ii];
	    if(ii%16 == 0) begin
	      l16_q.push_back(tmp);
	    end
	 end

	 foreach(l16_q[ii]) begin
	    $display("q[%d]: %d", ii, l16_q.pop_front());
	 end

      endfunction : prbs_gen;

      function void prbs_gen1(input integer len,
			      input integer num_taps, 
			      input integer seed,
			      input integer poly,
			      ref logic	    bits_out[$]);

	 logic[16-1:0] taps;
	 logic[16-1:0] seed_bits = seed;
	 logic[16-1:0] poly_taps = poly;
	 logic[16-1:0] l16_q[$];
	 logic [16-1:0]	tmp = 0;

	 taps = seed_bits;
	 bits_out.push_back(seed_bits[0]);
	 tmp = seed_bits;
	 //for(int jj = 0; jj < bits_out.size(); jj++) begin
	 for(int jj = 0; jj < len; jj++) begin	    
	   for(int ii = num_taps-2; ii > -1; ii--) begin
	      if(poly_taps[ii] == 1) begin
	         tmp[ii] = taps[ii+1] ^ taps[0];
	      end else begin
		 tmp[ii] = taps[ii+1];
	      end
	   end
	   tmp[15] = taps[0];
	   taps = tmp;
	   bits_out.push_back(taps[0]);
	 end 

	 //for(int ii = 0; ii < bits_out.size(); ii++ ) begin
	 for(int ii = 0; ii < len; ii++ ) begin	    
	    $display("bits_out[%d]: %d", ii, bits_out[ii]);
	    tmp[(ii%16)] = bits_out[ii];
	    if(ii%16 == 0) begin
	      l16_q.push_back(tmp);
	    end
	 end

	 foreach(l16_q[ii]) begin
	    $display("q[%d]: %d", ii, l16_q.pop_front());
	 end

      endfunction : prbs_gen1;
      
	 
   endclass : tx

   class rx;
      
   endclass : rx

   class modem;
      tx tx1;
      tx tx2;
      
      rx rx1;
      rx rx2;

      function void prbs_set(tx txr, rx rxr);
      endfunction : prbs_set
      
   endclass : modem
   
endpackage : modem_pkg
