module plus_4_pc (pc, pc_plus_4);
input [31:0] pc;
output [31:0] pc_plus_4;

wire [31:0] pc_plus_4;

assign pc_plus_4 = pc + 4;

endmodule
