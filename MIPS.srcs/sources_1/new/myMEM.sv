`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/18 20:07:59
// Design Name: 
// Module Name: myMem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module myMem(input logic CLK, we,
               input logic [31:0] Ira, Dra,
               input logic [31:0] Dwd,
               output logic [31:0] Ird, Drd);

logic [31:0] RAM[127:0];

initial begin

    for (int i = 0; i < 128; i = i + 1) RAM[i] = 0;
    // test
    RAM[0] = 32'h20090002;
    RAM[1] = 32'h0009F820;
    RAM[2] = 32'h200A0004;
    RAM[3] = 32'h01495822;
    RAM[4] = 32'h01406024;
    RAM[5] = 32'h01899825;
    RAM[6] = 32'h024A8820;
    /*
    addi $t1, $0, 2
    add $ra, $0, $t1
    addi $t2 , $0, 4
    sub $t3, $t2, $t1
    and $t4, $t2, $0
    or  $s3, $t4, $t1
    add $s1, $s2, $t2
    
    输出s1:理论值为4
    */

end

always_ff @ (negedge CLK) begin
    if (we) RAM[Dra[31:2]] <= Dwd;
end

assign Ird = RAM[Ira[31:2]];
assign Drd = RAM[Dra[31:2]];

endmodule
