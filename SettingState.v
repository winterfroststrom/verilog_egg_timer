module SettingState(
  input reset,
  input [7:0] in,
  input isSecond,
  input isMinute,
  input clk,
  output [3:0] out0,
  output [3:0] out1,
  output [3:0] out2,
  output [3:0] out3
);
  parameter zero = 4'b0000, five = 4'b0101, nine = 4'b1001;

  wire [3:0] lesserValue, greaterValue;
  assign lesserValue = in[3:0] > nine ? nine : in[3:0];
  assign greaterValue = in[7:4] > five ? five : in[7:4];

  wire [3:0] value0, value1, value2, value3;
  assign value0 = isSecond ? lesserValue : out0;
  assign value1 = isSecond ? greaterValue : out1;
  assign value2 = 
    isMinute ? lesserValue : 
	 isSecond ? zero :
	 out2;
  assign value3 = 
    isMinute ? greaterValue : 
	 isSecond ? zero :
	 out3;
  
  Register #(4) register0(reset, value0, clk, out0);
  Register #(4) register1(reset, value1, clk, out1);
  Register #(4) register2(reset, value2, clk, out2);
  Register #(4) register3(reset, value3, clk, out3);
  
endmodule
