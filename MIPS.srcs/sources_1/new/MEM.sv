`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/18 15:47:39
// Design Name: 
// Module Name: MEM
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


module MEM(input logic CLK,
               input logic RegWriteM, MemtoRegM, MemWriteM,
               input logic [31:0] ALUOutM, WriteDataM, PCF,
               input logic [4:0] WriteRegM,
               output logic [31:0] ReadDataM, InstrF);


myMem myMem(.CLK(CLK), .we(MemWriteM), .Dra(ALUOutM), .Drd(ReadDataM), .Dwd(WriteDataM), .Ira(PCF), .Ird(InstrF));

endmodule
