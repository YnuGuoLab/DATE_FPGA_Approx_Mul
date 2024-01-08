module inexact_1234(
	a,
	b,
	/*
	ll,
	lh,
	hl,
	hh,
	*/
	
	prod8
);                   

input [7:0] a;
input [7:0] b;

output [15:0] prod8;

wire [3:0] ah,al,bh,bl;

wire [7:0] ll,hl,lh,hh;

assign ah[3:0] = a[7:4];
assign al[3:0] = a[3:0];
assign bh[3:0] = b[7:4];
assign bl[3:0] = b[3:0];

ap1 HH(
	.a(ah),
	.b(bh),
	
	.prod(hh)
);


ap2 HL(
	.a(ah),
	.b(bl),
	
	.prod(hl)
);

ap3 LH(
	.a(al),
	.b(bh),
	
	.prod(lh)
);

ap4 LL(
	.a(al),
	.b(bl),
	
	.prod(ll)
);

add_inexact adder(
	.ll(ll),
	.lh(lh),
	.hl(hl),
	.hh(hh),
	
	.result(prod8)
	);



endmodule