module alu(input  logic [31:0] a,
			  input  logic [31:0] b, 
			  input  logic [2:0]  control,
			  output logic [31:0] out, 
			  output logic zero);
		logic [31:0]tmp;
		always @(a, b, control)
        begin
				if (control == 3'b010)    // And
					out = a & b;
				else if( control == 3'b011)   // Or
					out = a | b;
				else if( control == 3'b000)   // Add
					out = a + b;
				else if( control == 3'b001)   // SUB
					out = a - b;
				else if( control == 3'b101)   // SLT
				begin
					tmp = a - b;
					out[31:1] = 31'h0;
					out[0] = (tmp[31] ==  1'b1);
				end
				if (out == 32'h00000000)
					zero = 1;
				else
					zero = 0;
		end
endmodule 