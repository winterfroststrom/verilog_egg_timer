module SynchronizeTwoClocks(
  input reset,
  input clkFast,
  input clkSlow,
  output out
);
  parameter zero = 1'b0, one = 1'b1;

  wire already;
  wire valueAlready, valueOut;
  assign valueAlready = clkSlow;
  assign valueOut =
    clkSlow ?
	   (already ? zero : one) :
    zero;

  Register register0(reset, valueAlready, clkFast, already);
  Register register1(reset, valueOut, clkFast, out);

endmodule
