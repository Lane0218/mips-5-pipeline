`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/18 14:20:05
// Design Name: 
// Module Name: ALU
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


module ALU(input logic [2:0] Control,
           input logic [31:0] A, B,
           output logic [31:0] ALUOut);
always_comb begin
	case (Control)
			3'b000: ALUOut = A & B;
			3'b001: ALUOut = A | B;
			3'b010: ALUOut = A + B;
			3'b100: ALUOut = A & ~B;
			3'b101: ALUOut = A | ~B;
			3'b110: ALUOut = A - B;
			3'b111: ALUOut = {31'b0, A < B};
	endcase
end
endmodule
