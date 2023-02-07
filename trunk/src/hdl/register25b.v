`timescale 1ns/1ns
module register25b(clk, rst, ld, regin, regout);
  
  parameter N = 25;
  input clk;
  input rst;
  input ld;
  input [N - 1:0] regin;
  output reg [N - 1:0] regout;
  
	always @ (posedge clk, posedge rst) begin
		if (rst)
			regout <= 0;
		else	begin
			if (ld)
				regout <= regin;
		end
	end
endmodule
