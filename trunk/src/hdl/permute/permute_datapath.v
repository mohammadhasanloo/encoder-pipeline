module permute_datapath(clk, rst, start, ld_fr, en_fw, init0_c64, init0_c25, en_c64, en_c25, co_c64, co_c25);

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
	
	
	reg [4:0] LUT [0:24];	
	initial begin
		LUT[0]  = 5'd4;
		LUT[1]  = 5'd5;
		LUT[2]  = 5'd11;
		LUT[3]  = 5'd17;
		LUT[4]  = 5'd23;
		LUT[5]  = 5'b00010;
		LUT[6]  = 5'd8;
		LUT[7]  = 5'd14;
		LUT[8]  = 5'd15;
		LUT[9]  = 5'd21;
		LUT[10] = 5'd0;
		LUT[11] = 5'd6;
		LUT[12] = 5'd12;
		LUT[13] = 5'd18;
		LUT[14] = 5'd24;
		LUT[15] = 5'd3;
		LUT[16] = 5'd9;
		LUT[17] = 5'd10;
		LUT[18] = 5'd16;
		LUT[19] = 5'd22;
		LUT[20] = 5'd1;
		LUT[21] = 5'd7;
		LUT[22] = 5'd13;
		LUT[23] = 5'd19;
		LUT[24] = 5'd20;
	end
	
	permute_file_reader FileR(
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
				  
				
	wire permute_cell = FileR_out[24 - LUT[cnt_c25]];
	
	permute_file_writer FileW(
					.clk(clk), 
					.rst(rst), 
					.start(start),
					.en(en_fw), 
					.pin(permute_cell), 
					.co_c25(co_c25),
					.co_c64(co_c64) 
					);
	
endmodule
