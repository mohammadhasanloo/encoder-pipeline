`timescale 1ns/1ns
module colParity_controller(clk, rst, start, co_c64, co_c25, ld_curr_fr, ld_prev_fr, ld_r, en_fw, init0_c64, init0_c25, en_c64, en_c25, ready);
  
  input clk;
  input rst;
  input start;
  input co_c64;
  input co_c25;
  output reg ld_curr_fr;
  output reg ld_prev_fr;
  output reg ld_r;
  output reg en_fw;
  output reg init0_c64;
  output reg init0_c25;
  output reg en_c64;
  output reg en_c25;
  output reg ready;
  
					
	reg [3:0] ps, ns;
	parameter [3:0] 
	Idling = 0, Sting = 1, Rding1 = 2, Rding2 = 3, Par_calc = 4, Done = 5;
	always@(ps, start, co_c64, co_c25) begin
		ns = Idling;
		{ld_curr_fr, ld_prev_fr, ld_r, en_fw, init0_c64, init0_c25, en_c64, en_c25, ready} = 8'b0;
			case(ps)
				Idling: begin ns = (start) ? Sting : Idling; end
				Sting: begin ns = (~start) ? Rding1 : Sting; init0_c64 = 1; end
				Rding1: begin ns = (~co_c64) ? Rding2 : Done; ld_prev_fr = 1; en_c64 = 1; end
				Rding2: begin ns = Par_calc; ld_curr_fr = 1; ld_r = 1; init0_c25 = 1; end
				Par_calc: begin ns = (~co_c25) ? Par_calc : Rding1; en_c25 = 1; en_fw = 1; end
				Done: begin ns = Idling; ready = 1; end
				default: ns = Idling;
			endcase
	end
	
	always@(posedge clk, posedge rst) begin
		if (rst) ps <= Idling;
		else ps <= ns;
	end
	
endmodule

