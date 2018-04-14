`timescale 1ns/1ps
// name:zhu shiyang
// student ID:0640143
module alu_top(
	src1,       //1 bit source 1 (input)
	src2,       //1 bit source 2 (input)
	less,       //1 bit less     (input)
	A_invert,   //1 bit A_invert (input)
	B_invert,   //1 bit B_invert (input)
	cin,        //1 bit carry in (input)
	operation,  //operation      (input)
	result,     //1 bit result   (output)
	cout       //1 bit carry out(output)
);

input			src1;
input			src2;
input			less;
input			A_invert;
input			B_invert;
input			cin;
input	[2-1:0]	operation;

output			result;
output			cout;
reg A,B;
reg				result,cout;
always@( * )
begin
	A= A_invert ? ~src1:src1;
	B= B_invert ? ~src2:src2;
	case(operation)
		2'b00:
			begin
				result=A&B;
			end
		2'b01:
			begin
				result=A|B;
			end
		2'b10:
			begin
				result=A^B^cin;
			end
		2'b11:
			begin
				result=less;
			end
		default:
			begin
			
			end
	endcase
	cout = (A&B)|(A&cin)|(B&cin);
end

endmodule
