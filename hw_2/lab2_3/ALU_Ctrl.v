//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation
always @(*)begin
	if(ALUOp_i==3'b000)ALUCtrl_o=4'b0010;//ADDI
	else if(ALUOp_i==3'b001)ALUCtrl_o=4'b0110;//BEQ
	//R-Type
	else if(funct_i==6'b100000&&ALUOp_i==3'b010)ALUCtrl_o=4'b0010;//ADD
	else if(funct_i==6'b100001&&ALUOp_i==3'b010)ALUCtrl_o=4'b0011;//ADDU
	else if(funct_i==6'b100010&&ALUOp_i==3'b010)ALUCtrl_o=4'b0110;//SUB
	else if(funct_i==6'b100011&&ALUOp_i==3'b010)ALUCtrl_o=4'b1111;//SUBU
	else if(funct_i==6'b100100&&ALUOp_i==3'b010)ALUCtrl_o=4'b0000;//AND
	else if(funct_i==6'b100101&&ALUOp_i==3'b010)ALUCtrl_o=4'b0001;//OR
	else if(funct_i==6'b101010&&ALUOp_i==3'b010)ALUCtrl_o=4'b0111;//SLT
	else if(funct_i==6'b101011&&ALUOp_i==3'b010)ALUCtrl_o=4'b1000;//SLTU
	else if(funct_i==6'b000000&&ALUOp_i==3'b010)ALUCtrl_o=4'b1001;//SLL
	else if(funct_i==6'b000100&&ALUOp_i==3'b010)ALUCtrl_o=4'b1010;//SLLV
	else if(funct_i==6'b000111&&ALUOp_i==3'b010)ALUCtrl_o=4'b1011;//srav
	else if(funct_i==6'b000011&&ALUOp_i==3'b010)ALUCtrl_o=4'b1101;//sra
	//advance
	else if(ALUOp_i==3'b010)ALUCtrl_o=4'b1000;//SLTUI
	else if(ALUOp_i==3'b110)ALUCtrl_o=4'b0101;//LUI
	else if(ALUOp_i==3'b100)ALUCtrl_o=4'b0001;//ORI
	else if(ALUOp_i==3'b101)ALUCtrl_o=4'b1110;//BNE
end
endmodule     





                    
                    
						  