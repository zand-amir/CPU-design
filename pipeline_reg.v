
`include "register.v"

module pipeline_reg(clock, clear, new_value, curr_value);
	input wire clock;
	input wire clear;
	input wire [15:0] new_value;
	output wire [15:0] curr_value;
	
	wire [31:0] gated_new_value;
	
	assign gated_new_value = clear ? 16'b0 : new_value;
	
	register r(clock, 1'b1, gated_new_value, curr_value);
	
endmodule

module pipeline_reg_stall(clock, clear, stall, new_value, curr_value);
	input wire clock;
	input wire clear;
	input wire stall;
    input wire [15:0] new_value;
	output wire [15:0] curr_value;

	wire [15:0] gated_new_value;
	
	assign gated_new_value = clear ? 32'b0 : new_value;
	register r(clock, stall, gated_new_value, curr_value);
	
endmodule
	
module pipeline_reg_16bit(clock, clear, new_value, curr_value);
	input wire clock;
	input wire clear;
	input wire [15:0] new_value;
	output wire [15:0] curr_value;
	
	wire [15:0] adj_new_value;
	wire [15:0] adj_curr_value;

	assign adj_new_value[15:0] = new_value;
	
	
	assign curr_value = adj_curr_value[15:0];

	pipeline_reg value_reg(clock, clear, adj_new_value, adj_curr_value);
endmodule

module pipeline_reg_1bit(clock, clear, new_value, curr_value);
	input wire clock;
	input wire clear;
	input wire new_value;
	output wire curr_value;

	wire [15:0] adj_new_value;
	wire [15:0] adj_curr_value;

	assign adj_new_value[0] = new_value;
	assign adj_new_value[15:1] = 0;
	
	assign curr_value = adj_curr_value[0];

	pipeline_reg value_reg(clock, clear, adj_new_value, adj_curr_value);
endmodule


module pipeline_reg_5bit(clock, clear, new_value, curr_value);
	input wire clock;
	input wire clear;
	input wire [4:0] new_value;
	output wire [4:0] curr_value;
	
	wire [15:0] adj_new_value;
	wire [15:0] adj_curr_value;

	assign adj_new_value[4:0] = new_value;
	assign adj_new_value[15:5] = 0;
	
	assign curr_value = adj_curr_value[4:0];

	pipeline_reg value_reg(clock, clear, adj_new_value, adj_curr_value);
endmodule