`timescale 1ns/1ns
module revaluate_datapath(clk, rst, start, ld_fr, en_fw, init0_c64, init0_c25, en_c64, en_c25, co_c64, co_c25);

	input clk;
	input rst;
	input start;
	input ld_fr;
	input en_fw;
	input init0_c64;
	input init0_c25;
	input en_c64;
	input en_c25;
	output co_c64;
	output co_c25;
	
	wire [24 : 0] FileR_out; 
	wire [6 : 0] cnt_c64;
	wire [4 : 0] cnt_c25;
	wire new_bit;
	
	revaluate_file_reader FileR(
        .clk(clk), 
        .rst(rst), 
        .ld(ld_fr),
		.en_cnt(en_c64),
        .line_number(cnt_c64), 
        .pout(FileR_out)
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
	
	
	wire current_cell = FileR_out[24 - cnt_c25];
	wire [2:0] x = cnt_c25 % 5;
	wire [2:0] y = cnt_c25 / 5;
	wire next_cell = FileR_out[24 - (5*y + ((x + 1) % 5)) ];
	wire next_next_cell = FileR_out[24 - (5*y + ((x + 2) % 5))];
	assign new_bit = current_cell ^ (~next_cell & next_next_cell) ;
	
    revaluate_file_writer FileW(
                    .clk(clk), 
                    .rst(rst), 
					.start(start),
                    .en(en_fw), 
                    .pin(new_bit), 
                    .co_c25(co_c25),
					.co_c64(co_c64)
                    );
	
endmodule
