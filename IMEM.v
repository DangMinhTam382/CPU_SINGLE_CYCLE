/*
 ***@Author: NGUYEN TRUNG HIEU
 ***@Date:   Nov 1st, 2018
*/

/******** Instruction Memmory Block ********/
module IMEM(PC, inst);
parameter	INST_WIDTH_LENGTH = 32;
parameter	PC_WIDTH_LENGTH = 32;
parameter	MEM_WIDTH_LENGTH = 32;
parameter	MEM_DEPTH = 1<<18;
input		[PC_WIDTH_LENGTH-1:0]PC;
output	reg	[INST_WIDTH_LENGTH-1:0]inst;

/********* Instruction Memmory *************/
reg		[MEM_WIDTH_LENGTH-1:0]IMEM[0:MEM_DEPTH-1];

wire		[17:0]pWord;
wire		[1:0]pByte;

assign		pWord = PC[19:2];
assign		pByte = PC[1:0];

initial begin
$readmemh("F:/211/Cau_Truc_May_Tinh/BTL/BTL_RISCV/factorial.txt",IMEM);
end

always@(PC)
begin
	if (pByte == 2'b00)
		inst <= IMEM[pWord];
	else
		inst <= 'hz;
end

endmodule
