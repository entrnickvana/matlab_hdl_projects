

`timescale 1 ps / 1ps
import modem_pkg::*;
import dsp_utils_pkg::*;

module modem_top_tb;

   //logic [255:0] a;
   logic [1024-1:0] a;   
   integer	 x;
   modem m;
   integer seed = 16'hace1;
   logic   rnd_bits_q[$];
   dsp_utils d;
   real_q rq[];
   real_q aa;
   real_q bb;
   prbs_data r_prbs[];
   prbs_data r_p;   
   int r_seed = 12;
   
   
   
initial begin

   a = 0;
   x  = 16'hD008;
   m = new();
   d = new();
   rq = new[4];
   
   
   //d.read_coeff(1, "", "p_shape.csv", rq);
   ////d.read_coeff(4, "", "p_shape4.csv", rq);
   //
   //foreach(rq[ii]) begin
   //   foreach(rq[ii][jj]) begin
   //	 //$display("%7.2f", rq[ii][jj]);
   //	 $display("%f", rq[ii][jj]);	 
   //   end
   //end

   //r_prbs = new[64];
   //foreach(r_prbs[ii]) begin
   //   r_prbs[ii] = new();
   //   $urandom(r_seed);
   //   r_prbs[ii].randomize();
   //   $display("idx: %d, val: %d\n", ii, r_prbs[ii]);
   //end

   // Requres Verification license
   //r_p = new();
   //for(int ii = 0; ii < 64; ii++) begin
   //   r_p.randomize();
   //   $display("idx: %d, val: %d", ii, r_p);
   //end

   
   

   
   //bb.push_back(0.1);
   //$display("b: %7.2f", bb.pop_front());
   //
   //rq[0].push_back(0.1);
   //rq[0].push_back(0.2);
   //rq[0].push_back(0.3);
   //
   //rq[1].push_back(1.1);
   //rq[1].push_back(2.1);
   //rq[1].push_back(3.1);
   //
   //rq[2].push_back(10.1);
   //rq[2].push_back(20.1);
   //rq[2].push_back(30.1);
   //
   //foreach(rq[ii]) begin
   //   foreach(rq[ii][jj]) begin
   //	 $display("%7.2f", rq[ii][jj]);
   //   end
   //end
   
   
//   m.tx1.prbs_gen(16, 
//		  seed, 
//		  x, 
//		  a);
   
//  m.tx1.prbs_gen1(256,
//  		  16, 
//  		  seed, 
//  		  x, 
//  		  rnd_bits_q);

   
   //d.read_coeff(4, "file path", "file name", rq);
   //
   //foreach(rq[ii]) begin
   //   while(rq[ii].size() > 0) begin
   //	 $display("Pop: %d", rq[ii].pop_front());
   //   end
   //end

   

   
end


endmodule
   
