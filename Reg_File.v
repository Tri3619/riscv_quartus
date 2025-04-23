module Reg_File(
    input clk, 
    input rst, 
    input RegWrite,
    input [4:0] Rs1, Rs2, Rd,
    input [31:0] Write_data,
    output [31:0] read_data1, read_data2
);

reg [31:0] Registers [31:0];
integer i;
// Khởi tạo giá trị ban đầu
initial begin
    
    for (i = 0; i < 32; i = i + 1)
        Registers[i] = 0;

    // Khởi tạo giá trị đặc biệt nếu cần
    Registers[0]  = 0;
    Registers[1]  = 4;
    Registers[2]  = 2;
    Registers[3]  = 24;
    Registers[4]  = 4;
    Registers[5]  = 1;
    Registers[6]  = 44;
    Registers[7]  = 4;
    Registers[8]  = 2;
    Registers[9]  = 1;
    Registers[10] = 23;
    Registers[11] = 4;
    Registers[12] = 90;
    Registers[13] = 10;
    Registers[14] = 20;
    Registers[15] = 30;
    Registers[16] = 40;
    Registers[17] = 50;
    Registers[18] = 60;
    Registers[19] = 70;
    Registers[20] = 80;
    Registers[21] = 80;
    Registers[22] = 90;
    Registers[23] = 70;
    Registers[24] = 60;
    Registers[25] = 65;
    Registers[26] = 4;
    Registers[27] = 32;
    Registers[28] = 12;
    Registers[29] = 34;
    Registers[30] = 5;
    Registers[31] = 10;
end

// Reset và ghi
integer k;
always @(posedge clk) begin
    if (rst) begin
        for (k = 0; k < 32; k = k + 1)
            Registers[k] <= 32'b0;
    end else if (RegWrite && Rd != 0) begin
        Registers[Rd] <= Write_data;
    end
end

// Bypass logic (forwarding) khi đang ghi cùng lúc với đọc
assign read_data1 = (RegWrite && (Rs1 == Rd) && (Rd != 0)) ? Write_data : Registers[Rs1];
assign read_data2 = (RegWrite && (Rs2 == Rd) && (Rd != 0)) ? Write_data : Registers[Rs2];

endmodule
