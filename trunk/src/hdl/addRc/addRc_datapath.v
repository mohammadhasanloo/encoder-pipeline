module addRc_datapath(clk, rst, start, ld_fr, en_fw, init0_c64, init0_c25, en_c64, en_c25, turn, co_c64, co_c25);

	input clk;
	input rst;
	input start;
	input ld_fr;
	input en_fw;
	input init0_c64;
	input init0_c25;
	input en_c64;
	input en_c25;
	input [4:0] turn;
	output co_c64;
	output co_c25;
	
	wire [24 : 0] FileR_out; 
	wire [6 : 0] cnt_c64;
	wire [4 : 0] cnt_c25;
	wire new_bit;
	
    reg [63:0] LUT [0:23];	
	initial begin
		LUT[0]  = 64'h0000000000000001;
		LUT[1]  = 64'h0000000000008082;
		LUT[2]  = 64'h800000000000808A;
		LUT[3]  = 64'h8000000080008000;
		LUT[4]  = 64'h000000000000808B;
		LUT[5]  = 64'h0000000080000001;
		LUT[6]  = 64'h8000000080008081;
		LUT[7]  = 64'h8000000000008009;
		LUT[8]  = 64'h000000000000008A;
		LUT[9]  = 64'h0000000000000088;
		LUT[10] = 64'h0000000080008009;
		LUT[11] = 64'h000000008000000A;
		LUT[12] = 64'h000000008000808B;
		LUT[13] = 64'h800000000000008B;
		LUT[14] = 64'h8000000000008089;
		LUT[15] = 64'h8000000000008003;
		LUT[16] = 64'h8000000000008002;
		LUT[17] = 64'h8000000000000080;
		LUT[18] = 64'h000000000000800A;
		LUT[19] = 64'h800000008000000A;
		LUT[20] = 64'h8000000080008081;
		LUT[21] = 64'h8000000000008080;
		LUT[22] = 64'h0000000080000001;
		LUT[23] = 64'h8000000080008008;
	end

    wire[63:0] RC = (LUT[turn]);
	
	addRc_file_reader FileR(
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
	
	wire test =  RC[64 - cnt_c64];
	wire bittest = FileR_out[24-cnt_c25];
	assign new_bit = (cnt_c25 == 12) ? FileR_out[24-cnt_c25] ^ RC[64 - cnt_c64] : FileR_out[24-cnt_c25];
	
 	addRc_file_writer FileW(
                   .clk(clk), 
                   .rst(rst), 
				   .start(start),
                   .en(en_fw), 
                   .pin(new_bit), 
                   .co_c25(co_c25),
				   .co_c64(co_c64)
                   );
	
endmodule
