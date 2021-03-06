module imm_gen (inst, imm_sel, imm);
input [24:0] inst;				// inst [31:7] --> 25bit
input [2:0] imm_sel;
output [31:0] imm;

parameter [26:0] _27bit_1 = 27'b_11111_11111_11111_11111_11111_11;
parameter [19:0] _20bit_1 = 20'h_FFFFF;
parameter [18:0] _19bit_1 = 19'b_11111_11111_11111_1111;
parameter [10:0] _11bit_1 = 11'b_11111_11111_1;

wire [31:0] inst_ext, imm_000, imm_001, imm_010, imm_011, imm_100, imm_101, imm_110;
wire [31:0] imm;

//mo rong bit inst --> de~ lay cac gia tri cua imm
assign inst_ext = {inst, 7'b0};

assign imm_000 = (inst_ext[31]) ? {_20bit_1, inst_ext[31:20]} : {20'b0 ,inst_ext[31:20]};
assign imm_001 = {20'b0 ,inst_ext[31:20]};
assign imm_010 = (inst_ext[24]) ? {_27bit_1, inst_ext[24:20]} : {27'b0 ,inst_ext[24:20]};
assign imm_011 = (inst_ext[31]) ? {_20bit_1, inst_ext[31:25], inst_ext[11:7]} : {20'b0, inst_ext[31:25], inst_ext[11:7]};
assign imm_100 = (inst_ext[31]) ? {_19bit_1, inst_ext[31], inst_ext[7], inst_ext[30:25], inst_ext[11:8], 1'b0}
				: { 19'b0,   inst_ext[31], inst_ext[7], inst_ext[30:25], inst_ext[11:8], 1'b0};
assign imm_101 = {inst_ext[31:12], 12'b0};
assign imm_110 = (inst_ext[31]) ? {_11bit_1, inst_ext[31], inst_ext[19:12], inst_ext[20], inst_ext[30:21], 1'b0}
				: { 11'b0,   inst_ext[31], inst_ext[19:12], inst_ext[20], inst_ext[30:21], 1'b0};

assign imm = 	(imm_sel == 3'b000)? imm_000 : (
		(imm_sel == 3'b001)? imm_001 : (
		(imm_sel == 3'b010)? imm_010 : (
		(imm_sel == 3'b011)? imm_011 : (
		(imm_sel == 3'b100)? imm_100 : (
		(imm_sel == 3'b101)? imm_101 : (
		(imm_sel == 3'b110)? imm_110 : 32'h_xfff_xxxx))))));

endmodule
/*
000: Imm[31:20] extend sign
001: Imm[31:20] extend unsign
010: Imm[24:20] extend sign
011: Imm[31:25][12:8] extend sign
100: Imm[31][8][30:25][12:9]_0 extend sign
101: Imm[31:12])0000_0000_0000 
110: Imm[31][19:12][20][30:21]_0 extend sign
*/