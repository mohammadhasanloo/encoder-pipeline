`timescale 1ns/1ns
module revaluate_file_reader(clk, rst, ld, en_cnt, line_number, pout);
  
  parameter N = 25;
  input clk;
  input rst;
  input ld;
  input en_cnt;
  input [6 : 0] line_number;
  output reg [N-1:0] pout;
  
  integer data_file;  // file handler
  integer scan_file;  // file handler
  integer n;
  
  reg [N-1:0] captured_data;
  wire [5 : 0] new_line_number;
  assign new_line_number = en_cnt ? line_number : (line_number - 1);   

  always @(posedge clk, posedge rst) begin
	if(rst) 
      pout <= 0;
  else begin
    if(ld) begin
      //if (!$feof(data_file)) begin
        data_file = $fopen("file\\revaluateInput.txt", "r");
        //scan_file = $fscanf(data_file, "%b\n", captured_data); 
        //pout <= captured_data;
        for (n = 0; n < line_number; n = n + 1) begin
          scan_file = $fscanf(data_file, "%b\n", captured_data); 
          pout <= captured_data;
        end
        $fclose(data_file);
      //end
    end
  end
  end

endmodule

