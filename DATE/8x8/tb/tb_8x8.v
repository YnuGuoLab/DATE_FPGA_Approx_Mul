`timescale 1ns / 1ps

module testbench_multi8();

parameter n = 8;

reg [n-1:0] mul_A;
reg [n-1:0] mul_B;
reg [n-1:0] temp[255:0];
//reg [2*n-1:0] out_temp[225:0];
wire [2*n-1:0] result;



integer i;
integer j;
integer fp;	


// You can change the module name for different design
LUT2_1134 testmul_multi8(
	.a(mul_A),
	.b(mul_B),

	.prod8(result)
	);


initial begin
fp = $fopen("out_result.txt","w");

$readmemb("FilePath/input_bin_8.txt",temp);//all input combinations for 8x8 multiplier 
for(i = 0;i < 256;i = i+1)
begin

	mul_A = temp[i];
for(j = 0;j < 256;j = j+1)
begin
	mul_B = temp[j];
	#1;
	$fdisplay(fp,"%b\n",result);

	
end
end

	$fclose(fp);
end



endmodule	










