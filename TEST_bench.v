module _test_bench;

reg 	clk;
initial begin
	#0 clk = 0;
	forever begin
		#1 clk = ~clk;
		end
	end 

//---------------------------------------------------------------------------------------------------

/*
reg [31:0] wb_out;
reg RegWen ;
reg [4:0] rs1, rs2, rd;

wire [31:0] rs1_out, rs2_out;

//register_bank	test1 (wb_out, rs1, rs2, rd, RegWen, clk, rs1_out, rs2_out);

initial begin
#0	wb_out = 'h1;
	RegWen = 1'b1;
	rd = 5'b1;
	end
*/
//---------------------------------------------------------------------------------------------------

/*
wire [12:0] imm__100, imm__100_lay_;
wire [31:0] imm;
reg [24:0] inst;
reg [2:0] imm_sel;
imm_gen	test2 (inst, imm_sel, imm, imm__100, imm__100_lay_);

initial begin
	#0 inst = 25'b_1111_1110_0000_0011_0001_1100_1;//1110_0011
	imm_sel = 3'b100;
	end
*/

//	1111_1110_0000_0011_0001_1100_1000_0000;

//---------------------------------------------------------------------------------------------------

reg [31:0]	x, n;
wire [31:0]	y;

shift_right_a	SRA	(x, n, y);
initial begin
	#0	x = 32'h_100f_0888;
		n = 32'h_0000_001b;
	#1	n = 32'h_0010_001b;
	#1	x = 32'h_f10f_0888;
		n = 32'h_0000_001b;
	#1	n = 32'h_0010_001b;
	end


endmodule
