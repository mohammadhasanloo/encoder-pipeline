`timescale 1ns/1ns

module top_level(
    input clk,
    input rst,
    input start,

    output done
);

    wire colParity_ready, rotate_ready, permute_ready, revaluate_ready, addRc_ready, co_c24, init_c24, inc_c24;


    top_level_controller CU(.clk(clk), .rst(rst), .start(start), .colParity_ready(colParity_ready), .rotate_ready(rotate_ready),
     .permute_ready(permute_ready), .revaluate_ready(revaluate_ready), .addRc_ready(addRc_ready), .co_c24(co_c24), .init_c24(init_c24),
      .inc_c24(inc_c24), .ready(done));

    top_level_dp DP(.clk(clk), .rst(rst), .start(start), .init_c24(init_c24), .inc_c24(inc_c24), .colParity_ready(colParity_ready), .rotate_ready(rotate_ready),
     .permute_ready(permute_ready), .revaluate_ready(revaluate_ready), .addRc_ready(addRc_ready), .co_c24(co_c24));

endmodule
