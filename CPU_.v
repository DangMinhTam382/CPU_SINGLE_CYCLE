module cpu;

reg clk;

wire [31:0] pc_in, pc_out, pc_plus_4, inst, imm, wb_out, DMEM_out;

wire [4:0]  addr_A, addr_B, addr_D;
wire [31:0] rs1_out, rs2_out, alu_mux1_out, alu_mux2_out, alu_out;

wire BrEq, BrLt;

wire [14:0] data_out;
wire pc_mux_sel;
wire [2:0]  imm_sel;
wire reg_WEn, BrUn, B_sel, A_sel;
wire [3:0]  ALU_sel;
wire MEM_RW;
wire [1:0]  wb_sel;

initial begin
	#0 clk = 0;
	forever begin
		#1 clk = ~clk;
		end 
	end

//-----------------------------------------------------------------------------------------------------------------------------------
PC 		khoi_pc (pc_in, clk, pc_out);

plus_4_pc 	Cong4_pc (pc_out, pc_plus_4);

IMEM 		khoi_IMEM (pc_out, inst);
	assign addr_D = inst[11:7];
	assign addr_A = inst[19:15];
	assign addr_B = inst[24:20];

control_logic 	khoi_Control (inst, BrEq, BrLt, data_out);	// data_out la ngo ra 15bit : {pc_sel, imm_sel, reg_wen, BrUn, B_sel, A_sel, ALU_sel, MEM_RW, wb_sel}
	// tach data_out thanh cac wire rieng 
	assign pc_mux_sel= data_out [14];
	assign imm_sel   = data_out [13:11];
	assign reg_WEn   = data_out [10];
	assign BrUn      = data_out [9];
	assign B_sel     = data_out [8];
	assign A_sel  	 = data_out [7];
	assign ALU_sel 	 = data_out [6:3];
	assign MEM_RW 	 = data_out [2];
	assign wb_sel 	 = data_out [1:0];

mux2_1 		khoi_PC_mux (alu_out, pc_plus_4, pc_mux_sel, pc_in);

imm_gen 	khoi_ext_imm (inst[31:7], imm_sel, imm);

register_bank 	khoi_REG_bank (wb_out, addr_A, addr_B, addr_D, reg_WEn, clk, rs1_out, rs2_out);

branch_comp 	khoi_branch_comp (rs1_out, rs2_out, BrUn, BrEq, BrLt);

mux2_1 		ALU_mux_1 (pc_out, rs1_out, A_sel, alu_mux1_out);
mux2_1 		ALU_mux_2 (imm,    rs2_out, B_sel, alu_mux2_out);

ALU 		khoi_ALU (alu_mux1_out, alu_mux2_out, ALU_sel, alu_out);

DMEM 		khoi_DMEM (alu_out, rs2_out, MEM_RW, clk, DMEM_out);

wb_select 	WB_MUX (DMEM_out, alu_out, pc_plus_4, wb_sel, wb_out);

endmodule
