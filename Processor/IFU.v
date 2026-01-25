`include "INST_MEM.v"

module IFU(
    input clock,reset,
    output [31:0] Instruction_Code
);
reg [31:0] PC = 0;

    INST_MEM instr_mem(
        .PC(PC), 
        .reset(reset), 
        .Instruction_Code(Instruction_Code), 
        .clock(clock)
        );

    always @(posedge clock, posedge reset)
    begin
        if(reset == 1)  
        PC <= 0;
        else
        PC <= PC+4;   
    end

endmodule
