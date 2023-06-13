module alu_dec(input  logic [1:0] aluop,
					input  logic       op5,
					input  logic [2:0] func3,
					input  logic       func7b5,
					output logic [2:0] alucontrol);
	logic RtypeSub;
	assign RtypeSub = func7b5 & op5; // TRUE for R–type subtract
	always_comb
		case(aluop)
			2'b00: 
			alucontrol = 3'b000; // addition
			2'b01: 
			alucontrol = 3'b001; // subtraction
			default:
				case(func3) // R–type or I–type ALU
					3'b000: 
						if (RtypeSub)
							alucontrol = 3'b001; // sub
						else
							alucontrol = 3'b000; // add, addi
					3'b010: 
						alucontrol = 3'b101; // slt, slti
					3'b110: 
						alucontrol = 3'b011; // or, ori
					3'b111: 
						alucontrol = 3'b010; // and, andi
					default: 
						alucontrol = 3'bxxx;
				endcase
		endcase
	endmodule 