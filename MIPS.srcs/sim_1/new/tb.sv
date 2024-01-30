`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/16 21:07:36
// Design Name: 
// Module Name: tb
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


module tb;
logic[31:0] IF,ID,EX,MEM,WB;
logic CLK = 0, reset = 0;
logic StallF,StallD,ForwardAD, ForwardBD,ForwardAE,ForwardBE;
logic [10:0] disp_7seg;
logic ERR1;
logic [31:0] ans;
Top dut(CLK, reset,IF,ID,EX,MEM,WB,StallF,StallD,ForwardAD, ForwardBD, ForwardAE,ForwardBE, ERR1, disp_7seg, ans);    // ²¨ÐÎÍ¼
//Top dut(CLK, reset, ERR1, disp_7seg);  // ÉÏ°å×Ó

initial begin
    reset = 1;
    #20;
    reset = 0;
    #10;
end

always begin
    CLK = 1; #5;
    CLK = 0; #5;
end

endmodule
