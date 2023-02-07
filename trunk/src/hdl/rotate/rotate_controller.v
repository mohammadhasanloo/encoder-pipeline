`timescale 1ns/1ns
module rotate_controller(clk, rst, start, co_c64, co_c25, ld_curr_fr, ld_des_fr, en_fw, init0_c64, init0_c25, en_c64, en_c25, ready);
  
  input clk;
  input rst;
  input start;
  input co_c64;
  input co_c25;
  output reg ld_curr_fr;
  output reg ld_des_fr;
  output reg en_fw;
  output reg init0_c64;
  output reg init0_c25;
  output reg en_c64;
  output reg en_c25;
  output reg ready;
					
	reg [3:0] ps, ns;
	parameter [3:0] 
	Idling = 0, Sting = 1, Init = 2, Rding1 = 3, Rding2 = 4, rotate_cal1 = 5, rotate_cal2 = 6, Done = 7;
	always@(ps, start, co_c64, co_c25) begin
		ns = Idling;
		{ld_curr_fr, ld_des_fr, en_fw, init0_c64, init0_c25, en_c64, en_c25, ready} = 9'b0;
			case(ps)
				Idling: begin ns = (start) ? Sting : Idling; end
				Sting: begin ns = (~start) ? Init : Sting; init0_c64 = 1; end
				Init: begin ns = (~co_c64) ? Rding1 : Done; en_c64 = 1; init0_c25 = 1; end
				Rding1: begin ns = Rding2; ld_curr_fr = 1; end
				Rding2: begin ns = rotate_cal1; ld_des_fr = 1; end
			    rotate_cal1: begin ns = rotate_cal2; ld_des_fr = 1; en_c25 = 1; end
				rotate_cal2: begin ns = (~co_c25) ? rotate_cal1 : Init; en_fw = 1; end
				Done: begin ns = Idling; ready = 1; end
				default: ns = Idling;
			endcase
	end
	
	always@(posedge clk, posedge rst) begin
		if (rst) ps <= Idling;
		else ps <= ns;
	end
	
endmodule

