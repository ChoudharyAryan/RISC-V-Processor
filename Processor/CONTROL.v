module CONTROL(
    input [6:0] funct7,
    input [2:0] funct3,
    input [6:0] opcode,
    output reg [3:0] alu_control,
    output reg regwrite_control
);
    always @(*) begin
        if (opcode == 7'b0110011) begin // R-type instructions

            regwrite_control = 1;

            case (funct3)
                0: begin
                    if(funct7 == 0)
                    alu_control = 4'b0010; // ADD
                    else if(funct7 == 32)
                    alu_control = 4'b0100; // SUB
                end
                1: alu_control = 4'b0011; // SLL
                2: alu_control = 4'b1000; // SLT Set Less Than (Signed) 
                3: alu_control = 4'b1001; // SLTU Set Less Than (Unsigned)
		4: alu_control = 4'b0111; // XOR
                5: begin
                    if (funct7 == 32) begin
                        alu_control = 4'b1010; // SRA
                    end else if(funct7 == 0) begin
                        alu_control = 4'b0101; // SRL
                    end
                end   
                6: alu_control = 4'b0001; // OR
                7: alu_control = 4'b0000; // AND			
                default: alu_control = 4'b0000; // Default case
            endcase

        end else begin
            alu_control = 0;
            regwrite_control = 0;
        end

    end

endmodule
