//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;	//0: won't change the write register's value 1:change the write reister's value 
output [3-1:0] ALU_op_o;    //the operation of ALU should do	
output         ALUSrc_o;	//0: the second input of ALU is reg2 1: the second input is the sign extension of instr_op_i[15:0]
output         RegDst_o;	//0: write register<-instr_op_i[20:16] 1: write register<-instr_op_i[15:11]
output         Branch_o;	//0: no branch instruction 1: may branch instruction

//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter


//Main function
always@(*)
begin
	if(instr_op_i==6'b000000) //R-Type instruction
	begin
		RegDst_o<=1'b1;
		ALUSrc_o<=1'b0;
		RegWrite_o<=1'b1;
		Branch_o<=1'b0;
		ALU_op_o<=3'b010;
	end
	else if(instr_op_i==6'b100011) //LW
	begin
		RegDst_o<=1'b0;
		ALUSrc_o<=1'b1;
		RegWrite_o<=1'b1;
		Branch_o<=1'b0;
		ALU_op_o<=3'b000;
	end
	else if(instr_op_i==6'b101011) //SW
	begin
		RegDst_o<=1'bx;
		ALUSrc_o<=1'b1;
		RegWrite_o<=1'b0;
		Branch_o<=1'b0;
		ALU_op_o<=3'b000;
	end
	else if(instr_op_i==6'b000100) //beq
	begin
		RegDst_o<=1'bx;
		ALUSrc_o<=1'b0;
		RegWrite_o<=1'b0;
		Branch_o<=1'b1;
		ALU_op_o<=3'b001;
	end
	else if(instr_op_i==6'b001000) //addi 
	begin 
		RegDst_o<=1'b0; 
		ALUSrc_o<=1'b1; 
		RegWrite_o<=1'b1;
		Branch_o<=1'b0;
		ALU_op_o<=3'b000; 
	end
	else if(instr_op_i==6'b001011) //sltiu: unsigned comparison
	begin
		RegDst_o<=1'b0;
		ALUSrc_o<=1'b1;
		RegWrite_o<=1'b1;
		Branch_o<=1'b0;
		ALU_op_o<='b010; //equal to R-Type
	end
	else if(instr_op_i==6'b001111) //lui
	begin
		RegDst_o<=1'b0;
		ALUSrc_o<=1'b1;
		RegWrite_o<=1'b1;
		Branch_o<=1'b0;
		ALU_op_o<=3'b110; 
	end
	else if(instr_op_i==6'b001101) //ori
	begin 
		RegDst_o<=1'b0;
		ALUSrc_o<=1'b1;
		RegWrite_o<=1'b1;
		Branch_o<=1'b0;
		ALU_op_o<=3'b100;
	end
	else if(instr_op_i==6'b000101) //bne
	begin
		RegDst_o<=1'b0;
		ALUSrc_o<=1'b0;
		RegWrite_o<=1'b0;
		Branch_o<=1'b1;
		ALU_op_o<=3'b101;
	end
end
endmodule





                    
                    