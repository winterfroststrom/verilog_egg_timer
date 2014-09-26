module TFlipFlop(reset, clk, tOut);
	input reset, clk;
	output tOut;
	reg tOut = 0;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			tOut <= 0;
		else 
			tOut <= ~tOut;
	end
endmodule
