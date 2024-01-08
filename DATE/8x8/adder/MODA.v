module add_inexact(
	ll,
	lh,
	hl,
	hh,
	
	result
);                   

input [7:0] ll,lh,hl,hh;

output [15:0] result;

//--------------------
// signal assignment
wire [7:0] a_reg,b_reg,c_reg;
wire [3:0] d_reg;

wire [8:0] p,g;

wire [8:0] c_i;

assign a_reg[3:0] = ll[7:4];
assign a_reg[7:4] = hh[3:0];
assign b_reg[7:0] = lh[7:0];
assign c_reg[7:0] = hl[7:0];
assign d_reg[3:0] = hh[7:4];

assign g[0] = 1'd0;
assign g[8:6] = 3'b000;
assign p[7:5] = d_reg[3:1];
assign result[3:0] = ll[3:0];


//---------------------------------
//LUT - OR
genvar j;
for(j = 0;j < 3; j = j + 1)begin:OR
LUT6_2 #(
.INIT(64'hFEFEFEFEFEFEFEFE) 
) LUT6_inst1 (

.I0(c_reg[j]),
.I1(b_reg[j]), 
.I2(a_reg[j]), 
.I3(1'd1), 
.I4(1'd1), 
.I5(1'd1), 

.O6(result[j+4])
);
end

//LUT - OR + AND
LUT6_2 #(
.INIT(64'hE8E8E8E8FEFEFEFE) 
) LUT6_2_inst2 (

.I0(c_reg[3]),
.I1(b_reg[3]), 
.I2(a_reg[3]), 
.I3(1'd1), 
.I4(1'd1), 
.I5(1'd1), 

.O6(c_i[0]), 
.O5(result[7]) 
);


//---------------------------------------------------------
//generate the propagates for each bit for the carry chains

LUT6_2 #(
.INIT(64'h96969696E8E8E8E8) 
) LUT6_2_inst0 (

.I0(c_reg[4]),
.I1(b_reg[4]), 
.I2(a_reg[4]), 
.I3(1'd1), 
.I4(1'd1), 
.I5(1'd1), 

.O6(p[0]), 
.O5(g[1]) 
);


genvar i;
for(i = 1;i < 4;i = i+1) begin:GP

LUT6_2 #(
.INIT(64'h69966996E8E8E8E8) 
) LUT6_2_inst3 (

.I0(c_reg[i+4]),
.I1(b_reg[i+4]), 
.I2(a_reg[i+4]), 
.I3(g[i]), 
.I4(1'd1), 
.I5(1'd1), 

.O6(p[i]), 
.O5(g[i+1]) 
);
end


LUT6_2 #(
.INIT(64'h17E817E8E8E8E8E8) 
) LUT6_2_inst4 (

.I0(c_reg[7]),
.I1(b_reg[7]), 
.I2(a_reg[7]), 
.I3(d_reg[0]), 
.I4(1'd1), 
.I5(1'd1), 

.O6(p[4]), 
.O5(g[5]) 
);

//carry chain
wire [7:0] sum;

CARRY4 CARRY4_inst1 (
.CO(c_i[4:1]), // 4-bit carry out
.O(sum[3:0]), // 4-bit carry chain XOR data out
 
.CI(c_i[0]), // 1-bit carry cascade input
.CYINIT(1'd0), // 1-bit carry initialization
.DI(g[3:0]), // 4-bit carry-MUX data in
.S(p[3:0]) // 4-bit carry-MUX select input
);


CARRY4 CARRY4_inst2 (
.CO(c_i[8:5]), // 4-bit carry out
.O(sum[7:4]), // 4-bit carry chain XOR data out

.CI(c_i[4]), // 1-bit carry cascade input
.CYINIT(1'd0), // 1-bit carry initialization
.DI(g[8:5]), // 4-bit carry-MUX data in
.S(p[7:4]) // 4-bit carry-MUX select input
);

assign result[15:8] = sum; 

endmodule














