module add_acc(
	ll,
	lh,
	hl,
	hh,
	/*
	a_reg,b_reg,c_reg,d_reg,
	p,g,
	c_i,
	*/
	
	result
);                   

input [7:0] ll,lh,hl,hh;

output [15:0] result;

//--------------------
// signal assignment
wire [7:0] a_reg,b_reg,c_reg;
wire [3:0] d_reg;

wire [12:0] p,g;

assign a_reg[3:0] = ll[7:4];
assign a_reg[7:4] = hh[3:0];
assign b_reg[7:0] = lh[7:0];
assign c_reg[7:0] = hl[7:0];
assign d_reg[3:0] = hh[7:4];

assign g[0] = 1'd0;
assign g[12:10] = 3'b000;
assign p[11:9] = d_reg[3:1];
assign result[3:0] = ll[3:0];

//-------------
//RCA 
//

LUT6_2 #(
.INIT(64'h96969696E8E8E8E8) 
) LUT6_2_inst1 (

.I0(c_reg[0]),
.I1(b_reg[0]), 
.I2(a_reg[0]), 
.I3(1'd1), 
.I4(1'd1), 
.I5(1'd1), 

.O6(p[0]), 
.O5(g[1]) 
);


//generate the propagates for each bit for the carry chains
genvar i;
for(i = 1;i < 8;i = i+1) begin:GP

LUT6_2 #(
.INIT(64'h69966996E8E8E8E8) 
) LUT6_2_inst2 (

.I0(c_reg[i]),
.I1(b_reg[i]), 
.I2(a_reg[i]), 
.I3(g[i]), 
.I4(1'd1), 
.I5(1'd1), 

.O6(p[i]), 
.O5(g[i+1]) 
);
end


LUT6_2 #(
.INIT(64'h17E817E8E8E8E8E8) 
) LUT6_2_inst3 (

.I0(c_reg[7]),
.I1(b_reg[7]), 
.I2(a_reg[7]), 
.I3(d_reg[0]), 
.I4(1'd1), 
.I5(1'd1), 

.O6(p[8]), 
.O5(g[9]) 
);


//
//carry chain
//
wire [12:0] c_i;
wire [11:0] sum;
assign c_i[0] = 1'd0;
 
genvar j;
for(j = 0;j < 2;j = j+1) begin:carry
CARRY4 CARRY4_inst1 (
.CO(c_i[4*j + 4:4*j + 1]), // 4-bit carry out
.O(sum[4*j + 3 : 4*j]), // 4-bit carry chain XOR data out
 
.CI(c_i[4*j]), // 1-bit carry cascade input
.CYINIT(1'd0), // 1-bit carry initialization
.DI(g[4*j + 3:4*j]), // 4-bit carry-MUX data in
.S(p[4*j + 3:4*j]) // 4-bit carry-MUX select input
);
end



CARRY4 CARRY4_inst2 (
.CO(c_i[8 + 4:8 + 1]), // 4-bit carry out
.O(sum[11: 8]), // 4-bit carry chain XOR data out

.CI(c_i[8]), // 1-bit carry cascade input
.CYINIT(1'd0), // 1-bit carry initialization
.DI(g[8 + 4:8+1]), // 4-bit carry-MUX data in
.S(p[8 + 3:8]) // 4-bit carry-MUX select input
);

assign result[15:4] = sum; 

endmodule














