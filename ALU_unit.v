module ALU (in1, in2, ALU_sel, out);
input [31:0] in1, in2;
input [3:0] ALU_sel;
output [31:0] out;

wire [31:0] out;
parameter [3:0] 	ADD = 4'b0000, 
			SUB = 4'b0001, 
			SLL = 4'b0010, 
			SLT = 4'b0011, 
			SLTU= 4'b0100,
			XOR = 4'b0101,
			SRL = 4'b0110,
			SRA = 4'b0111,
			OR  = 4'b1000,
			AND = 4'b1001,
			EQU = 4'b1010;

wire [31:0] SRA_out;
shift_right_a	SR_A	(in1, in2, SRA_out);

assign out = 	(ALU_sel == ADD) ?  (in1 + in2) : (
		(ALU_sel == SUB) ?  (in1 - in2) : (
		(ALU_sel == SLL) ? ((in2[31:5] != 0) ? 32'b0 : (in1 << in2[4:0])) : (
		(ALU_sel == SLT) ? (($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0): (
		(ALU_sel == SLTU)? ((in1 < in2) ? 32'b1 : 32'b0) : (
		(ALU_sel == XOR) ?  (in1 ^ in2) : (
		(ALU_sel == SRL) ? ((in2[31:5] != 0) ? 32'b0 : (in1 >> in2[4:0])) : (
		(ALU_sel == SRA) ?   SRA_out : (
		(ALU_sel == OR)  ?  (in1 | in2) : (
		(ALU_sel == AND) ?  (in1 & in2) : (
		(ALU_sel == EQU) ?   in2 : 32'hxxxx_xxxx))))) )))));
endmodule

/*
reg signed [31:0] out;
always @(*) 
begin
	case (ALU_sel)
		ADD: out = in1 + in2;
		SUB: out = in1 - in2;
		SLL: out = (in2[31:5] != 0) ? 32'b0 : (in1 << in2[4:0]);
		SLT: out = ($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0;

		SLTU:out = (in1 < in2) ? 32'b1 : 21'b0;
		XOR: out = in1 ^ in2;
		SRL: out = (in2[31:5] != 0) ? 32'b0 : (in1 >> in2[4:0]);
		SRA: out = (in2[31:5] != 0) ? (in1[31]? 32'hFFFF_FFFF : 32'b0) : (in1 >>> in2[4:0]);
		OR:  out = in1 | in2;
		AND: out = in1 & in2;
	endcase
end

endmodule
*/