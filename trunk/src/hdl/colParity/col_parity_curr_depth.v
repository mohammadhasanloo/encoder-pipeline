`timescale 1ns/1ns
module col_parity_curr_depth (pin, index, pout);
    
    parameter N = 25;
    input [N-1:0] pin;
    input [4 : 0] index;
    output pout;

    wire [4 : 0] last_col_index;
    wire [4 : 0] last_col;
    wire b1, b2, b3, b4, b5; 
    
    assign last_col_index = (index + 4) % 5;
    
    assign b1 = pin[24 - last_col_index];
    assign b2 = pin[24 - (last_col_index + 5)];
    assign b3 = pin[24 - (last_col_index + 10)];
    assign b4 = pin[24 - (last_col_index + 15)];
    assign b5 = pin[24 - (last_col_index + 20)];
    
    assign last_col = {b1, b2, b3, b4, b5};
    
    assign pout = ^last_col;

endmodule
