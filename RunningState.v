module RunningState(
  input reset,
  input [3:0] setting0,
  input [3:0] setting1,
  input [3:0] setting2,
  input [3:0] setting3,
  input isSetting,
  input isStarting,
  input isStopping,
  input isRunning,
  input clk,
  output [3:0] running0 = zero,
  output [3:0] running1 = zero,
  output [3:0] running2 = zero,
  output [3:0] running3 = zero,
  output isZero
);
  parameter zero = 4'b0000, one = 4'b001, five = 4'b0101, nine = 4'b1001;

  wire clkSeconds;
  ClockDivider #(25000000) clockDivider0(reset, clk, isStarting, clkSeconds);

  wire isZeroC;
  SynchronizeTwoClocks synchronizeTwoClocks(reset, clk, clkSeconds, isZeroC);

  wire isZero0, isZero1, isZero2, isZero3, isZeroValue;
  assign isZero0 = running0 == zero;
  assign isZero1 = running1 == zero;
  assign isZero2 = running2 == zero;
  assign isZero3 = running3 == zero;
  
  wire isZeroC0, isZeroC01, isZeroC012, isZero0123, isZero123, isZero23;
  assign isZeroC0 = isZeroC & isZero0;
  assign isZeroC01 = isZeroC & isZero0 & isZero1;
  assign isZeroC012 = isZeroC & isZero0 & isZero1 & isZero2;
  assign isZero0123 = isZero0 & isZero1 & isZero2 & isZero3;
  assign isZero123 = isZero1 & isZero2 & isZero3;
  assign isZero23 = isZero2 & isZero3;
  
  RunningRegister runningRegister0(
    reset, setting0, isSetting, isStarting,
	 isZeroC, isZero0, isZero123, nine,
    clk,
    running0
  );

  RunningRegister runningRegister1(
    reset, setting1, isSetting, isStarting,
	 isZeroC0, isZero1, isZero23, five,
    clk,
    running1
  );
  RunningRegister runningRegister2(
    reset, setting2, isSetting, isStarting,
	 isZeroC01, isZero2, isZero3, nine,
    clk,
    running2
  );
  RunningRegister runningRegister3(
    reset, setting3, isSetting, isStarting,
	 isZeroC012, isZero3, 1'b1, zero,
    clk,
    running3
  );
  Register register0(
    reset, isZero0123,
    clk,
	 isZero
  );
endmodule
