module shift_right_a (x, n, x_shifted);
input	[31:0]	x, n;
output	[31:0] 	x_shifted;

wire	[31:0]	x0, x1, x2, x3, x4, x_shifted;

//Dich phai n[4:0] lan:
shift_right_a1	sra_1	(x,  n[0], x0);	//Dich phai 1  lan
shift_right_a2	sra_2	(x0, n[1], x1);	//Dich phai 2  lan
shift_right_a4	sra_4	(x1, n[2], x2);	//Dich phai 4  lan
shift_right_a8	sra_8	(x2, n[3], x3);	//Dich phai 8  lan
shift_right_a16	sra_16	(x3, n[4], x4);	//Dich phai 16 lan

//n > 32 lan:
assign	x_shifted = (n[31:5] != 27'b0) ? ((x[31])?  32'hFFFF_FFFF : 32'b0)
				   :   x4;	

endmodule
//
module shift_right_a1	(x, n0, x_shifted1);
input	[31:0]	x;
input	n0;
output	[31:0] 	x_shifted1;

assign 	x_shifted1 = (n0) ?	((x[31]) ? {1'b1, x[31:1]}
					 : {1'b0, x[31:1]})	
			  :	  x;
endmodule
//

module shift_right_a2	(x, n1, x_shifted2);
input	[31:0]	x;
input	n1;
output	[31:0] 	x_shifted2;

assign 	x_shifted2 = (n1) ?	((x[31]) ? {2'b11, x[31:2]}	
 					 : {2'b0,  x[31:2]})	
			  :	  x;
endmodule
//

module shift_right_a4	(x, n2, x_shifted4);
input	[31:0]	x;
input	n2;
output	[31:0] 	x_shifted4;

assign 	x_shifted4 = (n2) ?	((x[31]) ? {4'hf, x[31:4]}	
 					 : {4'b0, x[31:4]})	
			  :	  x;
endmodule
//

module shift_right_a8	(x, n3, x_shifted8);
input	[31:0]	x;
input	n3;
output	[31:0] 	x_shifted8;

assign 	x_shifted8 = (n3) ?	((x[31]) ? {8'hff, x[31:8]}	
 					 : {8'b0,  x[31:8]})	
			  :	  x;
endmodule
//

module shift_right_a16	(x, n4, x_shifted16);
input	[31:0]	x;
input	n4;
output	[31:0] 	x_shifted16;

assign 	x_shifted16 = (n4) ?	((x[31]) ? {16'hffff, x[31:16]}	
 					 : {16'b0,    x[31:16]})	
			   :	  x;
endmodule
//





