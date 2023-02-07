`timescale 1ns/1ns
module rotate_co25 (clk, rst, init0, enc, cnt, co);
	
	parameter N = 5;
	input clk;
	input rst;
	input init0;
	input enc;
	output co;
	output reg [N-1:0] cnt;
	
	always @ (posedge clk, posedge rst) begin
		if (rst) 
			cnt <= 0;
		else
			if (init0 || co)
				cnt <= 0;
			else
				if (enc)
					cnt <= cnt + 1;
				else
					cnt <= cnt;
	end
	assign co = (cnt == 25) ? 1'b1 : 1'b0;
endmodule



