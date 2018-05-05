//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
		module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port 
input         clk_i;
input         rst_i;

//Internal Signles
wire [32-1:0] pc_out;
wire [32-1:0] add1_out;
wire [32-1:0] add2_out;
wire [32-1:0] im_out;

wire RegDst;
wire RegWrite;
wire ALUSrc;   
wire Branch;  
wire [3-1:0] ALU_op;

wire [5-1:0] mux1_out;
wire [32-1:0] RF_RD1_out;
wire [32-1:0] RF_RD2_out;
wire [4-1:0] ALUCtrl_out;

wire [32-1:0] EX_out;
wire [32-1:0] mux2_out;
wire [32-1:0] mux3_out;
wire          ALU_zero;
wire [32-1:0] ALU_out;

wire [32-1:0] shift_out;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(mux3_out) ,  
	    .pc_out_o(pc_out) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_out),     
	    .sum_o(add1_out)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(im_out)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(im_out[20:16]),
        .data1_i(im_out[15:11]),
        .select_i(RegDst),
        .data_o(mux1_out)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(im_out[25:21]) ,  
        .RTaddr_i(im_out[20:16]) ,  
        .RDaddr_i(mux1_out) ,  
        .RDdata_i(ALU_out)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RF_RD1_out) ,  
        .RTdata_o(RF_RD2_out)   
        );
	
Decoder Decoder(
        .instr_op_i(im_out[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALU_op),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch)   
	    );

ALU_Ctrl AC(
        .funct_i(im_out[5:0]),   
        .ALUOp_i(ALU_op),   
        .ALUCtrl_o(ALUCtrl_out) 
        );
	
Sign_Extend SE(
        .data_i(im_out[15:0]),
        .data_o(EX_out)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RF_RD2_out),
        .data1_i(EX_out),
        .select_i(ALUSrc),
        .data_o(mux2_out)
        );	
		
ALU ALU(
        .src1_i(RF_RD1_out),
	    .src2_i(mux2_out),
		 .src3_i(im_out[15:0]),
	    .ctrl_i(ALUCtrl_out),
	    .result_o(ALU_out),
		.zero_o(ALU_zero)
	    );
		
Adder Adder2(
        .src1_i(add1_out),     
	    .src2_i(shift_out),     
	    .sum_o(add2_out)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(EX_out),
        .data_o(shift_out)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(add1_out),
        .data1_i(add2_out),
        .select_i(ALU_zero&Branch),
        .data_o(mux3_out)
        );	
always @(posedge clk_i  )
begin
		  $display("");
		  $display("%b",im_out);
        $display("pc_out=%b",pc_out);
        $display("add1_out=%b",add1_out);
        $display("add2_out=%b",add2_out);
        $display("im_out=%b",im_out);
        $display("RegDst=%b",RegDst);
        $display("RegWrite=%b",RegWrite);
        $display("ALUSrc=%b",ALUSrc);
        $display("Branch=%b",Branch);
        $display("ALU_op=%b",ALU_op);
        $display("mux1_out=%b",mux1_out);
        $display("RF_RD1_out=%b",RF_RD1_out);
        $display("RF_RD2_out=%b",RF_RD2_out);
        $display("ALUCtrl_out=%b",ALUCtrl_out);
        $display("EX_out=%b",EX_out);
        $display("mux2_out=%b",mux2_out);
		  $display("mux3_out=%b",mux3_out);
        $display("ALU_zero=%b",ALU_zero);
        $display("ALU_out=%b",ALU_out);
        $display("shift_out=%b",shift_out);
end


endmodule
		  


