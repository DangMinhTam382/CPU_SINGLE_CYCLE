module DMEM (addr, data_w, mem_rw, clk, data_r);
input [31:0] data_w, addr;
input mem_rw, clk;
output reg [31:0] data_r;

wire [9:0] addr_DMEM;
reg [31:0] DMEM [0:1023];
integer i;

assign addr_DMEM = addr[9:0];

initial begin
	#0 i = 0;
	while (i < 1024) begin
		DMEM[i] = 'h0;
		i = i + 1;
		end
	end

always @(negedge clk) begin
	if (mem_rw) 
		begin	//write
		DMEM[addr_DMEM] = data_w;
		end
	end
always @(*) begin
	//read
	data_r = DMEM[addr_DMEM];
	end

endmodule
