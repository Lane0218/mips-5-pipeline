`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/17 10:14:24
// Design Name: 
// Module Name: ID
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


module ID(input logic CLK, RegWriteW, 
              input logic ForwardAD, ForwardBD,
              input logic [4:0] WriteRegW,
              input logic [31:0] ResultW, PCPlus4D, InstrD, ALUOutM,
              output logic PCSrcD, RegWriteD, MemtoRegD, MemWriteD,
              output logic [2:0] ALUControlD,
              output logic ALUSrcD, RegDstD, BranchEQD, BranchNED,
              output logic [4:0] RsD, RtD, RdD,
              output logic [31:0] SignImmD, AD, BD, PCBranchD,
              output logic [31:0] ansFinal,
              output logic [27:0] PCJ);

logic [2:0] ALUOp;
always_comb begin
    case(InstrD[31:26])
        6'b000000: {RegWriteD, RegDstD, ALUSrcD, BranchEQD, BranchNED, MemWriteD, MemtoRegD, ALUOp} = 11'b11000_00100; // R type
        6'b100011: {RegWriteD, RegDstD, ALUSrcD, BranchEQD, BranchNED, MemWriteD, MemtoRegD, ALUOp} = 11'b10100_01000; // lw
        6'b101011: {RegWriteD, RegDstD, ALUSrcD, BranchEQD, BranchNED, MemWriteD, MemtoRegD, ALUOp} = 11'b00100_10000; // sw
        6'b000100: {RegWriteD, RegDstD, ALUSrcD, BranchEQD, BranchNED, MemWriteD, MemtoRegD, ALUOp} = 11'b00010_00010; // beq
        6'b001000: {RegWriteD, RegDstD, ALUSrcD, BranchEQD, BranchNED, MemWriteD, MemtoRegD, ALUOp} = 11'b10100_00000; // addi
        6'b000010: {RegWriteD, RegDstD, ALUSrcD, BranchEQD, BranchNED, MemWriteD, MemtoRegD, ALUOp} = 11'b00000_00000; // j

        6'b001100: {RegWriteD, RegDstD, ALUSrcD, BranchEQD, BranchNED, MemWriteD, MemtoRegD, ALUOp} = 11'b10100_00100; // andi
        6'b001101: {RegWriteD, RegDstD, ALUSrcD, BranchEQD, BranchNED, MemWriteD, MemtoRegD, ALUOp} = 11'b10100_00101; // ori
        6'b000101: {RegWriteD, RegDstD, ALUSrcD, BranchEQD, BranchNED, MemWriteD, MemtoRegD, ALUOp} = 11'b00001_00010; // bne
    endcase
    
    case(ALUOp)
        3'b000: ALUControlD = 3'b010;
        3'b100:  case(InstrD[5:0])
                    6'b100000: ALUControlD = 3'b010; // add
                    6'b100010: ALUControlD = 3'b110; // sub
                    6'b100100: ALUControlD = 3'b000; // and
                    6'b100101: ALUControlD = 3'b001; // or
                    6'b101010: ALUControlD = 3'b111; // slt
                    default: ALUControlD = 3'b000;
                endcase
        3'b010: ALUControlD = 3'b110;
        3'b100: ALUControlD = 3'b000;
        3'b101: ALUControlD = 3'b001;
    endcase
end

Regfile RF(.CLK(CLK), .WE3(RegWriteW), .RA1(InstrD[25:21]), .RA2(InstrD[20:16]), .RD1(AD), .RD2(BD), .WA3(WriteRegW), .WD3(ResultW), .s1(ansFinal));

logic [31:0] tmp1, tmp2;
logic EqualD;
always_comb begin
    if (ForwardAD) tmp1 = ALUOutM;
    else tmp1 = AD;
    if (ForwardBD) tmp2 = ALUOutM;
    else tmp2 = BD;
    EqualD = (tmp1 == tmp2);
    PCSrcD = EqualD && BranchEQD || !EqualD && BranchNED;
end


always_comb begin
    RsD = InstrD[25:21];
    RtD = InstrD[20:16];
    RdD = InstrD[15:11];
    SignImmD = {{16{InstrD[15]}}, InstrD[15:0]};
    PCBranchD = (SignImmD<<2) + PCPlus4D;
end

assign PCJ = {InstrD[25:0], 2'b0};
endmodule
