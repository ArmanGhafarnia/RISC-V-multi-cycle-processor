module datapath(input  logic        clk,
					 input  logic        reset,
					 input  logic        MemWrite,
					 input  logic        RegWrite,
					 input  logic        IRWrite,
					 input  logic        PCWrite,
					 input  logic        AdrSrc,
					 input  logic [1:0]  ALUSrcA,
					 input  logic [1:0]  ALUSrcB,
					 input  logic [1:0]  ImmSrc,
					 input  logic [1:0]  ResultSrc,
					 input  logic [2:0]  ALUControl,
					 input  logic [31:0] rd,
					 output logic        Zero,
					 output logic [31:0] instr,
					 output logic [31:0] Adr,
					 output logic [31:0] WriteData);
			
			logic [31:0] Result;
			logic [31:0] SrcA, SrcB;
			logic [31:0] ALUOut;
			logic [31:0] OldPC, A;
			logic [31:0] PC;
			logic [31:0] ImmExt;
			logic [31:0] data;
			logic [31:0] rd1, rd2;
			logic [31:0] ALUResult;
			
			flopenr #(32) PCReg(clk, reset, PCWrite,Result, PC);
			
			mux2          PCmux(PC, Result, AdrSrc, Adr);
			
			flopenr #(64) pc_instr(clk, reset, IRWrite, {rd, PC}, {instr, OldPC});
			
			flopr   #(32) Data(clk, reset, rd, data);
			
			reg_file      regfile(clk, RegWrite, instr[19:15], instr[24:20],
										 instr[11:7], Result, rd1, rd2);
			
			flopr   #(64) wrA(clk, reset, {rd1, rd2}, {A, WriteData});
			
			extend        ext(instr[31:7], ImmSrc, ImmExt);
			
			mux3          a(PC, OldPC, A, ALUSrcA, SrcA);
			
			mux3          b(WriteData, ImmExt, 32'd4, ALUSrcB, SrcB);
			
			alu           ALU1(SrcA, SrcB, ALUControl, ALUResult, Zero);
			
			flopr   #(32) aluflop(clk, reset, ALUResult, ALUOut);
			
			mux3          resmux(ALUOut, data, ALUResult, ResultSrc, Result);
			
endmodule 