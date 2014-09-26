module FlashingState(
  input reset,
  input isFlashing,
  input clk,
  output [9:0] lights
);
  parameter ones = 10'b1111111111, zeros = 10'b0000000000;

  wire newClk;
  ClockDivider #(12500000) halfSeconds(reset, clk, isFlashing, newClk);

  wire [9:0] value;
  assign value = lights == ones ? zeros : ones;
  
  Register #(10) register0(reset, value, newClk, lights);  
endmodule
