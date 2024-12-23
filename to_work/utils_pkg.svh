

package dsp_utils_pkg;
   
   //typedef real [3:0] re_4;
   //typedef real [2:0] re_3;
   //typedef real [1:0] re_2;
   //typedef real re_6[6];   
   //typedef real re_5[5];
   //typedef real re_4[4];
   //typedef real re_4[3];
   //typedef real re_3[2];
   //typedef real re_2[1];
   typedef real real_q[$];

   class prbs_data;
      rand logic[3:0] rand_data;

      constraint qam4_prbs {
        rand_data dist {0 := 0, [1:7] := 7, [8:15] := 0};
      }
   endclass : prbs_data;
   
   
//      
////      constraint qam4_prbs {
////	 0 := 0,
////	 1 := 1,
////	 2 := 1,
////	 3 := 1,
////	 4 := 1,
////	 5 := 1,
////	 6 := 1,
////	 7 := 1,
////	 8 := 0,
////	 9 := 0,
////	10 := 0,
////	11 := 0,
////	12 := 0,
////	13 := 0,
////	14 := 0,
////	15 := 0};
//
////      constraint qam16_prbs {
////	 0 := 0,
////	 1 := 1,
////	 2 := 1,
////	 3 := 1,
////	 4 := 1,
////	 5 := 1,
////	 6 := 1,
////	 7 := 1,
////	 8 := 1,
////	 9 := 1,
////	10 := 1,
////	11 := 1,
////	12 := 1,
////	13 := 1,
////	14 := 1,
////	15 := 1};
//	      
//   endclass : prbs_data
   
   
   
   class dsp_utils;
 
      function void read_coeff(input integer num_cols,
			       input string  file_path, 
			       input string  file_name, 
			       ref real_q real_arr[]);
	 

	 int file_id;
	 int num_read;
	 real real_tmp[4];

	 file_id = $fopen({file_path,file_name}, "r");
	 if(file_id == 0) begin
	    $display("Error, file open error, file_path: %s, file_name: %s", file_path, file_name); //
	    $finish;
	 end

	 while(!$feof(file_id)) begin
	   case(num_cols)
	     1: begin 
		//num_read = $fscanf(file_id, "%2.8f\n", real_tmp[0]);
		num_read = $fscanf(file_id, "%f\n", real_tmp[0]);
		real_arr[0].push_back(real_tmp[0]);
		end
	     2: begin 
		//num_read = $fscanf(file_id, "%2.8f %2.8f\n", real_tmp[0], real_tmp[1]);
		num_read = $fscanf(file_id, "%f,%f\n", real_tmp[0], real_tmp[1]);		
		real_arr[0].push_back(real_tmp[0]);
		real_arr[1].push_back(real_tmp[1]);		
		end
	     3: begin
		//num_read = $fscanf(file_id, "%2.8f %2.8f %2.8f\n", real_tmp[0], real_tmp[1], real_tmp[2]);
		num_read = $fscanf(file_id, "%f,%f,%f\n", real_tmp[0], real_tmp[1], real_tmp[2]);		
		real_arr[0].push_back(real_tmp[0]);
		real_arr[1].push_back(real_tmp[1]);
		real_arr[2].push_back(real_tmp[2]);				
		end
	     4: begin
		//num_read = $fscanf(file_id, "%2.8f %2.8f %2.8f %2.8f\n", real_tmp[0], real_tmp[1], real_tmp[2], real_tmp[3]);
		num_read = $fscanf(file_id, "%f,%f,%f,%f\n", real_tmp[0], real_tmp[1], real_tmp[2], real_tmp[3]);		
		real_arr[0].push_back(real_tmp[0]);
		real_arr[1].push_back(real_tmp[1]);
		real_arr[2].push_back(real_tmp[2]);
		real_arr[3].push_back(real_tmp[3]);						
		end
	   default: begin 
	      //num_read = $fscanf(file_id, "%2.8f", real_tmp[0]);
	      num_read = $fscanf(file_id, "%f", real_tmp[0]);	      
	      real_arr[0].push_back(real_tmp[0]);	      
	      end
	   endcase // case (num_cols)
	    
	 end // while (!$feof(file_id))

	 $fclose(file_id);
	 
      endfunction : read_coeff;
      
	 
   endclass : dsp_utils
   
endpackage : dsp_utils_pkg
