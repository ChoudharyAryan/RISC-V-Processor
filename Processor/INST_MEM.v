module INST_MEM(
    input [31:0] PC,
    input reset,
    output [31:0] Instruction_Code,
    input clock
);
    reg [7:0] Memory [64:0];

    // Initializing memory when reset is one
    always @(posedge clock or posedge reset)
    begin
        if(reset == 1)
        begin
            Instruction_Code <= 0;
            // Setting 32-bit instruction: add t1, s0,s1 => 0x00940333 
            Memory[3] <= 8'h00;
            Memory[2] <= 8'h94;
            Memory[1] <= 8'h03;
            Memory[0] <= 8'h33;
            // Setting 32-bit instruction: sub t2, s2, s3 => 0x413903b3
            Memory[7] <= 8'h41;
            Memory[6] <= 8'h39;
            Memory[5] <= 8'h03;
            Memory[4] <= 8'hb3;
            // Setting 32-bit instruction: xor t3, s6, s7 => 0x017b4e33
            Memory[15] <= 8'h01;
            Memory[14] <= 8'h7b;
            Memory[13] <= 8'h4e;
            Memory[12] <= 8'h33;
            // Setting 32-bit instruction: sll t4, s8, s9
            Memory[19] <= 8'h01;
            Memory[18] <= 8'h9c;
            Memory[17] <= 8'h1e;
            Memory[16] <= 8'hb3;
            // Setting 32-bit instruction: srl t5, s10, s11
            Memory[23] <= 8'h01;
            Memory[22] <= 8'hbd;
            Memory[21] <= 8'h5f;
            Memory[20] <= 8'h33;
            // Setting 32-bit instruction: and t6, a2, a3
            Memory[27] <= 8'h00;
            Memory[26] <= 8'hd6;
            Memory[25] <= 8'h7f;
            Memory[24] <= 8'hb3;
            // Setting 32-bit instruction: or a7, a4, a5
            Memory[31] <= 8'h00;
            Memory[30] <= 8'hf7;
            Memory[29] <= 8'h68;
            Memory[28] <= 8'hb3;
            // Setting 32-bit instruction SLT x10, x1, x2 (0x0020a533)
            Memory[35] <= 8'h00;
            Memory[34] <= 8'h20;
            Memory[33] <= 8'ha5;
            Memory[32] <= 8'h33;
            // Setting 32-bit instruction SRA x13, x10, x1 (0x401556b3)
            Memory[39] <= 8'h40;
            Memory[38] <= 8'h15;
            Memory[37] <= 8'h56;
            Memory[36] <= 8'hb3;
            // Setting 32-bit instruction SLTU x12, x2, x3 (0x00313633) 
            Memory[43] <= 8'h00;
            Memory[42] <= 8'h31;
            Memory[41] <= 8'h36;
            Memory[40] <= 8'h33;                         

        end else begin
            Instruction_Code <= {Memory[PC+3],Memory[PC+2],Memory[PC+1],Memory[PC]};
        end
    end

endmodule