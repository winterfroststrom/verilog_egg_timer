module Register(
  input reset,
  input [n-1:0] in,
  input clk,
  output reg [n-1:0] out = 0
);
  parameter n = 1;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
	   out <= 0;
	 end else begin
	   out <= in;
    end
  end
  
endmodule