`timescale 1ns/1ps
// name:zhu shiyang
// student ID:0640143
`include "alu_top.v"
`include "alu_bottom.v"

module alu(
	rst_n,         // negative reset            (input)
	src1,          // 32 bits source 1          (input)
	src2,          // 32 bits source 2          (input)
	ALU_control,   // 4 bits ALU control input  (input)
	bonus_control, // 3 bits bonus control input(input)
	result,        // 32 bits result            (output)
	zero,          // 1 bit when the output is 0, zero must be set (output)
	cout,          // 1 bit carry out           (output)
	overflow       // 1 bit overflow            (output)
);


input				rst_n;
input	[32-1:0]	src1;
input	[32-1:0]	src2;
input	[4-1:0]		ALU_control;
input	[3-1:0]		bonus_control;

output	[32-1:0]	result;
output				zero;
output				cout;
output				overflow;

wire		[32-1:0]	result;
wire					zero;
wire					cout;
wire					overflow;
wire					set;
wire [32-1:0]     s_cout;

wire 					firstC;
wire					equal;
reg              cmp;

wire tem1,tem2,tem3;
assign tem1=ALU_control[3]^src1[31];
assign tem2=ALU_control[2]^src2[31];

assign cout = (s_cout[30]&tem1)|(s_cout[30]&tem2)|(tem1&tem2);
assign zero = (result == 32'h0)? 1 : 0;

assign firstC = (!ALU_control[3]&ALU_control[2]&ALU_control[1]&ALU_control[0])|//slt
			(!ALU_control[3]&ALU_control[2]&ALU_control[1]&!ALU_control[0]);//sub
assign equal = (~(src1[0]^src2[0]))&(~(src1[1]^src2[1]))&(~(src1[2]^src2[2]))&(~(src1[3]^src2[3]))&(~(src1[4]^src2[4]))&(~(src1[5]^src2[5]))&(~(src1[6]^src2[6]))&(~(src1[7]^src2[7]))&(~(src1[8]^src2[8]))&(~(src1[9]^src2[9]))&
					(~(src1[10]^src2[10]))&(~(src1[11]^src2[11]))&(~(src1[12]^src2[12]))&(~(src1[13]^src2[13]))&(~(src1[14]^src2[14]))&(~(src1[15]^src2[15]))&(~(src1[16]^src2[16]))&(~(src1[17]^src2[17]))&(~(src1[18]^src2[18]))&(~(src1[19]^src2[19]))&
					(~(src1[20]^src2[20]))&(~(src1[21]^src2[21]))&(~(src1[22]^src2[22]))&(~(src1[23]^src2[23]))&(~(src1[24]^src2[24]))&(~(src1[25]^src2[25]))&(~(src1[26]^src2[26]))&(~(src1[27]^src2[27]))&(~(src1[28]^src2[28]))&(~(src1[29]^src2[29]))&
					(~(src1[30]^src2[30]))&(~(src1[31]^src2[31]));

always @(*)begin
	case(bonus_control)
		3'b000:
		begin
			assign cmp=set;
		end
		3'b001:
		begin
			assign cmp=set|equal;
		end
		3'b010:
		begin
			assign cmp=~equal;
		end
		3'b011:
		begin
			assign cmp=equal;
		end
		3'b111:
		begin
			assign cmp=~(set);
		end
		3'b110:
		begin
			assign cmp= ~(set|equal);
		end
			default:
		begin
			
		end
	endcase
end	
alu_top ALU0(
	.src1(src1[0]),
	.src2(src2[0]),
	.less(cmp),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(firstC),
	.operation(ALU_control[1:0]),
	.result(result[0]),
	.cout(s_cout[0])
	);
alu_top ALU1(
	.src1(src1[1]),
	.src2(src2[1]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[0]),
	.operation(ALU_control[1:0]),
	.result(result[1]),
	.cout(s_cout[1])
	);
alu_top ALU2(
	.src1(src1[2]),
	.src2(src2[2]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[1]),
	.operation(ALU_control[1:0]),
	.result(result[2]),
	.cout(s_cout[2])
	);
alu_top ALU3(
	.src1(src1[3]),
	.src2(src2[3]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[2]),
	.operation(ALU_control[1:0]),
	.result(result[3]),
	.cout(s_cout[3])
	);
alu_top ALU4(
	.src1(src1[4]),
	.src2(src2[4]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[3]),
	.operation(ALU_control[1:0]),
	.result(result[4]),
	.cout(s_cout[4])
	);
alu_top ALU5(
	.src1(src1[5]),
	.src2(src2[5]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[4]),
	.operation(ALU_control[1:0]),
	.result(result[5]),
	.cout(s_cout[5])
	);
alu_top ALU6(
	.src1(src1[6]),
	.src2(src2[6]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[5]),
	.operation(ALU_control[1:0]),
	.result(result[6]),
	.cout(s_cout[6])
	);
alu_top ALU7(
	.src1(src1[7]),
	.src2(src2[7]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[6]),
	.operation(ALU_control[1:0]),
	.result(result[7]),
	.cout(s_cout[7])
	);
alu_top ALU8(
	.src1(src1[8]),
	.src2(src2[8]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[7]),
	.operation(ALU_control[1:0]),
	.result(result[8]),
	.cout(s_cout[8])
	);
alu_top ALU9(
	.src1(src1[9]),
	.src2(src2[9]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[8]),
	.operation(ALU_control[1:0]),
	.result(result[9]),
	.cout(s_cout[9])
	);
alu_top ALU10(
	.src1(src1[10]),
	.src2(src2[10]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[9]),
	.operation(ALU_control[1:0]),
	.result(result[10]),
	.cout(s_cout[10])
	);
alu_top ALU11(
	.src1(src1[11]),
	.src2(src2[11]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[10]),
	.operation(ALU_control[1:0]),
	.result(result[11]),
	.cout(s_cout[11])
	);
alu_top ALU12(
	.src1(src1[12]),
	.src2(src2[12]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[11]),
	.operation(ALU_control[1:0]),
	.result(result[12]),
	.cout(s_cout[12])
	);
alu_top ALU13(
	.src1(src1[13]),
	.src2(src2[13]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[12]),
	.operation(ALU_control[1:0]),
	.result(result[13]),
	.cout(s_cout[13])
	);
alu_top ALU14(
	.src1(src1[14]),
	.src2(src2[14]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[13]),
	.operation(ALU_control[1:0]),
	.result(result[14]),
	.cout(s_cout[14])
	);
alu_top ALU15(
	.src1(src1[15]),
	.src2(src2[15]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[14]),
	.operation(ALU_control[1:0]),
	.result(result[15]),
	.cout(s_cout[15])
	);
alu_top ALU16(
	.src1(src1[16]),
	.src2(src2[16]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[15]),
	.operation(ALU_control[1:0]),
	.result(result[16]),
	.cout(s_cout[16])
	);
alu_top ALU17(
	.src1(src1[17]),
	.src2(src2[17]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[16]),
	.operation(ALU_control[1:0]),
	.result(result[17]),
	.cout(s_cout[17])
	);
alu_top ALU18(
	.src1(src1[18]),
	.src2(src2[18]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[17]),
	.operation(ALU_control[1:0]),
	.result(result[18]),
	.cout(s_cout[18])
	);
alu_top ALU19(
	.src1(src1[19]),
	.src2(src2[19]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[18]),
	.operation(ALU_control[1:0]),
	.result(result[19]),
	.cout(s_cout[19])
	);	
alu_top ALU20(
	.src1(src1[20]),
	.src2(src2[20]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[19]),
	.operation(ALU_control[1:0]),
	.result(result[20]),
	.cout(s_cout[20])
	);
alu_top ALU21(
	.src1(src1[21]),
	.src2(src2[21]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[20]),
	.operation(ALU_control[1:0]),
	.result(result[21]),
	.cout(s_cout[21])
	);
alu_top ALU22(
	.src1(src1[22]),
	.src2(src2[22]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[21]),
	.operation(ALU_control[1:0]),
	.result(result[22]),
	.cout(s_cout[22])
	);
alu_top ALU23(
	.src1(src1[23]),
	.src2(src2[23]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[22]),
	.operation(ALU_control[1:0]),
	.result(result[23]),
	.cout(s_cout[23])
	);
alu_top ALU24(
	.src1(src1[24]),
	.src2(src2[24]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[23]),
	.operation(ALU_control[1:0]),
	.result(result[24]),
	.cout(s_cout[24])
	);
alu_top ALU25(
	.src1(src1[25]),
	.src2(src2[25]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[24]),
	.operation(ALU_control[1:0]),
	.result(result[25]),
	.cout(s_cout[25])
	);
alu_top ALU26(
	.src1(src1[26]),
	.src2(src2[26]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[25]),
	.operation(ALU_control[1:0]),
	.result(result[26]),
	.cout(s_cout[26])
	);
alu_top ALU27(
	.src1(src1[27]),
	.src2(src2[27]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[26]),
	.operation(ALU_control[1:0]),
	.result(result[27]),
	.cout(s_cout[27])
	);
alu_top ALU28(
	.src1(src1[28]),
	.src2(src2[28]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[27]),
	.operation(ALU_control[1:0]),
	.result(result[28]),
	.cout(s_cout[28])
	);
alu_top ALU29(
	.src1(src1[29]),
	.src2(src2[29]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[28]),
	.operation(ALU_control[1:0]),
	.result(result[29]),
	.cout(s_cout[29])
	);
alu_top ALU30(
	.src1(src1[30]),
	.src2(src2[30]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[29]),
	.operation(ALU_control[1:0]),
	.result(result[30]),
	.cout(s_cout[30])
	);
	
alu_bottom ALU31(
	.src1(src1[31]),
	.src2(src2[31]),
	.less(1'b0),
	.A_invert(ALU_control[3]),
	.B_invert(ALU_control[2]),
	.cin(s_cout[30]),
	.operation(ALU_control[1:0]),
	.result(result[31]),
	.overflow(overflow),
	.set(set)
);


endmodule
