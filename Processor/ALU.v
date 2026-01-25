module ALU (
    input [31:0] in1,in2, 
    input[3:0] alu_control,
    output reg [31:0] alu_result,
    output reg zero_flag
);

    always @(*)
    begin
        // Operating based on control input
        case(alu_control)

        4'b0000: alu_result = in1&in2;// AND
        4'b0001: alu_result = in1|in2;// OR
        4'b0010: alu_result = in1+in2;// ADD
        4'b0100: alu_result = in1-in2;// SUB
        4'b1000: alu_result = ($signed(in1) < $signed(in2)) ? 1 : 0; // SLT signed
        4'b1001: alu_result = (in1 < in2) ? 1 : 0;// SLTU
        4'b1010: alu_result = $signed(in1)>>>in2[4:0];// SRA
        4'b0011: alu_result = in1<<in2[4:0];// SLL
        4'b0101: alu_result = in1>>in2[4:0];// SRL
        4'b0111: alu_result = in1^in2;// XOR
        default: alu_result = 0;
        endcase
        // Setting Zero_flag if ALU_result is zero
        zero_flag = (alu_result == 0) ? 1'b1 : 1'b0;
        
    end
endmodule
