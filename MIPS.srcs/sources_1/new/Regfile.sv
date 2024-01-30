`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/18 17:51:01
// Design Name: 
// Module Name: Regfile
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


module Regfile(input logic CLK, WE3,
               input logic [4:0] RA1, RA2, WA3,
               input logic [31:0] WD3,
               output logic [31:0] RD1, RD2,
               output logic [31:0] s1);

logic [31:0] RF[31:0];
integer i = 0;
initial begin
    for (i=0; i < 32; i = i + 1) begin
        RF[i] = 0;
    end
end
always_ff @ (negedge CLK) begin
    if (WE3) RF[WA3] <= WD3;
end

assign RD1 = (RA1 != 0) ? RF[RA1] : 0;
assign RD2 = (RA2 != 0) ? RF[RA2] : 0;
assign s1 = RF[17];
endmodule
