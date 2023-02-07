`timescale 1ns/1ns
`define EOF 32'hFFFF_FFFF 

module TB ();
    reg clk=1'b0, rst=1'b1, start=1'b0;
    wire ready;

    //PUT UUT here to test
    top_level UUT(.clk(clk), .rst(rst), .start(start), .done(ready));

    always #5 clk = ~clk;

    initial begin
        #30 rst = 1'b0;
        #30 start = 1'b1;
        #30 start = 1'b0;
        #3000100;
        $stop;
    end

endmodule