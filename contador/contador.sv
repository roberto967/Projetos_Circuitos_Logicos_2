module contador(modo, clk, reset, OUT);

	input modo,clk, reset;
	output logic [7:0]OUT;

	logic [7:0]estado_atual;

	parameter estado_2 = 7'b1101101, 
	estado_5 = 7'b1011011,
	estado_7 = 7'b1110000,
	estado_3 = 7'b1111001,
	estado_A = 7'b1110111,
	estado_E = 7'b1001111,
	estado_8 = 7'b1111111,
	estado_0 = 7'b1111110,
	estado_B = 7'b0011111,
	estado_4 = 7'b0110011,
	estado_6 = 7'b1011111,
	estado_D = 7'b0111101,
	estado_F = 7'b1000111,
	estado_1 = 7'b0110000,
	estado_C = 7'b1001110,
	estado_9 = 7'b1111011;
	
	always_comb begin
		case(estado_atual)
			estado_2 : OUT <= estado_2;
			estado_5 : OUT <= estado_5;
			estado_7 : OUT <= estado_7;
			estado_3 : OUT <= estado_3;
			estado_A : OUT <= estado_A;
			estado_E : OUT <= estado_E;
			estado_8 : OUT <= estado_8;
			estado_0 : OUT <= estado_0;
			estado_B : OUT <= estado_B;
			estado_4 : OUT <= estado_4;
			estado_6 : OUT <= estado_6;
			estado_D : OUT <= estado_D;
			estado_F : OUT <= estado_F;
			estado_1 : OUT <= estado_1;
			estado_C : OUT <= estado_C;
			estado_9 : OUT <= estado_9;
		endcase
	end
	
	always_ff @ (posedge clk, negedge reset) begin
		if(~reset) begin
			estado_atual <= estado_2;
		end
		
		else begin
			if(modo == 1) begin
				case(estado_atual)
					estado_2 : estado_atual <= estado_5;
					estado_5 : estado_atual <= estado_7;
					estado_7 : estado_atual <= estado_3;			
					estado_3 : estado_atual <= estado_A;
					estado_A : estado_atual <= estado_E;		
					estado_E : estado_atual <= estado_8;		
					estado_8 : estado_atual <= estado_0;	
					estado_0 : estado_atual <= estado_B;	
					estado_B : estado_atual <= estado_4;
					estado_4 : estado_atual <= estado_6;
					estado_6 : estado_atual <= estado_D;	
					estado_D : estado_atual <= estado_F;
					estado_F : estado_atual <= estado_1;
					estado_1 : estado_atual <= estado_C;
					estado_C : estado_atual <= estado_9;
					estado_9 : estado_atual <= estado_2;
				endcase
			end
			
			else begin
				case(estado_atual)
					estado_9 : estado_atual <= estado_C;
					estado_C : estado_atual <= estado_1;
					estado_1 : estado_atual <= estado_F;
					estado_F : estado_atual <= estado_D;
					estado_D : estado_atual <= estado_6;
					estado_6 : estado_atual <= estado_4;
					estado_4 : estado_atual <= estado_B;
					estado_B : estado_atual <= estado_0;
					estado_0 : estado_atual <= estado_8;
					estado_8 : estado_atual <= estado_E;
					estado_E : estado_atual <= estado_A;
					estado_A : estado_atual <= estado_3;
					estado_3 : estado_atual <= estado_7;
					estado_7 : estado_atual <= estado_5;
					estado_5 : estado_atual <= estado_2;
					estado_2 : estado_atual <= estado_9;
				endcase
			end
		end
	end
	
endmodule