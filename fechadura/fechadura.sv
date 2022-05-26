module fechadura( X,LedVermelho,LedVerde,clock);
	output reg  LedVermelho,LedVerde;
	input X, clock;
	reg [1:0]estado_atual;
	reg [5:0]senha;
	reg [2:0]count;

	parameter INATIVO = 0, ERRO = 1, ABERTO = 2;
	
	always_comb begin
		case(estado_atual)
			INATIVO: begin
				LedVermelho <= 0;LedVerde <= 0;
			end
			
			ERRO: begin
				LedVermelho <= 1;LedVerde <= 0;
			end
			
			ABERTO: begin
				LedVermelho <= 0; LedVerde <= 1;
			end
		 endcase
	end
	
	initial begin 
		count = 3'b000;
	end
	
	always_ff @ (posedge clock)begin
		case(count)
			3'b000 : senha[5] = X;
			3'b001 : senha[4] = X;
			3'b010 : senha[3] = X;
			3'b011 : senha[2] = X;
			3'b100 : senha[1] = X;
			3'b101 : senha[0] = X;
		endcase
		
		if(count == 3'b110)
			count = 3'b000;
			
		case(estado_atual)
			ABERTO: estado_atual <= INATIVO;
			
			ERRO : estado_atual <= INATIVO;
			
			INATIVO : begin
				if(count === 3'b101) begin
					if(senha === 6'b101100)
						estado_atual <= ABERTO;
					else
						estado_atual <= ERRO;
				end
			
				else 
					estado_atual <= INATIVO;
				count = count + 3'b001;
			end
		endcase
	end		
			
endmodule