module StateMachine(
  input reset,
  input set,
  input run,
  input isZero,
  input clk,
  output isInit,
  output isSecond,
  output isMinute,
  output isStarting,
  output isStopping,
  output isFlashing
);
  parameter init  = 6'b000001,
            sec   = 6'b000010,
            min   = 6'b000100,
            start = 6'b001000,
            stop  = 6'b010000,
            done  = 6'b100000;

  reg [5:0] state = init;

  assign isInit     = state[0];
  assign isSecond   = state[1];
  assign isMinute   = state[2];
  assign isStarting = state[3];
  assign isStopping = state[4];
  assign isFlashing = state[5];

  always @ (posedge clk or posedge reset) begin 
    if (reset) begin
      state <= init;
    end else begin
      case (state)
        init: begin
			 state <= set ? sec : init;
		  end
        sec: begin
		    state <= set ? sec : min;
		  end
        min: begin
		    state <= run ? start : min;
		  end
        stop: begin
		    state <= isZero ? done : 
			          run ? start : stop;
		  end
        start: begin
		    state <= isZero ? done : 
			          run ? start : stop;
		  end
      endcase
    end
  end
endmodule
