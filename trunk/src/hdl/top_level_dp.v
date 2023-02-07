`timescale 1ns/1ns
module top_level_dp(clk, rst, start, init_c24, inc_c24, colParity_ready, rotate_ready, permute_ready, revaluate_ready,
 addRc_ready, co_c24);

    input clk;
    input rst;
    input start;
    input init_c24;
    input inc_c24;
    output colParity_ready;
    output rotate_ready;
    output permute_ready;
    output revaluate_ready;
    output addRc_ready;
    output co_c24;

    wire [4:0] cnt;
    reg start_colPartiy;
    always@(start, addRc_ready, cnt) begin
        if((start || addRc_ready) & (cnt+1)!=24)
            start_colPartiy <= 1'b1;
        else
            start_colPartiy <= 1'b0;

    end    
	wire colParity_ready, rotate_ready, permute_ready, revaluate_ready, addRc_ready;


    col_parity cp(.clk(clk), .rst(rst), .start(start_colPartiy), .turn(cnt), .ready(colParity_ready));
    rotate ro(.clk(clk), .rst(rst), .start(colParity_ready), .ready(rotate_ready));
    permute pe(.clk(clk), .rst(rst), .start(rotate_ready), .ready(permute_ready));
    revaluate re(.clk(clk), .rst(rst), .start(permute_ready), .ready(revaluate_ready));
    addRc rc(.clk(clk), .rst(rst), .turn(cnt), .start(revaluate_ready), .ready(addRc_ready));

    top_level_counter24 cntr(.clk(clk), .rst(rst), .init0(init_c24), .enc(addRc_ready), .cnt(cnt), .co(co_c24));
  
endmodule
