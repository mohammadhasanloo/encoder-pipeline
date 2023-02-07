`timescale 1ns/1ns
module colParity_file_writer (clk, rst, start, en, pin, co_c25, co_c64);
  
  input clk;
  input rst;
  input start;
  input en;
  input pin;
  input co_c25;
  input co_c64;
  
  integer fd;         // file handler  
  
	always @(start) begin
		fd = $fopen("file\\rotateInput.txt", "w");
	end
	
  //initial begin
   // fd = $fopen(`OUTPUT_FILE, "w"); 
  //end

  always @(posedge clk) begin		
    if(en) begin
      $fwriteb(fd, pin);
    if(co_c25)
      $fdisplay(fd, "");  
	if(co_c64 & co_c25)
		$fclose(fd);
    end    
  end

endmodule
