`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/18 18:47:36
// Design Name: 
// Module Name: WB
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


module WB(input logic RegWriteW, MemtoRegW,
              input logic [31:0] ReadDataW, ALUOutW,
              output logic [31:0] ResultW);

always_comb begin
    if (MemtoRegW) ResultW = ReadDataW;
    else ResultW = ALUOutW;
end

endmodule
