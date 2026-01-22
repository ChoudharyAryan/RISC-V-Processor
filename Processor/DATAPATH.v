`include "REG_FILE.v"
`include "ALU.v"

module DATAPATH(
    input [4:0]read_reg_num1,
    input [4:0]read_reg_num2,
    input [4:0]write_reg,
    input [3:0]alu_control,
    input regwrite,
    input clock,
    input reset,
    output zero_flag
);

    // Declaring internal wires that carry data
    wire [31:0]read_data1;
    wire [31:0]read_data2;
    wire [31:0]write_data;

    reg [3:0] alu_control_reg; // Register to hold ALU control signals
    reg       regwrite_reg;      // Register to hold regwrite signal
    reg [4:0] write_reg_reg;   // Register to hold write register address
    // Sequential logic to update control signals on clock edge
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            alu_control_reg <= 0;
            regwrite_reg <=0;
            write_reg_reg <=0;
        end else begin
            alu_control_reg <= alu_control;
            regwrite_reg <= regwrite;
            write_reg_reg <= write_reg;
        end
    end

    // Instantiating the register file
    REG_FILE reg_file_module(
    .read_reg_num1(read_reg_num1),
    .read_reg_num2(read_reg_num2),
    .write_reg(write_reg_reg), // Delayed write_reg to synchronize with data
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2),
    .regwrite(regwrite_reg), //Delayed regwrite signal to synchronize with data
    .clock(clock),
    .reset(reset)
    );

    // Instanting ALU
    ALU alu_module(
        .in1(read_data1), 
        .in2(read_data2), 
        .alu_control(alu_control_reg), // Delayed ALU control signals to synchronize with data
        .alu_result(write_data), 
        .zero_flag(zero_flag)
    );
	 
endmodule