module wb_select (mem, alu, pc_plus_4, wb_sel, out);
input [31:0] mem, alu, pc_plus_4;
input [1:0] wb_sel;
output [31:0] out;

wire [31:0] out;

assign out = 	(wb_sel == 2'b00)? mem : (
		(wb_sel == 2'b01)? alu : (
		(wb_sel == 2'b10)? pc_plus_4 : 32'h_xxxx_xxxx));
endmodule
