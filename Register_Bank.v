module register_bank (wb_out, rs1, rs2, rd, RegWen, clk, rs1_out, rs2_out);
input [31:0] wb_out;
input [4:0] rs1, rs2, rd;
input RegWen, clk;
output [31:0] rs1_out, rs2_out;

reg [31:0] register [0:31];
//reg [31:0] rs1_out, rs2_out;

wire [31:0] rs1_out, rs2_out;

//write
always @(negedge clk) 
	begin
	if ((RegWen) & (rd != 5'b0))
		begin
		register[rd] = wb_out;
		end
	end

assign rs1_out = register[rs1];
assign rs2_out = register[rs2];

/*
always @(*)	// data_a (rs1_out)
	begin
	if (rs1 == 5'b0) 
		begin
		rs1_out = 32'b0;
		end
	else if (RegWen & (rs1 == rd)) rs1_out = register[rd];
			
	else 
		begin
		rs1_out = register[rs1];
		end
	end

always @(*)	//data_b (rs2_out)
	begin
	if (rs2 == 5'b0)
		begin
		rs2_out = 32'b0;
		end
	else if (RegWen & (rs2 == rd)) rs2_out = register[rd];

	else
		begin
		rs2_out = register[rs2];
		end
	end
*/
initial 	//khoi tao cac gia tri ban dau = 0
	begin
	#0 
	register[0]  = 32'b0;
	register[1]  = 32'b0;
	register[2]  = 32'b0;
	register[3]  = 32'b0;
	register[4]  = 32'b0;
	register[5]  = 32'b0;
	register[6]  = 32'b0;
	register[7]  = 32'b0;
	register[8]  = 32'b0;
	register[9]  = 32'b0;
	register[10] = 32'b0;
	register[11] = 32'b0;
	register[12] = 32'b0;
	register[13] = 32'b0;
	register[14] = 32'b0;
	register[15] = 32'b0;
	register[16] = 32'b0;
	register[17] = 32'b0;
	register[18] = 32'b0;
	register[19] = 32'b0;
	register[20] = 32'b0;
	register[21] = 32'b0;
	register[22] = 32'b0;
	register[23] = 32'b0;
	register[24] = 32'b0;
	register[25] = 32'b0;
	register[26] = 32'b0;
	register[27] = 32'b0;
	register[28] = 32'b0;
	register[29] = 32'b0;
	register[30] = 32'b0;
	register[31] = 32'b0;
	end

endmodule
