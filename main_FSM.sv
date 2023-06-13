module main_FSM(input  logic       clk,
					 input  logic       rst,
					 input  logic [6:0] op,
					 output logic       branch,
					 output logic       pcupdate,
					 output logic       regwrite,
					 output logic       memwrite,
					 output logic       irwrite,
					 output logic [1:0] resultsrc,
					 output logic [1:0] alusrca,
					 output logic [1:0] alusrcb,
					 output logic       adrsrc,
					 output logic [1:0] aluop);
	logic [3:0] current_state, next_state;
	
	always_ff @(posedge clk, posedge rst)
		if(rst)
			current_state <= 0;
		else
			current_state <= next_state;
		
		
		always_comb
			begin
				case(current_state)
					0:
					begin
						next_state = 1;
					end
					1:
					begin
						if     (op == 7'b0000011 | op == 7'b0100011) next_state = 2;
						else if(op == 7'b0110011)                    next_state = 6;
						else if(op == 7'b0010011)                    next_state = 8;
						else if(op == 7'b1101111)                    next_state = 9;
						else if(op == 7'b1100011)                    next_state = 10;
						else                                         next_state = 2;
					end
					2:
					begin
						if     (op == 7'b0000011) next_state = 3;
						else if(op == 7'b0100011) next_state = 5;
						else                      next_state = 2;
					end
					3:
					begin
						next_state = 4;
					end
					4:
					begin
						next_state = 0;
					end
					5:
					begin
						next_state = 0;
					end
					6:
					begin
						next_state = 7;
					end
					7:
					begin
						next_state = 0;
					end
					8:
					begin
						next_state = 7;
					end
					9:
					begin
						next_state = 7;
					end
					10:
					begin
						next_state = 0;
					end
					default:
					begin
						next_state = 0;
					end
				endcase
			end
		
		always_comb
		begin
			case(current_state)
		0:
			begin
				adrsrc = 0;
				irwrite = 1;
				alusrca = 2'b00;
				alusrcb = 2'b10;
				aluop = 2'b00;
				resultsrc = 2'b10;
				pcupdate = 1;
				regwrite = 0;
				memwrite = 0;
				branch = 0;
			end
		1:
			begin
				alusrca = 2'b01;
				alusrcb = 2'b01;
				aluop = 2'b00;
				regwrite = 0;
				memwrite = 0;
				irwrite = 0;
				resultsrc = 0;
				adrsrc = 0;
				pcupdate = 0;
				branch = 0;
			end
		2:
			begin
				alusrca = 2'b10;
				alusrcb = 2'b01;
				aluop = 2'b00;
				regwrite = 0;
				memwrite = 0;
				irwrite = 0;
				resultsrc = 0;
				adrsrc = 0;
				pcupdate = 0;
				branch = 0;
			end
		3:
			begin
				resultsrc = 2'b00;
				adrsrc = 1'b1;
				regwrite = 0;
				memwrite = 0;
				irwrite = 0;
				alusrca = 0;
				alusrcb = 0;
				aluop = 0;
				pcupdate = 0;
				branch = 0;
			end
		4:
			begin
				resultsrc = 2'b01;
				regwrite = 1;
				memwrite = 0;
				irwrite = 0;
				alusrca = 0;
				alusrcb = 0;
				adrsrc = 0;
				aluop = 0;
				pcupdate = 0;
				branch = 0;
			end
		5:
			begin
				resultsrc = 2'b00;
				adrsrc = 1;
				memwrite = 1;
				regwrite = 0;
				irwrite = 0;
				alusrca = 0;
				alusrcb = 0;
				aluop = 0;
				pcupdate = 0;
				branch = 0;
			end
			6:
				begin
					alusrca = 2'b10;
					alusrcb = 2'b00;
					aluop = 2'b10;
					regwrite = 0;
					memwrite = 0;
					irwrite = 0;
					resultsrc = 0;
					adrsrc = 0;
					pcupdate = 0;
					branch = 0;
				end
			7:
				begin
					resultsrc = 2'b00;
					regwrite = 1;
					memwrite = 0;
					irwrite = 0;
					alusrca = 0;
					alusrcb = 0;
					adrsrc = 0;
					aluop = 0;
					pcupdate = 0;
					branch = 0;
				end
			8:
				begin
					alusrca = 2'b10;
					alusrcb = 2'b01;
					aluop = 2'b10;
					regwrite = 0;
					memwrite = 0;
					irwrite = 0;
					resultsrc = 0;
					adrsrc = 0;
					pcupdate = 0;
					branch = 0;
				end
			9:
				begin
					alusrca = 2'b01;
					alusrcb = 2'b10;
					aluop = 2'b00;
					resultsrc = 2'b00;
					pcupdate = 1;
					regwrite = 0;
					memwrite = 0;
					irwrite = 0;
					adrsrc = 0;
					branch = 0;
				end
			10:
				begin
					alusrca = 2'b10;
					alusrcb = 2'b00;
					aluop = 2'b01;
					resultsrc = 2'b00;
					branch = 1;
					regwrite = 0;
					memwrite = 0;
					irwrite = 0;
					adrsrc = 0;
					pcupdate = 0;
					branch = 1;
				end
			default:
				begin
					adrsrc = 0;
					irwrite = 1;
					alusrca = 2'b00;
					alusrcb = 2'b10;
					aluop = 2'b00;
					resultsrc = 2'b10;
					pcupdate = 1;
					regwrite = 0;
					memwrite = 0;
					branch = 0;
				end
			endcase
		end
endmodule						