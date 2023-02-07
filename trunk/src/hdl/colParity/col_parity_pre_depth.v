`timescale 1ns/1ns
module col_parity_pre_depth (pin, index, pout);
    
    parameter N = 25;
    input [N-1:0] pin;
    input [4 : 0] index;
    output pout;

    wire [4 : 0] next_col_index;
    wire [4 : 0] next_col;
    wire b1, b2, b3, b4, b5; 
    
    assign next_col_index = (index + 1) % 5;
    
    assign b1 = pin[24 - next_col_index];
    assign b2 = pin[24 - (next_col_index + 5)];
    assign b3 = pin[24 - (next_col_index + 10)];
    assign b4 = pin[24 - (next_col_index + 15)];
    assign b5 = pin[24 - (next_col_index + 20)];
    
    assign next_col = {b1, b2, b3, b4, b5};
 
    assign pout = ^next_col;

endmodule
