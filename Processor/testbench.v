`timescale 1ns / 1ps
`include "PROCESSOR.v"
module PROCESSOR_tb();
    reg clock;
    reg reset;
    wire zero;

    // Instantiate the Processor
    PROCESSOR uut (
        .clock(clock), 
        .reset(reset), 
        .zero(zero)
    );

    // Clock generation (10ns period)
    always #5 clock = ~clock;

    initial begin
        clock = 0;
        reset = 1;
        #20 reset = 0; // Release reset

        // Run long enough to see several instructions from INST_MEM
        #250; 
        
        $display("Simulation Finished");
        $finish;
    end

    // Monitor internal signals using hierarchical paths
    initial begin
        $display("Time | PC | Instr Code | ALU In1   | ALU In2   | Ctrl | ALU Result | Zero");
        $display("---------------------------------------------------------------------------");
        $monitor("%4t | %h | %h | %h | %h |  %b  |  %h  |  %b", 
            $time,
            uut.IFU_module.PC,                       // Accessing PC in IFU [cite: 30]
            uut.IFU_module.Instruction_Code,        // Accessing Instruction in IFU [cite: 30]
            uut.datapath_module.alu_module.in1,      // Accessing Input 1 in ALU [cite: 1, 28]
            uut.datapath_module.alu_module.in2,      // Accessing Input 2 in ALU [cite: 1, 28]
            uut.datapath_module.alu_module.alu_control, // Accessing Control in ALU [cite: 1, 28]
            uut.datapath_module.alu_module.alu_result,  // Accessing Result in ALU [cite: 1, 28]
            zero
        );
    end
    initial begin
	    $fsdbDumpfile("pro.fsdb");
	    $fsdbDumpvars(0,PROCESSOR_tb);
	end

endmodule
