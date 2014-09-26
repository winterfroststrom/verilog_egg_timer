module RunningRegister(
  input reset,
  input [3:0] setting,
  input isSetting,
  input isStarting,
  input isDecrement,
  input isZero,
  input isDone,
  input [3:0] wrap,
  input clk,
  output [3:0] running
);
  parameter zero = 4'b000, one = 4'b0001;

  wire [3:0] value;
  assign value =
    isSetting ? setting :
	 (isDecrement & isZero & isDone) ? zero :
	 (isDecrement & isZero) ? wrap :
	 (isDecrement) ? running - one :
    running;	 
  
  Register #(4) register0(reset, value, clk, running);

endmodule
