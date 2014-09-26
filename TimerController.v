module TimerController(
  input CLOCK_50, 
  input [9:0] SW,	
  input [3:0] KEY,
  output [6:0] HEX0,
  output [6:0] HEX1,
  output [6:0] HEX2,
  output [6:0] HEX3,
  output [9:0] LEDR
);
  wire clk;
  assign clk = CLOCK_50;
  wire [7:0] switches;
  assign switches = SW[7:0];
  wire key0, key1, key2;
  assign key0 = ~KEY[0];
  assign key1 = ~KEY[1];
  assign key2 = ~KEY[2];
  
  wire isInit, isSecond, isMinute, isStarting, isStopping, isFlashing;
  wire isSetting;
  assign isSetting = isSecond | isMinute;
  wire isRunning;
  assign isRunning = isStarting | isStopping;  
  wire validKey2;
  assign validKey2 = key2 & (isMinute | isRunning);
  
  wire reset, set, run;
  assign reset = key0;
  TFlipFlop tFlipFlop1(reset, key1, set);
  TFlipFlop tFlipFlop2(reset, validKey2, run);

  wire isZero;
  
  StateMachine stateMachine(
    reset, set, run, isZero,
	clk,
	isInit, isSecond, isMinute, isStarting, isStopping, isFlashing
  );  

  wire [3:0] setting0, setting1, setting2, setting3;
  SettingState settingState(
    reset, switches, isSecond, isMinute,
    clk,
	setting0, setting1, setting2, setting3
  );

  wire [3:0] running0, running1, running2, running3;
  RunningState runningState(
    reset,
	 setting0, setting1, setting2, setting3,
	 isSetting, isStarting, isStopping, isRunning,
    clk,
    running0, running1, running2, running3, isZero
  );

  DisplayByState displayByState(
    setting0, setting1, setting2, setting3, running0, running1, running2, running3, isInit, isSetting, isRunning,
    HEX0, HEX1, HEX2, HEX3
  );

  FlashingState flashingState(
    reset, isFlashing,
	 clk,
	 LEDR
  );
endmodule
