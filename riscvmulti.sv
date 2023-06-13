module riscvmulti(input  logic        clk, reset,
                  output logic        MemWrite,
                  output logic [31:0] Adr, WriteData,
                  input  logic [31:0] ReadData);
		logic RegWrite, IRWrite, PCWrite, AdrSrc, Zero;
		logic [1:0] ALUSrcA, ALUSrcB, ImmSrc, ResultSrc;
		logic [2:0] ALUControl;
		logic [31:0] instr;
		
		controller c (clk, reset, instr[6:0], instr[14:12], instr[30], Zero, ImmSrc, ALUSrcA, ALUSrcB, ResultSrc, AdrSrc, ALUControl, IRWrite, PCWrite, RegWrite, MemWrite);
		datapath   dp(clk, reset, MemWrite, RegWrite, IRWrite, PCWrite, AdrSrc, ALUSrcA, ALUSrcB, ImmSrc, ResultSrc, ALUControl, ReadData, Zero, instr, Adr, WriteData);
endmodule 