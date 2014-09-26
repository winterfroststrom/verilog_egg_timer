module DisplayByState(
  input [3:0] setting0,
  input [3:0] setting1,
  input [3:0] setting2,
  input [3:0] setting3,
  input [3:0] running0,
  input [3:0] running1,
  input [3:0] running2,
  input [3:0] running3,
  input isInit,
  input isSetting,
  input isRunning,
  output [6:0] display0,
  output [6:0] display1,
  output [6:0] display2,
  output [6:0] display3
);
  parameter zero = 4'b0000;

  wire [3:0] value0, value1, value2, value3;

  assign value0 =
	isSetting ? setting0 :
	isRunning ? running0 :
	zero;
  assign value1 =
	isSetting ? setting1 :
	isRunning ? running1 :
	zero;
  assign value2 =
	isSetting ? setting2 :
	isRunning ? running2 :
	zero;
  assign value3 =
	isSetting ? setting3 :
	isRunning ? running3 :
	zero;
	
  DecTo7Seg decTo7Sec1(value0, display0);
  DecTo7Seg decTo7Sec2(value1, display1);
  DecTo7Seg decTo7Sec3(value2, display2);
  DecTo7Seg decTo7Sec4(value3, display3);
endmodule