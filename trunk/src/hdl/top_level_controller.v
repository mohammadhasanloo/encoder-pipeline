`timescale 1ns/1ns
module top_level_controller(clk, rst, start, colParity_ready, rotate_ready, permute_ready, revaluate_ready,
 addRc_ready, co_c24, init_c24, inc_c24, ready);
  
    input clk;
    input rst;
    input start;
    input colParity_ready;
    input rotate_ready;
    input permute_ready;
    input revaluate_ready;
    input addRc_ready;
    input co_c24;
    output reg init_c24;
    output reg inc_c24;
    output reg ready;
					
    reg [3:0] ps, ns;
    parameter [3:0] 
     Idling = 0, Init = 1, colParity_turn = 2, rotate_turn = 3, permute_turn = 4, revaluate_turn = 5, addRc_turn = 6,  exit = 7;
    always@(ps, start, colParity_ready, rotate_ready, permute_ready, revaluate_ready, addRc_ready, co_c24) begin
        ns = Idling;
        {init_c24, inc_c24, ready} = 3'b0;
            case(ps)
                Idling: begin ns = (start) ? Init : Idling; ready = 1; end
                Init: begin ns = (~start) ? colParity_turn : Init; init_c24 = 1; end
                colParity_turn: begin ns = (~colParity_ready) ? colParity_turn : rotate_turn; end
                rotate_turn: begin ns = (~rotate_ready) ? rotate_turn : permute_turn; end
                permute_turn: begin ns = (~permute_ready) ? permute_turn : revaluate_turn; end
                revaluate_turn: begin ns = (~revaluate_ready) ? revaluate_turn : addRc_turn; end
                addRc_turn: begin ns = (~addRc_ready) ? addRc_turn : exit;  end
				//en_turn: begin ns = exit; inc_c24 = 1; end
                exit: begin ns = (~co_c24) ? colParity_turn : Idling; inc_c24 = 1; end // If top level doesn't work, try inc_c24 = 1; here.

                default: ns = Idling;
            endcase
    end

    always@(posedge clk, posedge rst) begin
        if (rst) ps <= Idling;
        else ps <= ns;
    end

endmodule