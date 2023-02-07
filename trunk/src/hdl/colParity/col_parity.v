`timescale 1ns/1ns
module col_parity(clk, rst, start, turn, ready);
	
	input clk;
	input rst;
	input start;
	input [4:0] turn;
	
	output ready;
	
	wire ld_curr_fr, ld_prev_fr, ld_r, en_fw, init0_c64, init0_c25, en_c64, en_c25, co_c64, co_c25;
	
	colParity_datapath DP(
	           .clk(clk), 
	           .rst(rst), 
			   .start(start),
	           .ld_curr_fr(ld_curr_fr), 
	           .ld_prev_fr(ld_prev_fr), 
	           .ld_r(ld_r),
	           .en_fw(en_fw),
	           .init0_c64(init0_c64),
	           .init0_c25(init0_c25),
	           .en_c64(en_c64),
	           .en_c25(en_c25),
			   .turn(turn),
	           .co_c64(co_c64),
	           .co_c25(co_c25)
	           );
	
	colParity_controller CU(
	             .clk(clk), 
	             .rst(rst), 
	             .start(start), 
	             .co_c64(co_c64),
	             .co_c25(co_c25),
	             .ld_curr_fr(ld_curr_fr), 
	             .ld_prev_fr(ld_prev_fr), 
	             .ld_r(ld_r),
	             .en_fw(en_fw),
	             .init0_c64(init0_c64),
	             .init0_c25(init0_c25),
	             .en_c64(en_c64),
	             .en_c25(en_c25),
	             .ready(ready)
	             );
	             
endmodule
