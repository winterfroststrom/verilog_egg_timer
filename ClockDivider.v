module ClockDivider(
  input reset,
  input clk, 
  input writeEnable,
  output newClk
);
  parameter HALF_CYCLES = 25000000;
  
  wire [31:0] counter, valueCounter;
  wire valueNewClk;
  assign valueCounter = 
    (writeEnable & counter <= HALF_CYCLES - 2) ? counter + 1 :
    (writeEnable) ? 0 :
	 counter;
  assign valueNewClk =
    (writeEnable & counter <= HALF_CYCLES - 2) ? newClk :
    (writeEnable) ? ~newClk :
	 newClk;
  
  Register register0(reset, valueNewClk, clk, newClk);
  Register #(32) register1(reset, valueCounter, clk, counter);

endmodule
