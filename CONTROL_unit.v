module control_logic (inst, BrEq, BrLt, data_out);
input [31:0] inst;
input BrEq, BrLt;
output reg [14:0] data_out;

// data_out la ngo ra 15bit : {pc_sel, imm_sel, reg_wen, BrUn, B_sel, A_sel, ALU_sel, MEM_RW, wb_sel}

initial begin
	#0 data_out = 15'b0;
	end

// R instruction:
parameter [4:0] R_type = 5'b01100;
parameter [3:0] ADD = 4'b_0_000;
parameter [3:0]	SUB = 4'b_1_000;
parameter [3:0]	SLL = 4'b_0_001; 
parameter [3:0]	SLT = 4'b_0_010;
parameter [3:0]	SLTU= 4'b_0_011;
parameter [3:0]	XOR = 4'b_0_100;
parameter [3:0]	SRL = 4'b_0_101;
parameter [3:0]	SRA = 4'b_1_101;
parameter [3:0]	OR  = 4'b_0_110;
parameter [3:0]	AND = 4'b_0_111;

// I instruction:
parameter [4:0] I_type_Logic = 5'b_00100;
parameter [2:0] ADDI = 3'b_000;
parameter [2:0] SLTI = 3'b_010;
parameter [2:0] SLTIU= 3'b_011;
parameter [2:0] XORI = 3'b_100;
parameter [2:0] ORI  = 3'b_110;
parameter [2:0] ANDI = 3'b_111;
parameter [2:0] SLLI = 3'b_001;
parameter [2:0] SR   = 3'b_101;  // SRLI , SRAI <-- inst[30]

parameter [4:0] I_type_Load  = 5'b_00000;
parameter [2:0] LB  = 3'b_000;
parameter [2:0] LH  = 3'b_001;
parameter [2:0] LW  = 3'b_010;
parameter [2:0] LBU = 3'b_100;
parameter [2:0] LHU = 3'b_101;

// S instruction:
parameter [4:0] S_type = 5'b_01000;
parameter [2:0] SB  = 3'b_000;
parameter [2:0] SH  = 3'b_001;
parameter [2:0] SW  = 3'b_010;

// B instruction:
parameter [4:0] B_type = 5'b_11000;
parameter [2:0] BEQ  = 3'b_000;
parameter [2:0] BNE  = 3'b_001;
parameter [2:0] BLT  = 3'b_100;
parameter [2:0] BGE  = 3'b_110;		// Bien dich tu file rars bi loi 2 lenh: BEG & BLTU
parameter [2:0] BLTU = 3'b_101;
parameter [2:0] BGEU = 3'b_111;

// U instruction:
parameter [4:0] LUI   = 5'b01101;
parameter [4:0] AUIPC = 5'b00101;

// J instruction:
parameter [4:0] JAL  = 5'b11011;
parameter [4:0] JALR = 5'b11001;

always @(*) begin
	case (inst[6:2])
	//R type:
	R_type:	case ({inst[30], inst[14:12]})
			ADD : data_out = 15'b_0_xxx_1_x_0_0_0000_0_01;
			SUB : data_out = 15'b_0_xxx_1_x_0_0_0001_0_01;
			SLL : data_out = 15'b_0_xxx_1_x_0_0_0010_0_01;
			SLT : data_out = 15'b_0_xxx_1_x_0_0_0011_0_01;
			SLTU: data_out = 15'b_0_xxx_1_x_0_0_0100_0_01;
			XOR : data_out = 15'b_0_xxx_1_x_0_0_0101_0_01;
			SRL : data_out = 15'b_0_xxx_1_x_0_0_0110_0_01;
			SRA : data_out = 15'b_0_xxx_1_x_0_0_0111_0_01;
			OR  : data_out = 15'b_0_xxx_1_x_0_0_1000_0_01;
			AND : data_out = 15'b_0_xxx_1_x_0_0_1001_0_01;
		endcase
	I_type_Logic:	case (inst[14:12])
				ADDI : data_out = 15'b_0_000_1_x_1_0_0000_0_01;
				SLTI : data_out = 15'b_0_000_1_x_1_0_0011_0_01;
				SLTIU: data_out = 15'b_0_001_1_x_1_0_0100_0_01;
				XORI : data_out = 15'b_0_000_1_x_1_0_0101_0_01;
				ORI  : data_out = 15'b_0_000_1_x_1_0_1000_0_01;
				ANDI : data_out = 15'b_0_000_1_x_1_0_1001_0_01;
	
				SLLI : data_out = 15'b_0_010_1_x_1_0_0010_0_01;
				SR   :  case (inst[30])
						0: data_out = 15'b_0_010_1_x_1_0_0110_0_01;
						1: data_out = 15'b_0_010_1_x_1_0_0111_0_01;
					endcase
			endcase

	I_type_Load:	case (inst[14:12])
				LB : data_out = 15'b_0_000_1_x_1_0_0000_0_00;
				LH : data_out = 15'b_0_000_1_x_1_0_0000_0_00;
				LW : data_out = 15'b_0_000_1_x_1_0_0000_0_00;
				LBU: data_out = 15'b_0_000_1_x_1_0_0000_0_00;
				LHU: data_out = 15'b_0_000_1_x_1_0_0000_0_00;
			endcase

	S_type:	case (inst[14:12])
			SB: data_out = 15'b_0_011_0_x_1_0_0000_1_xx;
			SH: data_out = 15'b_0_011_0_x_1_0_0000_1_xx;
			SW: data_out = 15'b_0_011_0_x_1_0_0000_1_xx;
		endcase
	
	B_type:	case (inst[14:12])
			BEQ : 	case (BrEq)
					0: data_out = 15'b_0_100_0_x_1_1_0000_0_xx;
					1: data_out = 15'b_1_100_0_x_1_1_0000_0_xx;
				endcase
			BNE :	case (BrEq)
					0: data_out = 15'b_1_100_0_x_1_1_0000_0_xx;
					1: data_out = 15'b_0_100_0_x_1_1_0000_0_xx;
				endcase
			BLT :	case (BrLt)
					0: data_out = 15'b_0_100_0_0_1_1_0000_0_xx;
					1: data_out = 15'b_1_100_0_0_1_1_0000_0_xx;
				endcase
			BGE :	case (BrLt)
					0: data_out = 15'b1_100_0_0_1_1_0000_0_xx;	// lon hon
					1: data_out = 15'b0_100_0_0_1_1_0000_0_xx;	// nho hon
				endcase
			BLTU:	case (BrLt)
					0: data_out = 15'b_0_100_0_1_1_1_0000_0_xx;
					1: data_out = 15'b_1_100_0_1_1_1_0000_0_xx;
				endcase
			BGEU:	case (BrLt)
					0: data_out = 15'b_1_100_0_1_1_1_0000_0_xx;
					1: data_out = 15'b_0_100_0_1_1_1_0000_0_xx;
				endcase
		endcase

	LUI:   data_out = 15'b_0_101_1_x_1_x_1010_0_01;
	AUIPC: data_out = 15'b_0_101_1_x_1_1_0000_0_01;
	
	JAL:   data_out = 15'b_1_110_1_x_1_1_0000_0_10;
	JALR:  data_out = 15'b_1_000_1_x_1_0_0000_0_10;

	endcase
	end

endmodule
