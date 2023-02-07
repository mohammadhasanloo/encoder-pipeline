`timescale 1ns/1ns
module colParity_datapath(clk, rst, start, ld_curr_fr, ld_prev_fr, ld_r, en_fw, init0_c64, init0_c25, en_c64, en_c25, turn, co_c64, co_c25);

	input clk;
	input rst;
	input start;
	input ld_curr_fr;
	input ld_prev_fr;
	input ld_r;
	input en_fw;
	input init0_c64;
	input init0_c25;
	input en_c64;
	input en_c25;
	input [4:0] turn;
	output co_c64;
	output co_c25;

  wire [24 : 0] FileR_out; 
  wire [24 : 0] Reg_out; 
  wire [6 : 0] cnt_c64;
  wire [4 : 0] cnt_c25;
  wire ColParCurrDepth_out;
  wire ColParPreDepth_out;
  wire finalXOR;
             
  colParity_file_reader FileR(
                    .clk(clk), 
                    .rst(rst), 
					.ld_curr_fr(ld_curr_fr),
                    .ld_prev_fr(ld_prev_fr),
                    .line_number(cnt_c64), 
					.turn(turn),
                    .pout(FileR_out)
                    );                

  register25b Reg(
                  .clk(clk), 
                  .rst(rst), 
                  .ld(ld_r),
                  .regin(FileR_out), 
                  .regout(Reg_out)
                  );
  
  counter64 Cntr64(
                  .clk(clk), 
                  .rst(rst), 
                  .init0(init0_c64), 
                  .enc(en_c64),
                  .cnt(cnt_c64),
                  .co(co_c64)
                  );
  
  counter25 Cntr25(
                  .clk(clk), 
                  .rst(rst), 
                  .init0(init0_c25), 
                  .enc(en_c25), 
                  .cnt(cnt_c25),
                  .co(co_c25)
                  );            


  col_parity_curr_depth ColParCurrDepth(
                                	       .pin(FileR_out), 
                                	       .index(cnt_c25), 
                                	       .pout(ColParCurrDepth_out)
                                	       );
  
  col_parity_pre_depth ColParPreDepth(
                                	       .pin(Reg_out), 
                                	       .index(cnt_c25), 
                                	       .pout(ColParPreDepth_out)
                                	       );
                                	       
  assign finalXOR = FileR_out[24 - cnt_c25] ^ ColParCurrDepth_out ^ ColParPreDepth_out;
  
  colParity_file_writer FileW(
                    .clk(clk), 
                    .rst(rst), 
					.start(start),
                    .en(en_fw), 
                    .pin(finalXOR), 
                    .co_c25(co_c25),
					.co_c64(co_c64)
                    );
  
endmodule
