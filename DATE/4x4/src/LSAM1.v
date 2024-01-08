module ap1(
	a,
	b,
	
	prod
);                   

input [3:0] a;
input [3:0] b;

output [7:0] prod;



wire [3:0] gen,prop;
wire [5:0] L1,L2;
wire [0:0] C1;

LUT6_2 #(
.INIT(64'hDAF02A0078887888) // Specify LUT Contents
) LUT6_2_inst1 (

.I0(b[1]), // 1-bit LUT input
.I1(a[0]), // 1-bit LUT input
.I2(b[0]), // 1-bit LUT input
.I3(a[1]), // 1-bit LUT input
.I4(a[2]), // 1-bit LUT input
.I5(1'd1), // 1-bit LUT input (fast MUX select only available to O6 output)

.O6(L1[2]), // 1-bit LUT6 output
.O5(prod[1]) // 1-bit lower LUT5 output
);



LUT6 #(
.INIT(64'hFA5A70F00AAA8000) 
) LUT6_inst2 (

.I0(b[1]), 
.I1(a[0]), 
.I2(b[0]), 
.I3(a[1]), 
.I4(a[2]), 
.I5(a[3]),

.O(L1[3]) 
);


LUT6 #(
.INIT(64'h0A0A2AAAA0000000) 
) LUT6_2_inst3 (
 
.I0(b[1]), 
.I1(a[0]), 
.I2(b[0]), 
.I3(a[1]), 
.I4(a[2]), 
.I5(a[3]),

.O(L1[4]) 
);



LUT6 #(
.INIT(64'hA0A0800000000000) 
) LUT6_inst4 (

.I0(b[1]), 
.I1(a[0]), 
.I2(b[0]), 
.I3(a[1]), 
.I4(a[2]), 
.I5(a[3]),


.O(L1[5])
);



LUT6_2 #(
.INIT(64'hDAF02A0078887888) 
) LUT6_2_inst5 (

.I0(b[3]), 
.I1(a[0]), 
.I2(b[2]), 
.I3(a[1]), 
.I4(a[2]), 
.I5(1'd1), 


.O6(L2[2]),
.O5(L2[1])
);



LUT6 #(
.INIT(64'hFA5A70F00AAA8000) 
) LUT6_inst6 (

.I0(b[3]), 
.I1(a[0]), 
.I2(b[2]), 
.I3(a[1]), 
.I4(a[2]), 
.I5(a[3]),

.O(L2[3])
);

LUT6 #(
.INIT(64'h0A0A2AAAA0000000) 
) LUT6_inst7 (

.I0(b[3]), 
.I1(a[0]), 
.I2(b[2]), 
.I3(a[1]), 
.I4(a[2]), 
.I5(a[3]),

.O(prop[3])

);

LUT6 #(
.INIT(64'hA0A0800000000000) 
) LUT6_inst8 (

.I0(b[3]), 
.I1(a[0]), 
.I2(b[2]), 
.I3(a[1]), 
.I4(a[2]), 
.I5(a[3]),

.O(gen[3])
);



LUT6_2 #(
.INIT(64'h5FA05FA088888888) 
) LUT6_2_inst9 (

.I0(a[0]), 
.I1(b[0]), 
.I2(b[2]), 
.I3(L1[2]), 
.I4(1'd1), 
.I5(1'd1),

.O6(prod[2]),
.O5(prod[0])
);

LUT6_2 #(
.INIT(64'h007F7F80FF808000) 
) LUT6_2_inst10 (

.I0(L1[2]), 
.I1(a[0]), 
.I2(b[2]), 
.I3(L1[3]), 
.I4(L2[1]), 
.I5(1'd1),

.O6(prop[0]),
.O5(gen[0])
);

LUT6_2 #(
.INIT(64'h6666666688888880) 
) LUT6_2_inst11 (

.I0(L1[4]), 
.I1(L2[2]), 
.I2(1'd1), 
.I3(1'd1), 
.I4(1'd1), 
.I5(1'd1),

.O6(prop[1]),
.O5(gen[1])
);

LUT6_2 #(
.INIT(64'h6666666688888880) 
) LUT6_2_inst12 (

.I0(L1[5]), 
.I1(L2[3]), 
.I2(1'd1), 
.I3(1'd1), 
.I4(1'd1), 
.I5(1'd1),

.O6(prop[2]),
.O5(gen[2])
);





//-------------
// CARRY4: Fast Carry Logic Component
// 7 Series
wire [3:0] cout,sum;


CARRY4 CARRY4_inst (
.CO(cout), // 4-bit carry out
.O(sum), // 4-bit carry chain XOR data out
.CI(1'd0), // 1-bit carry cascade input
.CYINIT(1'd0), // 1-bit carry initialization
.DI(gen), // 4-bit carry-MUX data in
.S(prop) // 4-bit carry-MUX select input
);

assign prod[6:3] = sum[3:0];
assign prod[7] = cout[3];


endmodule














