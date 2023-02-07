`timescale 1ns/1ns
module revaluate(clk, rst, start, ready);
	
	input clk;
	input rst;
	input start;
	
	output ready;
	
	wire ld_fr, en_fw, init0_c64, init0_c25, en_c64, en_c25, co_c64, co_c25;
	
	revaluate_datapath DP(
	           .clk(clk), 
	           .rst(rst), 
			   .start(start),
	           .ld_fr(ld_fr), 
	           .en_fw(en_fw),
	           .init0_c64(init0_c64),
	           .init0_c25(init0_c25),
	           .en_c64(en_c64),
	           .en_c25(en_c25),
	           .co_c64(co_c64),
	           .co_c25(co_c25)
	           );
	
	revaluate_controller CU(
	             .clk(clk), 
	             .rst(rst), 
	             .start(start), 
	             .co_c64(co_c64),
	             .co_c25(co_c25),
	             .ld_fr(ld_fr), 
	             .en_fw(en_fw),
	             .init0_c64(init0_c64),
	             .init0_c25(init0_c25),
	             .en_c64(en_c64),
	             .en_c25(en_c25),
	             .ready(ready)
	             );
	             
endmodule
