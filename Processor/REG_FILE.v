module REG_FILE(
    input [4:0] read_reg_num1,
    input [4:0] read_reg_num2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2,
    input regwrite,
    input clock,
    input reset
);

    reg [31:0] reg_memory [31:0];
    integer i;
    wire [31:0]actual_read1;
    wire [31:0]actual_read2;
    // Internal Forwarding: If writing and reading same reg, return write_data
    assign actual_read1 = (regwrite && (write_reg == read_reg_num1)) ? write_data : reg_memory[read_reg_num1];
    assign actual_read2 = (regwrite && (write_reg == read_reg_num2)) ? write_data : reg_memory[read_reg_num2];

    always @(posedge clock or posedge reset)
    begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                reg_memory[i] <= i*i;
            end
            read_data1 <= 0;
            read_data2 <= 0;
        end
        else begin
            if (regwrite && (write_reg !=0)) begin
                reg_memory[write_reg] <= write_data;
            end

            read_data1 <= (read_reg_num1 == 0) ? 0 : actual_read1;
            read_data2 <= (read_reg_num2 == 0) ? 0 : actual_read2;
        end
    end


endmodule
