`timescale 1ns/1ns
module rotate(clk, rst, start, ready);
	
	input clk;
	input rst;
	input start;
	
	output ready;
	
	wire ld_curr_fr, ld_des_fr, en_fw, init0_c64, init0_c25, en_c64, en_c25, co_c64, co_c25;
	
	rotate_datapath DP(
	           .clk(clk), 
	           .rst(rst), 
			   .start(start),
	           .ld_curr_fr(ld_curr_fr),
			   .ld_des_fr(ld_des_fr),
	           .en_fw(en_fw),
	           .init0_c64(init0_c64),
	           .init0_c25(init0_c25),
	           .en_c64(en_c64),
	           .en_c25(en_c25),
	           .co_c64(co_c64),
	           .co_c25(co_c25)
	           );
	
	rotate_controller CU(
	             .clk(clk), 
	             .rst(rst), 
	             .start(start), 
	             .co_c64(co_c64),
	             .co_c25(co_c25),
	             .ld_curr_fr(ld_curr_fr),
				 .ld_des_fr(ld_des_fr),
	             .en_fw(en_fw),
	             .init0_c64(init0_c64),
	             .init0_c25(init0_c25),
	             .en_c64(en_c64),
	             .en_c25(en_c25),
	             .ready(ready)
	             );
	             
endmodule
