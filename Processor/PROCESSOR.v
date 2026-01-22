`include "CONTROL.v"
`include "DATAPATH.v"
`include "IFU.v"

module PROCESSOR( 
    input clock, 
    input reset,
    output zero
);

    wire [31:0] instruction_code;
    wire [3:0] alu_control;
    wire regwrite;

    IFU IFU_module(
        .clock(clock), 
        .reset(reset), 
        .instruction_code(instruction_code)
        );
	
    CONTROL control_module(
        .funct7(instruction_code[31:25]), 
        .funct3(instruction_code[14:12]), 
        .opcode(instruction_code[6:0]), 
        .alu_control(alu_control), 
        .regwrite_control(regwrite), 
        );
	
    DATAPATH datapath_module(
        .read_reg_num1(instruction_code[19:15]), 
        .read_reg_num2(instruction_code[24:20]), 
        .write_reg(instruction_code[11:7]), 
        .alu_control(alu_control), 
        .regwrite(regwrite), 
        .clock(clock), 
        .reset(reset), 
        .zero_flag(zero)
        );

endmodule