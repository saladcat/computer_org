//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	src3_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]  src2_i;
input  [16-1:0]  src3_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;
reg		[32:0] input1;
reg 		[32:0] input2;
reg      [32:0] temp;
//Parameter
assign zero_o = (result_o==0);
//Main function
always @(*) begin
    case(ctrl_i)
        0:result_o <= src1_i&src2_i;//and
        1:begin result_o <= src1_i|src2_i;//or and ORI
		  $display("r10=%b",result_o);
		  end
        2:begin result_o <= src1_i+src2_i;//add
		  end
		  3:begin							//addu
				input1<={1'b0,src1_i};
				input2<={1'b0,src2_i};
				temp <=(input1+input2);
				result_o<=temp[31:0];
			end
		  5:begin
			   result_o<=src2_i<<16; //LUI
		  end
        6:result_o <= src1_i-src2_i;//sub
        7:result_o <= src1_i<src2_i ? 1:0;//SLT
		  4'b1000:begin  //sltiu
				input1={1'b0,src1_i};
				input2={1'b0,src2_i};
				result_o <= input1<input2 ? 1:0;
				end
		  11:begin //srav
				result_o <= $signed(src2_i)>>>src1_i;
		  end
        12:result_o <=~(src1_i|src2_i); // nor
		  13:result_o <=  $signed(src2_i)>>>src3_i[10:6];//sra
		  14:begin
					if((src1_i-src2_i)!=0) result_o<=32'b0;
					else result_o<=32'b1;
			  end
		  15:begin
		  		input1<={1'b0,src1_i};
				input2<={1'b0,src2_i};
				temp <=(input1-input2);
				result_o<=temp[31:0];
				end
        default:result_o <= 0;
    endcase
end
endmodule





                    
                    