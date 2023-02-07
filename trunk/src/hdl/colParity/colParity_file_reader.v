`timescale 1ns/1ns
module colParity_file_reader(clk, rst, ld_curr_fr, ld_prev_fr, line_number, turn, pout);
  
  parameter N = 25;
  input clk;
  input rst;
  input ld_curr_fr;
  input ld_prev_fr;
  input [6 : 0] line_number;
  input [4:0] turn;
  output reg [N-1:0] pout;
  
  integer data_file;  // file handler
  integer scan_file;  // file handler
  integer n;
  
  reg [N-1:0] captured_data;
  wire [5 : 0] new_line_number;
  wire now_turn = turn;
  wire [8*18:0] in_file_name = (turn == 0) ? "file\\input_0.txt" : "file\\colPInput.txt"; 
  assign new_line_number = ((line_number - 2) % 64) + 1;
  

  always @(posedge clk, posedge rst) begin
    if(rst) 
        pout <= 0;
    else begin
      if(ld_curr_fr) begin
        data_file = $fopen(in_file_name, "r");
        for (n = 0; n < line_number; n = n + 1) begin
          scan_file = $fscanf(data_file, "%b\n", captured_data);
        end
        $fclose(data_file);
        pout <= captured_data;  
      end
      else if(ld_prev_fr) begin
        data_file = $fopen(in_file_name, "r");
        for (n = 0; n < new_line_number+1; n = n + 1) begin
          scan_file = $fscanf(data_file, "%b\n", captured_data);
        end
        $fclose(data_file);
        pout <= captured_data;    
      end  
    end
  end
  
endmodule

