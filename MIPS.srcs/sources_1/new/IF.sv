`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/17 10:41:24
// Design Name: 
// Module Name: IF
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


module IF(input logic CLK, reset,
              input logic PCSrcD,
              input logic StallF,
              input logic [31:0] PCBranchD,
              input logic [27:0] PCJ,
              output logic [31:0] PCPlus4F, PCF);

logic [31:0] pcc, pc;

always_ff @ (posedge CLK) begin
    if (reset) PCF <= 0;
    else if (!StallF) PCF <= pc;
end


assign pcc = PCSrcD ? PCBranchD : PCPlus4F;
assign pc = pcc;
assign PCPlus4F = PCF + 4;


endmodule
