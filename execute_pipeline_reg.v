

`include "pipeline_reg.v"

module execute_pipeline_reg(clk, FlushE, RegWriteD, MemtoRegD, MemWriteD, ALUControlD,
	ALUSrcD, RegDstD, RD1D, RD2D, RsD, RtD, RdD, SignImmD,
	RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE,
	RD1E, RD2E, RsE, RtE, RdE, SignImmE);

	// The clock.
	input wire clk;

	// The flag from the Hazard Unit raised when this pipeline stage should be
	// flushed.
	input wire FlushE;

	/*** The following inputs are fed from the Decode pipeline stage ***/

	// The control signal denoting whether a register is written to.
	input wire RegWriteD;

	// The control signal denoting whether data is being written from
	// memory to a register.
	input wire MemtoRegD;

	// The control signal denoting whether main memory is being written to.
	input wire MemWriteD;

	// The four-bit ALU op denoting which operation the ALU should perform.
	input wire [3:0] ALUControlD;

	// The control signal denoting whether the ALU input is an immediate value.
	input wire ALUSrcD;

	// The control signal denoting whether the write reg is rd (R-type instr).
	input wire RegDstD;

	// The data read from the first source register (rs).
	input wire [31:0] RD1D;

	// The data read from the second source register (rt).
	input wire [31:0] RD2D;

	// The first source register.
	input wire [4:0] RsD;

	// The second source register.
	input wire [4:0] RtD;

	// The destination register.
	input wire [4:0] RdD;

	// The sign-extended immediate value.
	input wire [31:0] SignImmD;

    
	// The control signal denoting whether a register is written to.
	output wire RegWriteE;

	// The control signal denoting whether data is being written from
	// memory to a register.
	output wire MemtoRegE;

	// The control signal denoting whether main memory is being written to.
	output wire MemWriteE;

	// The four-bit ALU op denoting which operation the ALU should perform.
	output wire [3:0] ALUControlE;

	// The control signal denoting whether the ALU input is an immediate value.
	output wire ALUSrcE;

	// The control signal denoting whether the write reg is rd (R-type instr).
	output wire RegDstE;

	// The data read from the first source register (rs).
	output wire [31:0] RD1E;

	// The data read from the second source register (rt).
	output wire [31:0] RD2E;

	// The first source register.
	output wire [4:0] RsE;

	// The second source register.
	output wire [4:0] RtE;

	// The destination register.
	output wire [4:0] RdE;

	// The sign-extended immediate value.
	output wire [31:0] SignImmE;

	//
	//there is no 1 bit register
 	pipeline_reg_4bit reg_write(clk, !FlushE, RegWriteD, RegWriteE);
 	pipeline_reg_4bit mem_to_reg(clk, !FlushE, MemtoRegD, MemtoRegE);
 	pipeline_reg_4bit mem_write(clk, !FlushE, MemWriteD, MemWriteE);
 	pipeline_reg_4bit alu_src(clk, !FlushE, ALUSrcD, ALUSrcE);
 	pipeline_reg_4bit reg_dst(clk, !FlushE, RegDstD, RegDstE);
	
 	
 	pipeline_reg_4bit rs(clk, !FlushE, RsD, RsE);
 	pipeline_reg_4bit rt(clk, !FlushE, RtD, RtE);
 	pipeline_reg_4bit rd(clk, !FlushE, RdD, RdE);
   

 	// 16-bit values to propagate
 	pipeline_reg rd1(clk, !FlushE, RD1D, RD1E);
 	pipeline_reg rd2(clk, !FlushE, RD2D, RD2E);
 	pipeline_reg sign_imm(clk, !FlushE, SignImmD, SignImmE);
	
 	pipeline_reg_4bit alu_control(clk, !FlushE, ALUControlD, ALUControlE);
	

endmodule
