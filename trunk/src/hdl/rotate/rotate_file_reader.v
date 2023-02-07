`timescale 1ns/1ns
module rotate_file_reader(clk, rst, ld_curr_fr, ld_des_fr, line_number, pout, index);
  
  parameter N = 25;
  input clk;
  input rst;
  input ld_curr_fr;
  input ld_des_fr;
  input [6 : 0] line_number;
  input [4 : 0] index;

  output reg [N-1:0] pout;
  

  reg [6:0] LUT [N-1:0];	
  initial begin
    LUT[12] = 0;
    LUT[17] = 36;
    LUT[22] = 3;
    LUT[2] = 41;
    LUT[7] = 18;

    LUT[13] = 1;
    LUT[18] = 44;
    LUT[23] = 10;
    LUT[3] = 45;
    LUT[8] = 2;

    LUT[14] = 62;
    LUT[19] = 6;
    LUT[24] = 43;
    LUT[4] = 15;
    LUT[9] = 61;

    LUT[10] = 28;
    LUT[15] = 55;
    LUT[20] = 25;
    LUT[0] = 21;
    LUT[5] = 56;

    LUT[11] = 27;
    LUT[16] = 20;
    LUT[21] = 39;
    LUT[1] = 8;
    LUT[6] = 14;
  end

  integer data_file;         // file handler   
  integer scan_file;         // file handler   
  integer n;
  


  reg [N - 1 : 0] captured_data;
  wire [6 : 0] new_line_number;
  assign new_line_number = ((line_number-1) - LUT[index]) % 64;
  
  always @(posedge clk, posedge rst) begin
    if(rst) 
        pout <= 0;
    else begin
      if(ld_curr_fr) begin
        data_file = $fopen("file\\rotateInput.txt", "r");
        for (n = 0; n < line_number; n = n + 1) begin
          scan_file = $fscanf(data_file, "%b\n", captured_data);
        end
        $fclose(data_file);
        pout <= captured_data;  
      end
      else if(ld_des_fr) begin
        data_file = $fopen("file\\rotateInput.txt", "r");
        for (n = 0; n < new_line_number + 1; n = n + 1) begin
          scan_file = $fscanf(data_file, "%b\n", captured_data);
        end
        $fclose(data_file);
        pout <= captured_data;    
      end  
    end
  end

endmodule

