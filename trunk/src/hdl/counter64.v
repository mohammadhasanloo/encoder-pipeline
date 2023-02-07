`timescale 1ns/1ns
module counter64 (clk, rst, init0, enc, cnt, co);
	
	parameter N = 7;
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
			if (init0)
				cnt <= 0;
			else
				if (enc)
					cnt <= cnt + 1;
				else
					cnt <= cnt;
	end
	assign co = (cnt == 64) ? 1'b1 : 1'b0;
endmodule


