module PC (pc_in, clk, pc_out);
input [31:0] pc_in;
input clk;
output reg [31:0] pc_out;

initial begin
	#0 pc_out = 32'h0040_0000 - 4;
	end

always @(posedge clk) begin
	pc_out = pc_in;
	end

endmodule
