module ap3(
	a,
	b,
	
	prod
);                   

input [3:0] a;
input [3:0] b;

output [7:0] prod;



wire [3:0] gen,prop;
wire [5:0] L1,L2;



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



LUT6_2 #(
.INIT(64'hA00000000AAA8000) 
) LUT6_2_inst4(

.I0(b[1]), 
.I1(a[1]), 
.I2(b[0]), 
.I3(a[2]), 
.I4(a[3]), 
.I5(1'd1),

.O6(L1[5]),
.O5(L1[4])
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

LUT6_2 #(
.INIT(64'hA00000000AAA8000) 
) LUT6_2_inst8(

.I0(b[3]), 
.I1(a[1]), 
.I2(b[2]), 
.I3(a[2]), 
.I4(a[3]), 
.I5(1'd1),

.O6(L2[5]),
.O5(L2[4])
);
LUT6_2 #(
.INIT(64'hFFFFFF8078787878) 
) LUT6_2_inst9(

.I0(a[0]), 
.I1(b[2]), 
.I2(L1[2]), 
.I3(L1[3]), 
.I4(L2[1]), 
.I5(1'd1),

.O6(prod[3]),
.O5(prod[2])
);



LUT6_2 #(
.INIT(64'h0FF00FF088888888) 
) LUT6_2_inst10 (

.I0(a[0]), 
.I1(b[0]), 
.I2(L1[4]), 
.I3(L2[2]), 
.I4(1'd1), 
.I5(1'd1),

.O6(prod[4]),
.O5(prod[0])
);

LUT6_2 #(
.INIT(64'h137FEC80936C936C) 
) LUT6_2_inst11 (

.I0(L1[4]), 
.I1(L1[5]), 
.I2(L2[2]), 
.I3(L2[3]), 
.I4(L2[4]), 
.I5(1'd1),

.O6(prod[6]),
.O5(prod[5])
);

LUT6 #(
.INIT(64'hFFFFFFFFEC800000) 
) LUT6_inst12 (

.I0(L1[4]), 
.I1(L1[5]), 
.I2(L2[2]), 
.I3(L2[3]), 
.I4(L2[4]), 
.I5(L2[5]),

.O(prod[7])

);


endmodule
















