`timescale 1ns / 1ps



module add_LUT2(
	ll,
	lh,
	hl,
	hh,
	
	result
    );
input [7:0] ll,lh,hl,hh;

output [15:0] result;
    
    LUT6 #(
      .INIT(64'hFEFEFEFEFEFEFEFE) // Specify LUT Contents
   ) LUT6_inst1 (
      .O(P4), // 1-bit LUT6 output
      .I0(ll[4]), // 1-bit LUT input
      .I1(lh[0]), // 1-bit LUT input
      .I2(hl[0]), // 1-bit LUT input
      .I3(1'b0), // 1-bit LUT input
      .I4(1'b0), // 1-bit LUT input
      .I5(1'b0)  // 1-bit LUT input
   );
   LUT6 #(
      .INIT(64'hFFFFFFFEFFFEFEFE) // Specify LUT Contents
   ) LUT6_inst2 (
      .O(P5), // 1-bit LUT6 output
      .I0(ll[5]), // 1-bit LUT input
      .I1(lh[1]), // 1-bit LUT input
      .I2(hl[1]), // 1-bit LUT input
      .I3(ll[4]), // 1-bit LUT input
      .I4(lh[0]), // 1-bit LUT input
      .I5(hl[0])  // 1-bit LUT input
   );
   LUT6 #(
      .INIT(64'hFFFFFFFEFFFEFEFE) // Specify LUT Contents
   ) LUT6_inst3 (
      .O(P6), // 1-bit LUT6 output
      .I0(ll[6]), // 1-bit LUT input
      .I1(lh[2]), // 1-bit LUT input
      .I2(hl[2]), // 1-bit LUT input
      .I3(ll[5]), // 1-bit LUT input
      .I4(lh[1]), // 1-bit LUT input
      .I5(hl[1]) // 1-bit LUT input
   );
   LUT6 #(
      .INIT(64'hFFFFFFFEFFFEFEFE) // Specify LUT Contents
   ) LUT6_inst4 (
      .O(P7), // 1-bit LUT6 output
      .I0(ll[7]), // 1-bit LUT input
      .I1(lh[3]), // 1-bit LUT input
      .I2(hl[3]), // 1-bit LUT input
      .I3(ll[6]), // 1-bit LUT input
      .I4(lh[2]), // 1-bit LUT input
      .I5(hl[2]) // 1-bit LUT input
   );
   LUT6 #(
      .INIT(64'hFFFFFFFEFFFEFEFE) // Specify LUT Contents
   ) LUT6_inst5 (
      .O(P8), // 1-bit LUT6 output
      .I0(lh[4]), // 1-bit LUT input
      .I1(hl[4]), // 1-bit LUT input
      .I2(hh[0]), // 1-bit LUT input
      .I3(ll[7]), // 1-bit LUT input
      .I4(lh[3]), // 1-bit LUT input
      .I5(hl[3]) // 1-bit LUT input
   );
   LUT6 #(
      .INIT(64'hFFFFFFFEFFFEFEFE) // Specify LUT Contents
   ) LUT6_inst6 (
      .O(P9), // 1-bit LUT6 output
      .I0(lh[5]), // 1-bit LUT input
      .I1(hl[5]), // 1-bit LUT input
      .I2(hh[1]), // 1-bit LUT input
      .I3(lh[4]), // 1-bit LUT input
      .I4(hl[4]), // 1-bit LUT input
      .I5(hh[0]) // 1-bit LUT input
   );
   LUT6 #(
      .INIT(64'hFFFFFFFEFFFEFEFE) // Specify LUT Contents
   ) LUT6_inst7 (
      .O(P10), // 1-bit LUT6 output
      .I0(lh[6]), // 1-bit LUT input
      .I1(hl[6]), // 1-bit LUT input
      .I2(hh[2]), // 1-bit LUT input
      .I3(lh[5]), // 1-bit LUT input
      .I4(hl[5]), // 1-bit LUT input
      .I5(hh[1])// 1-bit LUT input
   );
   LUT6 #(
      .INIT(64'hFFFFFFFEFFFEFEFE) // Specify LUT Contents
   ) LUT6_inst8 (
      .O(P11), // 1-bit LUT6 output
      .I0(lh[7]), // 1-bit LUT input
      .I1(hl[7]), // 1-bit LUT input
      .I2(hh[3]), // 1-bit LUT input
      .I3(lh[6]), // 1-bit LUT input
      .I4(hl[6]), // 1-bit LUT input
      .I5(hh[2])  // 1-bit LUT input
   );
  
  assign result = {hh[7],hh[6],hh[5],hh[4],P11,P10,P9,P8,P7,P6,P5,P4,ll[3],ll[2],ll[1],ll[0]};
endmodule 
