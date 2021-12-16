module branch_comp (data_a, data_b, BrUn, BrEq, BrLt);
input [31:0] data_a, data_b;
input BrUn;
output BrEq, BrLt;

wire BrEq, BrLt;

assign BrEq = (data_a == data_b)? 1 : 0;
assign BrLt = (~BrUn)	? ((data_a < data_b)? 1 : 0)
			: (($signed(data_a) < $signed(data_b))? 1 : 0);
endmodule
